import 'package:restaurian/data/model/category.dart';
import 'package:restaurian/data/model/customer_review.dart';
import 'package:restaurian/data/model/drink.dart';
import 'package:restaurian/data/model/food.dart';
import 'package:restaurian/data/model/menu.dart';
import 'package:restaurian/data/model/restaurant.dart';

const dummyRestaurantJsonOne = '''
    {
        "id": "rqdv5juczeskfw1e867",
        "name": "Melting Pot",
        "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...",
        "city": "Medan",
        "address": "Jln. Pandeglang no 19",
        "pictureId": "14",
        "categories": [
            {
                "name": "Italia"
            },
            {
                "name": "Modern"
            }
        ],
        "menus": {
            "foods": [
                {
                    "name": "Paket rosemary"
                },
                {
                    "name": "Toastie salmon"
                }
            ],
            "drinks": [
                {
                    "name": "Es krim"
                },
                {
                    "name": "Sirup"
                }
            ]
        },
        "rating": 4.2,
        "customerReviews": [
            {
                "name": "Ahmad",
                "review": "Tidak rekomendasi untuk pelajar!",
                "date": "13 November 2019"
            }
        ]
    }
    ''';

Restaurant dummyRestaurantOne = Restaurant(
  id: 'rqdv5juczeskfw1e867',
  name: 'Melting Pot',
  description:
      'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...',
  pictureId: '14',
  city: 'Medan',
  address: 'Jln. Pandeglang no 19',
  rating: 4.2,
  menus: Menu(
      foods: [Food(name: 'Paket rosemary'), Food(name: 'Toastie salmon')],
      drinks: [Drink(name: 'Es krim'), Drink(name: 'Sirup')]),
  categories: [Category(name: 'Italia'), Category(name: 'Modern')],
  customerReviews: [
    CustomerReview(
        name: 'Ahmad',
        review: 'Tidak rekomendasi untuk pelajar!',
        date: '13 November 2019')
  ],
);

String dummyRestaurantJsonTwo =
    '{"id":"s1knt6za9kkfw1e867","name":"Kafe Kita","description":"Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,","pictureId":"25","city":"Gorontalo","address":"Jln. Pustakawan no 9","rating":4}';

Restaurant dummyRestaurantTwo = Restaurant(
    id: 's1knt6za9kkfw1e867',
    name: 'Kafe Kita',
    description:
        'Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,',
    pictureId: '25',
    city: 'Gorontalo',
    address: 'Jln. Pustakawan no 9',
    rating: 4,
    menus: Menu(foods: [], drinks: []),
    categories: [],
    customerReviews: []);
