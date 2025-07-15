import 'package:flutter/material.dart';

// 색상 팔레트
import 'package:taekwon/decoration/color_palette.dart';

class CustomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: tabColor,
      unselectedItemColor: detailColor,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_outlined), label: '포인트 샵'),
        BottomNavigationBarItem(icon: Icon(Icons.calendar_today_rounded), label: '공지사항'),
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '홈'),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: '마이페이지')
      ]
      );
  }
}