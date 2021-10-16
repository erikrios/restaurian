import 'dart:isolate';
import 'dart:ui';

import 'package:restaurian/data/api/api_service.dart';
import 'package:restaurian/data/model/restaurant.dart';
import 'package:restaurian/data/model/restaurant_list_response.dart';
import 'package:restaurian/utils/notification_helper.dart';

import '../main.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _service;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._createObject();

  factory BackgroundService() {
    _service ??= BackgroundService._createObject();
    return _service!;
  }

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    final NotificationHelper _notificationHelper = NotificationHelper();
    RestaurantListResponse response = await ApiService().getRestaurants();
    response.restaurants.shuffle();
    Restaurant restaurant = response.restaurants[0];
    await _notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, restaurant);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
