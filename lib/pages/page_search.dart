import 'package:flutter/material.dart';
import 'package:search_image/define/global_define.dart';

import 'package:search_image/kakap_api.dart';
import 'package:search_image/search_widget/search_bloc.dart';
import 'package:search_image/search_widget/search_result_widget.dart';
import 'package:search_image/search_widget/search_state.dart';

class PageSearch extends StatefulWidget {
  final KakaoApi api;
  String latestSearch = '';
  PageSearch({Key? key, required this.api}) : super(key: key);

  @override
  PageSearchState createState() => PageSearchState();
}

class PageSearchState extends State<PageSearch> {
  late final SearchBloc bloc;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    bloc = SearchBloc(widget.api);
    _textEditingController.text = widget.latestSearch;
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();

    widget.latestSearch = _textEditingController.text;
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SearchState>(
      stream: bloc.state,
      initialData: SearchNoTerm(),
      builder: (BuildContext context, AsyncSnapshot<SearchState> snapshot) {
        final state = snapshot.requireData;
        if (_textEditingController.text.isEmpty == false) {
          bloc.onTextChanged.add(_textEditingController.text);
        }

        return Scaffold(
          body: Stack(
            children: <Widget>[
              Flex(direction: Axis.vertical, children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 4.0),
                  child: TextField(
                    autofocus: true,
                    controller: _textEditingController,
                    decoration: const InputDecoration(
                      labelText: GlobalDefine.imageSearch,
                      hintText: GlobalDefine.inputSearchWord,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    onChanged: bloc.onTextChanged.add,
                  ),
                ),
                Expanded(
                  child: _buildChild(state),
                )
              ])
            ],
          ),
        );
      },
    );
  }

  Widget _buildChild(SearchState state) {
    if (state is SearchNoTerm) {
      return const Text(GlobalDefine.inputSearchWord);
    } else if (state is SearchEmpty) {
      return const Text(GlobalDefine.notFound);
    } else if (state is SearchLoading) {
      return Container(
        alignment: FractionalOffset.center,
        child: const CircularProgressIndicator(),
      );
    } else if (state is SearchError) {
      return const Text(GlobalDefine.searchError);
    } else if (state is SearchPopulated) {
      return SearchResultWidget(items: state.result.items);
    }

    throw Exception('${state.runtimeType} is not supported');
  }
}
