import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_image/kakap_api.dart';
import 'package:search_image/model/favorate.dart';
import 'package:search_image/search_widget/search_bloc.dart';
import 'package:search_image/search_widget/search_state.dart';

class PageFavorate extends StatelessWidget {
  const PageFavorate({super.key});

  @override
  Widget build(BuildContext context) {
    var favNotifier = context.watch<FavorateModel>();

    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemCount: favNotifier.favs.length,
          itemBuilder: (BuildContext context, int index) {
            final fav_url = favNotifier.favs[index];

            return //GestureDetector(
                //onTap: () => showItem(context, fav_url),
                //child:
                Card(
              color: Colors.grey,
              child: Container(
                alignment: FractionalOffset.center,
                margin: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: CachedNetworkImage(
                        imageUrl: fav_url,
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
                    SizedBox(height: 5),
                    ElevatedButton.icon(
                        onPressed: () => favNotifier.remove(fav_url),
                        icon: const Icon(Icons.remove),
                        label: const Text('삭제')),
                  ],
                ),
              ),
            )
                //)
                ;
          }),
    );
  }
}
