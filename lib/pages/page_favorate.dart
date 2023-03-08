import 'package:flutter/material.dart';
import 'package:search_image/kakap_api.dart';
import 'package:search_image/search_widget/search_bloc.dart';
import 'package:search_image/search_widget/search_state.dart';

class PageFavorate extends StatefulWidget {
  const PageFavorate({super.key});

  @override
  _PageFavorateState createState() => _PageFavorateState();
}

class _PageFavorateState extends State<PageFavorate> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text("Page Favorate"));
  }
}
