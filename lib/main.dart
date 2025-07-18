import 'package:flutter/material.dart';
// 각 페이지 import
import 'package:taekwon/home/home_screen.dart'; //  home_screen
import 'package:taekwon/login/login_screen.dart';
import 'package:taekwon/navigation/navigation_bar.dart'; // navigation_bar

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const MainScaffold());
  }
}

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});
  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const LoginPage(), //  포인트샵 화면...인데 확인차 로그인페이지를 넣어뒀어요!! 나중에 수정예정
    const Placeholder(), //  일정 화면
    const HomeScreen(), //  홈 화면
    const Placeholder(), //  마이페이지 화면
  ];

  void _onTap(int index) {
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
