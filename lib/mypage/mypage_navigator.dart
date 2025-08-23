import 'package:flutter/material.dart';
import 'package:taekwon/mypage/mypage_screen.dart';
import 'package:taekwon/mypage/point_history_screen.dart';
import 'package:taekwon/mypage/title_manage_screen.dart';
import 'package:taekwon/mypage/attendance_screen.dart'; // 출결 내역
import 'package:taekwon/navigation/navigation_bar.dart'; // ✅ 네비게이션 바 추가

final GlobalKey<NavigatorState> myPageNavigatorKey =
    GlobalKey<NavigatorState>();

class MyPageNavigator extends StatelessWidget {
  const MyPageNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
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
              page = const AttendanceHistoryScreen(); //만들어야 함
              break;
            default:
              throw Exception('Unknown route: ${settings.name}');
          }
          return MaterialPageRoute(builder: (_) => page, settings: settings);
        },
      ),
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: 3, // ✅ "마이페이지" 탭 강조
        onTap: (index) {
          if (index == 0) {
            // 포인트샵 화면으로 이동
          } else if (index == 1) {
            // 공지사항 화면으로 이동
          } else if (index == 2) {
            // 홈 화면으로 이동
          } else if (index == 3) {
            // 마이페이지 → 이미 MyPageNavigator니까 아무 동작 필요 없음
          }
        },
      ),
    );
  }
}
