import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_image/kakap_api.dart';
import 'package:search_image/model/favorate.dart';

class SearchResultWidget extends StatelessWidget {
  final List<SearchResultItem> items;

  const SearchResultWidget({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            final item = items[index];

            return GestureDetector(
                onTap: () => showItem(context, item),
                child: Card(
                  color: Colors.blueGrey,
                  child: Container(
                    alignment: FractionalOffset.center,
                    margin: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: CachedNetworkImage(
                            imageUrl: item.image_url,
                            placeholder: (context, url) => Container(
                              alignment: FractionalOffset.center,
                              child: const CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) => Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.error_outline,
                                    color: Colors.red[300], size: 80.0),
                                Container(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: Text(
                                    '이미지 로딩 에러',
                                    style: TextStyle(
                                      color: Colors.red[300],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                            child: Text(
                          item.display_sitename,
                          overflow: TextOverflow.ellipsis,
                        )),
                        _AddButton(fav: item.image_url),
                      ],
                    ),
                  ),
                ));
          }),
    );
  }

  void showItem(BuildContext context, SearchResultItem item) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(title: Text('상세페이지')),
            resizeToAvoidBottomInset: false,
            body: Container(
              color: Colors.blueGrey,
              alignment: Alignment.center,
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                imageUrl: item.image_url,
                placeholder: (context, url) => Container(
                  alignment: FractionalOffset.center,
                  child: const CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.error_outline,
                        color: Colors.red[300], size: 80.0),
                    Container(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        '이미지 로딩 에러',
                        style: TextStyle(
                          color: Colors.red[300],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final String fav;
  const _AddButton({required this.fav});

  @override
  Widget build(BuildContext context) {
    var isFavorate = context.select<FavorateModel, bool>(
      (favNotifier) => favNotifier.favs.contains(fav),
    );
    var favNotifier = context.read<FavorateModel>();
    return ElevatedButton.icon(
        onPressed: isFavorate
            ? () => favNotifier.remove(fav)
            : () => favNotifier.add(fav),
        icon: isFavorate ? const Icon(Icons.remove) : const Icon(Icons.add),
        label: isFavorate ? const Text('삭제') : const Text('추가'));
  }
}
