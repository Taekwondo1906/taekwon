import 'package:flutter/material.dart';

// 색상 팔레트
import 'package:taekwon/decoration/color_palette.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // 하드코딩. 이후 데이터베이스 기반으로 변경
  String selectedFilter = '전체';

  List<Map<String, String>> notifications = [
    {'type': '공지', 'content': '오늘 8시 수업은 10분 늦게 시작합니다.', 'date': '2025.06.10.'},
    {'type': '행사', 'content': '오늘 8시 수업은 10분 늦게 시작합니다.', 'date': '2025.06.10.'},
    {'type': '공지', 'content': '오늘 9시 수업은 10분 늦게 시작합니다.', 'date': '2025.06.10.'},
    {
      'type': '공지',
      'content': '오늘 10시 수업은 10분 늦게 시작합니다.',
      'date': '2025.06.10.',
    },
    {'type': '행사', 'content': '여름맞이 워터파크', 'date': '2025.06.10.'},
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = selectedFilter == '전체'
        ? notifications
        : notifications.where((n) => n['type'] == selectedFilter).toList();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back),
                ),
                const SizedBox(width: 12,),
                Text(
                  '알림',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    height: 0.92,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: ['전체', '공지', '행사'].map((filter) {
                  final isSelected = selectedFilter == filter;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(filter),
                      selected: isSelected,
                      onSelected: (_) {
                        setState(() => selectedFilter = filter);
                      },
                      selectedColor: mainColor,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                      checkmarkColor: Colors.white,
                      backgroundColor: boxColor,
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 12),
            Divider(color: boxColor),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final item = filtered[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: shadowColor,
                          blurRadius: 5,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: boxColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            item['type']!,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['content']!,
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                item['date']!,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
