import 'package:flutter/material.dart';
import 'package:restaurian/common/styles.dart';
import 'package:restaurian/data/model/restaurant.dart';

class RestaurantDetailsPage extends StatelessWidget {
  static const routeName = "/restaurants/details";

  final Restaurant restaurant;

  const RestaurantDetailsPage({Key? key, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, isScroller) {
          return [
            SliverAppBar(
              pinned: true,
              expandedHeight: 200,
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  restaurant.pictureId,
                  fit: BoxFit.fitWidth,
                ),
                title: Text(
                  restaurant.name,
                  style: myTextTheme.headline6!.copyWith(
                    color: Colors.white,
                  ),
                ),
                titlePadding: const EdgeInsets.only(
                  left: 48.0,
                  bottom: 16.0,
                ),
              ),
            ),
          ];
        },
        body: ListView(
          children: [],
        ),
      ),
    );
  }
}
