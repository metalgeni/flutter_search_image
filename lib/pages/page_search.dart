import 'package:flutter/material.dart';

import 'package:search_image/kakap_api.dart';
import 'package:search_image/search_widget/search_bloc.dart';
import 'package:search_image/search_widget/search_result_widget.dart';
import 'package:search_image/search_widget/search_state.dart';

class PageSearch extends StatefulWidget {
  final KakaoApi api;
  const PageSearch({Key? key, required this.api}) : super(key: key);

  @override
  _PageSearchState createState() => _PageSearchState();
}

class _PageSearchState extends State<PageSearch> {
  late final SearchBloc bloc;

  @override
  void initState() {
    super.initState();

    bloc = SearchBloc(widget.api);
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('빌드 서치>>>>');
    return StreamBuilder<SearchState>(
      stream: bloc.state,
      initialData: SearchNoTerm(),
      builder: (BuildContext context, AsyncSnapshot<SearchState> snapshot) {
        final state = snapshot.requireData;

        return Scaffold(
          body: Stack(
            children: <Widget>[
              Flex(direction: Axis.vertical, children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 4.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: '이미지 검색',
                      hintText: '검색어를 입력하세요...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    onChanged: bloc.onTextChanged.add,
                  ),
                ),
                Expanded(
                  // child: AnimatedSwitcher(
                  //   duration: const Duration(milliseconds: 300),
                  child: _buildChild(state),
                  //),
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
      return const Text("검색어를 입력하세요");
    } else if (state is SearchEmpty) {
      return const Text("결과 없음");
    } else if (state is SearchLoading) {
      return Container(
        alignment: FractionalOffset.center,
        child: const CircularProgressIndicator(),
      );
      CircularProgressIndicator();
    } else if (state is SearchError) {
      return const Text("검색 에러");
    } else if (state is SearchPopulated) {
      return SearchResultWidget(items: state.result.items);
    }

    throw Exception('${state.runtimeType} is not supported');
  }
}
