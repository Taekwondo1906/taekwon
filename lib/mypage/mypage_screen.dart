import 'package:flutter/material.dart';
// 색상 팔레트
import 'package:taekwon/decoration/color_palette.dart';
import 'package:taekwon/mypage/mypage_navigator.dart'; // <-- 네비게이터 키 사용
import 'package:taekwon/notification/notification_screen.dart'; // 알림 화면

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Container(color: Colors.white),
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
          // 상단 제목 + 알림 버튼
          Positioned(
            top: screenHeight * 0.1,
            left: screenWidth * 0.08, // 홈과 동일
            right: screenWidth * 0.08,
            child: Material(
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '마이페이지',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'inter',
                      fontWeight: FontWeight.w600,
                      height: 0.92,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.notifications_outlined,
                      color: Colors.white,
                      size: 28,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NotificationScreen(),
                        ),
                      );
                    },
                    splashRadius: 24,
                  ),
                ],
              ),
            ),
          ),
          // 콘텐츠 영역
          Positioned.fill(
            top: screenHeight * 0.18, // 홈과 동일 비율
            left: screenWidth * 0.08, // 홈과 동일
            right: screenWidth * 0.08,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // 프로필 카드
                  Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.grey,
                            child: Icon(
                              Icons.person,
                              size: 28,
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
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '칭호',
                                  style: TextStyle(
                                    color: mainColor,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '흰 띠  ·  500 포인트',
                                  style: TextStyle(fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              '학생',
                              style: TextStyle(color: mainColor, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40), // 홈과 동일 간격
                  // 기능 카드
                  Card(
                    color: Colors.white,
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
                  const SizedBox(height: 40), // 마지막 카드 아래 여백
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 메뉴 아이템 위젯
  Widget _buildMenuItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        if (title == '칭호 관리') {
          myPageNavigatorKey.currentState?.pushNamed('/title-manage');
        } else if (title == '포인트 사용 내역') {
          myPageNavigatorKey.currentState?.pushNamed('/point-history');
        } else {
          // TODO: 출결 내역 페이지 연결
        }
      },
    );
  }

  Widget _buildDivider() {
    return const Divider(height: 1, thickness: 1);
  }
}
