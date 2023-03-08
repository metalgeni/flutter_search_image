import 'package:flutter/material.dart';
import 'package:search_image/kakap_api.dart';

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
          itemCount: 300,
          itemBuilder: (BuildContext context, int index) {
            final item = items[index];
            return GestureDetector(
                onTap: () => showItem(context, item),
                child: Card(
                  color: Colors.amber,
                  child: Container(
                    alignment: FractionalOffset.center,
                    margin: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          //margin: const EdgeInsets.only(right: 16.0),
                          child: Image.network(
                            item.image_url,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Text(
                          item.display_sitename,
                          overflow: TextOverflow.ellipsis,
                        )
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
                color: Colors.amber,
                alignment: Alignment.center,
                child: Image.network(
                  item.image_url,
                  fit: BoxFit.fill,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                )),
          );
        },
      ),
    );
  }
}
