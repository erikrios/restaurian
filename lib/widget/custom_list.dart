import 'package:flutter/material.dart';
import 'package:restaurian/common/styles.dart';
import 'package:restaurian/data/model/restaurant.dart';
import 'package:restaurian/ui/restaurant_details_page.dart';

class CustomList extends StatelessWidget {
  final List<Restaurant> restaurants;

  const CustomList({
    Key? key,
    required this.restaurants,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: restaurants.length,
      separatorBuilder: (context, index) {
        return const Divider(
          height: 2.0,
          color: Colors.grey,
        );
      },
      itemBuilder: (context, index) {
        Restaurant restaurant = restaurants[index];
        return _buildItemList(context, restaurant);
      },
    );
  }

  Widget _buildItemList(BuildContext context, Restaurant restaurant) {
    return ListTile(
      leading: Hero(
        tag: restaurant.id,
        child: CircleAvatar(
          backgroundImage: NetworkImage(
            restaurant.smallPictureUrl,
          ),
        ),
      ),
      title: Text(
        restaurant.name,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
        Navigator.pushNamed(
          context,
          RestaurantDetailsPage.routeName,
          arguments: restaurant.id,
        );
      },
      subtitle: Row(
        children: [
          Flexible(
            flex: 1,
            child: SizedBox(
              width: double.infinity,
              child: RichText(
                text: TextSpan(
                  children: [
                    const WidgetSpan(
                      child: Icon(
                        Icons.location_on,
                        size: 15.0,
                      ),
                    ),
                    TextSpan(
                      text: restaurant.city,
                      style: myTextTheme.subtitle2!.copyWith(
                        color: Colors.black,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: Icon(
                    restaurant.rating < 2.0
                        ? Icons.star_outline
                        : restaurant.rating < 4.0
                            ? Icons.star_half
                            : Icons.star,
                    size: 15.0,
                  ),
                ),
                TextSpan(
                  text: restaurant.rating.toString(),
                  style: myTextTheme.subtitle2!.copyWith(
                    color: Colors.black,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
