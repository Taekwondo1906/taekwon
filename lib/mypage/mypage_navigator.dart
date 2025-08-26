import 'package:flutter/material.dart';
import 'package:taekwon/mypage/mypage_screen.dart';
import 'package:taekwon/mypage/point_history_screen.dart';
import 'package:taekwon/mypage/title_manage_screen.dart';
import 'package:taekwon/mypage/attendance_screen.dart'; // 출결 내역

final GlobalKey<NavigatorState> myPageNavigatorKey =
    GlobalKey<NavigatorState>();

class MyPageNavigator extends StatelessWidget {
  const MyPageNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: myPageNavigatorKey,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        Widget page;
        switch (settings.name) {
          case '/':
            page = const MyPage();
            break;
          case '/point-history':
            page = const PointHistoryScreen();
            break;
          case '/title-manage':
            page = const TitleManageScreen();
            break;
          case '/attendance':
            page = const AttendanceHistoryScreen();
            break;
          default:
            throw Exception('Unknown route: ${settings.name}');
        }
        return MaterialPageRoute(builder: (_) => page, settings: settings);
      },
    );
  }
}
