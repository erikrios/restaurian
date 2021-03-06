import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:restaurian/common/styles.dart';
import 'package:restaurian/data/model/customer_review.dart';
import 'package:restaurian/data/model/drink.dart';
import 'package:restaurian/data/model/food.dart';
import 'package:restaurian/data/model/restaurant.dart';
import 'package:restaurian/data/model/restaurant_detail_response.dart';
import 'package:restaurian/provider/database_provider.dart';
import 'package:restaurian/provider/restaurant_detail_provider.dart';
import 'package:restaurian/utils/result_state.dart';

class RestaurantDetailsPage extends StatefulWidget {
  static const routeName = "/restaurants/details";

  final String restaurantId;

  const RestaurantDetailsPage({
    Key? key,
    required this.restaurantId,
  }) : super(key: key);

  @override
  State<RestaurantDetailsPage> createState() => _RestaurantDetailsPageState();
}

class _RestaurantDetailsPageState extends State<RestaurantDetailsPage> {
  @override
  void initState() {
    Future.microtask(() {
      RestaurantDetailProvider provider = Provider.of<RestaurantDetailProvider>(
        context,
        listen: false,
      );
      provider.getRestaurant(widget.restaurantId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantDetailProvider>(
      builder: (context, provider, _) {
        ResultState<RestaurantDetailResponse> state = provider.state;
        switch (state.status) {
          case Status.loading:
            return Scaffold(
              appBar: AppBar(
                title: const Text('Loading'),
              ),
              body: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          case Status.error:
            return Scaffold(
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(
                    16.0,
                  ),
                  child: Text(
                    state.message!,
                  ),
                ),
              ),
            );
          case Status.hasData:
            {
              Restaurant restaurant = state.data!.restaurant;
              DatabaseProvider databaseProvider =
                  Provider.of<DatabaseProvider>(context, listen: false);
              databaseProvider.isFavoriteExists(restaurant.id);
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
                          background: Hero(
                            tag: restaurant.id,
                            child: Image.network(
                              restaurant.mediumPictureUrl,
                              fit: BoxFit.fitWidth,
                            ),
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
                        actions: [
                          Consumer<DatabaseProvider>(
                            builder: (context, provider, _) => IconButton(
                              icon: provider.isFavorite
                                  ? const Icon(Icons.favorite)
                                  : const Icon(Icons.favorite_border),
                              onPressed: () {
                                if (provider.isFavorite) {
                                  databaseProvider
                                      .removeFavorite(restaurant.id);
                                  databaseProvider
                                      .isFavoriteExists(restaurant.id);
                                } else {
                                  databaseProvider.addFavorite(restaurant);
                                  databaseProvider
                                      .isFavoriteExists(restaurant.id);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ];
                  },
                  body: ListView(
                    padding: const EdgeInsets.all(
                      16.0,
                    ),
                    children: [
                      _buildRating(
                        restaurant.rating.toDouble(),
                      ),
                      _buildLocation(
                        restaurant.address,
                        restaurant.city,
                      ),
                      const Divider(
                        height: 12.0,
                        color: Colors.transparent,
                      ),
                      _buildDescription(
                        restaurant.description,
                      ),
                      const Divider(
                        height: 12.0,
                        color: Colors.transparent,
                      ),
                      Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: _buildAvailableFoods(
                              context,
                              restaurant.menus.foods,
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: _buildAvailableDrinks(
                              context,
                              restaurant.menus.drinks,
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        height: 22.0,
                        color: Colors.transparent,
                      ),
                      Center(
                        child: _buildCustomerReviews(
                            context, restaurant.customerReviews),
                      ),
                    ],
                  ),
                ),
              );
            }
        }
      },
    );
  }

  Widget _buildRating(double rating) {
    return RichText(
      text: TextSpan(
        children: [
          WidgetSpan(
            child: Icon(
              rating < 2.0
                  ? Icons.star_outline
                  : rating < 4.0
                      ? Icons.star_half
                      : Icons.star,
              size: 30.0,
            ),
          ),
          const WidgetSpan(
            child: SizedBox(
              width: 12.0,
            ),
          ),
          TextSpan(
            text: rating.toString(),
            style: myTextTheme.headline4!.copyWith(
              overflow: TextOverflow.ellipsis,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocation(String location, String city) {
    return Text(
      'This restaurant is located in $location, $city.',
      maxLines: 2,
      style: myTextTheme.subtitle1!.copyWith(
        overflow: TextOverflow.ellipsis,
        color: Colors.black54,
      ),
    );
  }

  Widget _buildDescription(String description) {
    return Text(
      description,
      textAlign: TextAlign.justify,
      style: myTextTheme.subtitle2!.copyWith(
        color: Colors.black,
      ),
    );
  }

  Widget _buildAvailableFoods(BuildContext context, List<Food> foods) {
    return Center(
      child: Column(
        children: [
          Text(
            'Available foods.',
            textAlign: TextAlign.center,
            style: myTextTheme.subtitle1!.copyWith(
              color: Colors.black54,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.fastfood,
              size: 50.0,
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return ListView.builder(
                    itemCount: foods.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const Icon(Icons.fastfood),
                        title: Text(
                          foods[index].name,
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAvailableDrinks(BuildContext context, List<Drink> drinks) {
    return Center(
      child: Column(
        children: [
          Text(
            'Available drinks.',
            textAlign: TextAlign.center,
            style: myTextTheme.subtitle1!.copyWith(
              color: Colors.black54,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.emoji_food_beverage_sharp,
              size: 50.0,
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return ListView.builder(
                    itemCount: drinks.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const Icon(Icons.emoji_food_beverage_sharp),
                        title: Text(
                          drinks[index].name,
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerReviews(
      BuildContext context, List<CustomerReview> reviews) {
    return Center(
      child: Column(
        children: [
          Text(
            'Customer reviews.',
            textAlign: TextAlign.center,
            style: myTextTheme.subtitle1!.copyWith(
              color: Colors.black54,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.person,
              size: 50.0,
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return ListView.builder(
                    itemCount: reviews.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const Icon(Icons.person),
                        title: Text(
                          reviews[index].review,
                        ),
                        subtitle: Text(
                            '${reviews[index].name} on ${reviews[index].date}'),
                      );
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
