import 'package:flutter/material.dart';
import 'package:taekwon/decoration/color_palette.dart';
import 'package:taekwon/notification/notification_screen.dart';
import 'package:taekwon/mypage/mypage_navigator.dart';

class TitleManageScreen extends StatelessWidget {
  const TitleManageScreen({super.key});

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
          // ✅ 홈 화면 스타일과 동일한 헤더
          Positioned(
            top: screenHeight * 0.1,
            left: screenWidth * 0.07,
            right: screenWidth * 0.07,
            child: Material(
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '칭호 관리',
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
          // ✅ 콘텐츠 위치 조정 (홈과 동일)
          Positioned.fill(
            top: screenHeight * 0.18,
            left: screenWidth * 0.08,
            right: screenWidth * 0.08,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // 현재 대표 칭호 카드
                  Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '현재 대표 칭호',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: labelColor,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '태권도 새싹',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: mainColor,
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: const BorderSide(color: mainColor),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                            ),
                            child: const Text(
                              '변경',
                              style: TextStyle(
                                color: mainColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  // 내 칭호 카드
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              '내 칭호',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: labelColor,
                              ),
                            ),
                            SizedBox(height: 12),
                            Text('발차기 입문자', style: TextStyle(fontSize: 15)),
                            SizedBox(height: 8),
                            Text('발차기 수련자', style: TextStyle(fontSize: 15)),
                            SizedBox(height: 8),
                            Text('성실왕', style: TextStyle(fontSize: 15)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
      // ✅ 하단 네비게이션 바 추가
      //bottomNavigationBar: BottomNavigationBar(
      //  currentIndex: 3, // '마이페이지' 탭이 선택되어 있다고 가정
      //  selectedItemColor: tabColor,
      //  unselectedItemColor: detailColor,
      //  showSelectedLabels: false,
      //  showUnselectedLabels: false,
      //  type: BottomNavigationBarType.fixed,
      //  onTap: (index) {
      //    // 여기에 탭 이동 처리 로직 추가
      //    // 예: Navigator.push(context, MaterialPageRoute(builder: (_) => SomeScreen()));
      //  },
      //  items: const [
      //    BottomNavigationBarItem(
      //      icon: Icon(Icons.shopping_cart_outlined),
      //      label: '포인트 샵',
      //    ),
      //    BottomNavigationBarItem(
      //      icon: Icon(Icons.calendar_today_rounded),
      //      label: '공지사항',
      //    ),
      //    BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '홈'),
      //    BottomNavigationBarItem(
      //      icon: Icon(Icons.person_outline),
      //      label: '마이페이지',
      //    ),
      //  ],
      //),
    );
  }
}
