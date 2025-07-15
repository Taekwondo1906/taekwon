import 'package:flutter/material.dart';
import 'package:taekwon/decoration/color_palette.dart';

class HomeTodaySchedule extends StatefulWidget {
  const HomeTodaySchedule({super.key});

  @override
  State<HomeTodaySchedule> createState() => _HomeTodayScheduleState();
}

class _HomeTodayScheduleState extends State<HomeTodaySchedule> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(19)),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 22.7,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 타이틀은 고정
          const Padding(
            padding: EdgeInsets.all(24.0),
            child: Text(
              '오늘의 일정',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                height: 1.10,
              ),
            ),
          ),

          // 일정 리스트만 스크롤
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [ // 추후 데이터베이스에서 불러오는 방식으로 변경
                  _buildScheduleRow('07:00 - 08:00', '초등부'),
                  _buildScheduleRow('08:30 - 09:30', '중등부'),
                  _buildScheduleRow('13:00 - 15:30', '입시반'),
                  _buildScheduleRow('17:10 - 19:10', '성인부'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 일정 줄 하나를 만드는 함수
  Widget _buildScheduleRow(String time, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.circle, color: iconColor, size: 20),
          Text(time),
          Container(
            decoration: BoxDecoration(
              color: labelColor,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                height: 1,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
