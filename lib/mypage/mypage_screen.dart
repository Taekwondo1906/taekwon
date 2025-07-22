//마이페이지 화면

import 'package:flutter/material.dart';
// 색상 팔레트
import 'package:taekwon/decoration/color_palette.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(color: Colors.white),
          Container(
            height: screenHeight * 0.35,
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
              children: const [
                Text(
                  '마이페이지',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Icon(Icons.notifications_none, color: Colors.white, size: 28),
              ],
            ),
          ),
          Positioned.fill(
            top: 120,
            child: Column(
              children: [
                // 프로필 카드
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.grey,
                            child: Icon(
                              Icons.person,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  '김철수 (1234)',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('칭호', style: TextStyle(color: mainColor)),
                                SizedBox(height: 4),
                                Text('흰 띠   500 포인트'),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              '학생',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // 기능 카드
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 4,
                    child: Column(
                      children: [
                        _buildMenuItem(Icons.military_tech, '칭호 관리'),
                        _buildDivider(),
                        _buildMenuItem(Icons.attach_money, '포인트 사용 내역'),
                        _buildDivider(),
                        _buildMenuItem(Icons.calendar_today, '출결 내역'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        // 추후 네비게이션 구현
      },
    );
  }

  Widget _buildDivider() {
    return const Divider(height: 1, thickness: 1);
  }
}
