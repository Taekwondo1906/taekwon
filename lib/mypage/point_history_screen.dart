import 'package:flutter/material.dart';
import 'package:taekwon/decoration/color_palette.dart';
import 'package:taekwon/notification/notification_screen.dart';

class PointHistoryScreen extends StatefulWidget {
  const PointHistoryScreen({super.key});

  @override
  State<PointHistoryScreen> createState() => _PointHistoryScreenState();
}

class _PointHistoryScreenState extends State<PointHistoryScreen> {
  // 샘플 데이터
  final List<Map<String, dynamic>> pointHistory = [
    {
      "date": "2025 / 07 / 19",
      "items": [
        {"price": "45000원", "desc": "남은 포인트"},
        {"price": "45000원", "desc": "남은 포인트"},
      ],
    },
    {
      "date": "2025 / 07 / 05",
      "items": [
        {"price": "45000원", "desc": "남은 포인트"},
        {"price": "45000원", "desc": "남은 포인트"},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Container(color: Colors.white),
          Container(
            height: screenHeight * 0.3,
            decoration: const BoxDecoration(
              color: mainColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(55),
                bottomRight: Radius.circular(55),
              ),
            ),
          ),
          // 상단 타이틀 + 알림 버튼
          Positioned(
            top: screenHeight * 0.1,
            left: screenWidth * 0.07,
            right: screenWidth * 0.07,
            child: Material(
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 24,
                    ),
                    onPressed: () {
                      // 현재 화면을 종료하고 이전 화면으로 돌아갑니다.
                      Navigator.pop(context);
                    },
                    splashRadius: 24,
                  ),
                  const Text(
                    '포인트 사용 내역',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontFamily: 'inter',
                      fontWeight: FontWeight.w600,
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
          // 본문 영역
          Positioned.fill(
            top: screenHeight * 0.21,
            left: screenWidth * 0.08,
            right: screenWidth * 0.08,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 내 포인트 박스
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Text(
                    "현재 내 포인트 : 1000 포인트",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'inter',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // 포인트 사용 내역 리스트
                Expanded(
                  child: ListView.builder(
                    itemCount: pointHistory.length,
                    itemBuilder: (context, index) {
                      final history = pointHistory[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 12),
                          Text(
                            history["date"],
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Column(
                            children: (history["items"] as List)
                                .map<Widget>(
                                  (item) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 55,
                                          height: 55,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            border: Border.all(
                                              color: Colors.black12,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item["price"],
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              item["desc"],
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
