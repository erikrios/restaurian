import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurian/provider/preferences_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Material(
              child: ListTile(
                title: const Text(
                  'Restaurant Notification',
                ),
                subtitle: const Text(
                  'Recommendation restaurant for you',
                ),
                trailing: Consumer<PreferencesProvider>(
                  builder: (context, provider, _) {
                    return Switch.adaptive(
                      value: provider.isDailyRestaurantActive,
                      onChanged: (value) =>
                          provider.enableDailyRestaurant(value),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
