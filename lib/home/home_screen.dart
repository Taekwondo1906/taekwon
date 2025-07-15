// 홈 화면
import 'package:flutter/material.dart';
// 색상 팔레트
import 'package:taekwon/decoration/color_palette.dart';
// 위젯
import 'package:taekwon/home/home_widgets/home_announcement.dart';  // 공지사항
import 'package:taekwon/home/home_widgets/home_today_schedule.dart';  // 오늘 일정

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // 화면 높이
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.white,
          ),
          Container(
            height: screenHeight * 0.4,
            decoration: const BoxDecoration(
              color: mainColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(55),
                bottomRight: Radius.circular(55),
              ),
            ),
          ),
          Positioned(
            top: 60,
            left: 24,
            right: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '태권도장 이름', // 추후 데이터베이스 반영
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'inter',
                    fontWeight: FontWeight.w600,
                    height: 0.92,
                  ),
                ),
                Icon(
                  Icons.notifications_outlined,
                  color: Colors.white,
                  size: 28,
                ),
              ],
            ),),
          Positioned.fill(
            top: 120,
            left: 35,
            right: 35,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  HomeTodaySchedule(),
                  SizedBox(
                    height: 50,
                  ),
                  HomeAnnouncement()
                ]
              ),
            ),
          ),
        ],
      ),
    );
  }
}
