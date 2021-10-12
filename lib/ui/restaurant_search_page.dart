import 'dart:async';

import 'package:flutter/material.dart';

class RestaurantSearchPage extends StatelessWidget {
  static const routeName = '/restaurants/search';

  const RestaurantSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer? _debounce;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search',
        ),
      ),
      body: Column(
        children: [
          Flexible(
            flex: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 2.0,
                    horizontal: 8.0,
                  ),
                  label: Text(
                    'Search',
                  ),
                  hintText: 'Input the restaurant name or menu',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        16.0,
                      ),
                    ),
                  ),
                ),
                onChanged: (text) {
                  if (_debounce?.isActive ?? false) _debounce!.cancel();
                  _debounce = Timer(const Duration(milliseconds: 500), () {
                    if (text.isNotEmpty) {
                      // TODO call the api
                    }
                  });
                },
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
