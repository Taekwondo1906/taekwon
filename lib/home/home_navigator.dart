import 'package:flutter/material.dart';
import 'package:taekwon/announcement/announcement_screen.dart';
import 'package:taekwon/home/home_screen.dart';

final GlobalKey<NavigatorState> homeNavigatorKey = GlobalKey<NavigatorState>();

class HomeNavigator extends StatelessWidget {
  const HomeNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: homeNavigatorKey,
      onGenerateRoute: (settings) {
        Widget page;
        switch (settings.name) {
          case '/':
            page = const HomeScreen();
            break;
          case '/announcement':
            page = const AnnouncementScreen();
            break;
          default:
            throw Exception('Unknown route: ${settings.name}');
        }
        return MaterialPageRoute(builder: (_) => page);
      },
    );
  }
}
