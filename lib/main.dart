import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// 구글 폰트 'Inter' 사용
import 'package:google_fonts/google_fonts.dart';
// 각 페이지 import
import 'package:taekwon/home/home_navigator.dart';
import 'package:taekwon/login/login_screen.dart';
import 'package:taekwon/mypage/mypage_navigator.dart';
import 'package:taekwon/navigation/navigation_bar.dart'; // navigation_bar
import 'package:taekwon/pointshop/regular_user/pointshop_regular.dart';
import 'package:taekwon/schedule/schedule_screen.dart'; // mypage navigation bar

void main() {
  // 사용자의 핸드폰 시스템 UI(상단바, 하단바)가 보이도록 설정
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.top],
  );

  runApp(
    // 부하 적은 에뮬레이터
    DevicePreview(enabled: !kReleaseMode, builder: (context) => const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // -----DevicePreview 설정-----
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      // ----------------------------
      theme: ThemeData(textTheme: GoogleFonts.interTextTheme()),
      home: const LoginPage(),
    );
  }
}

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});
  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 2;

  final List<Widget> _screens = [
    const PointShopRegularPage(), //  포인트샵 화면
    const SchedulePage(), //  일정 화면
    const HomeNavigator(), //  홈 화면
    const MyPageNavigator(), //  마이페이지 화면
  ];

  void _onTap(int index) {
    if (_currentIndex == index) {
      if (index == 2) {
        homeNavigatorKey.currentState?.popUntil((route) => route.isFirst);
      }
    }
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }
}
