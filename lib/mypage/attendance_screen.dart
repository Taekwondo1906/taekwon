import 'package:flutter/material.dart';
import 'package:taekwon/decoration/color_palette.dart';
import 'package:taekwon/notification/notification_screen.dart';
import 'package:taekwon/mypage/mypage_navigator.dart';
// 캘린더
import 'package:table_calendar/table_calendar.dart';

class AttendanceHistoryScreen extends StatefulWidget {
  const AttendanceHistoryScreen({super.key});

  @override
  State<AttendanceHistoryScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceHistoryScreen> {
  DateTime _focusedDay = DateTime(2025, 8, 17);
  DateTime? _selectedDay;

  // 출결 데이터 (예시임)
  final Map<DateTime, String> _attendanceData = {
    DateTime(2025, 8, 2): "결석",
    DateTime(2025, 8, 3): "출석",
    DateTime(2025, 8, 5): "미정",
    DateTime(2025, 8, 7): "출석",
    DateTime(2025, 8, 10): "지각",
    DateTime(2025, 8, 14): "출석",
    DateTime(2025, 8, 17): "결석",
    DateTime(2025, 8, 21): "미정",
    DateTime(2025, 8, 24): "미정",
  };

  // 출결별 색상 매핑
  Color? _getDotColor(String? status) {
    switch (status) {
      case "출석":
        return Colors.blue;
      case "결석":
        return Colors.red;
      case "지각":
        return Colors.yellow;
      case "미정":
        return Colors.grey;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // 이번 달 출결 요약 계산
    final currentMonthData = _attendanceData.entries
        .where(
          (e) =>
              e.key.year == _focusedDay.year &&
              e.key.month == _focusedDay.month,
        )
        .map((e) => e.value)
        .toList();

    int totalClasses = currentMonthData.length;
    int attend = currentMonthData.where((s) => s == "출석").length;
    int absent = currentMonthData.where((s) => s == "결석").length;
    int late = currentMonthData.where((s) => s == "지각").length;
    int undecided = currentMonthData.where((s) => s == "미정").length;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "출석 내역",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 8),

            // 이번 달 출결 요약 카드
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 8),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "이번달 수업 $totalClasses회",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "출석: $attend회 | 지각: $late회 | 결석: $absent회 | 미정: $undecided회",
                    style: const TextStyle(color: Colors.black87, fontSize: 14),
                  ),
                ],
              ),
            ),

            // 달력 카드
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 8),
                ],
              ),
              child: Column(
                children: [
                  TableCalendar(
                    firstDay: DateTime.utc(2025, 1, 1),
                    lastDay: DateTime.utc(2025, 12, 31),
                    focusedDay: _focusedDay,
                    selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    },
                    calendarFormat: CalendarFormat.month,
                    daysOfWeekVisible: true,
                    startingDayOfWeek: StartingDayOfWeek.sunday,
                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                    ),
                    calendarBuilders: CalendarBuilders(
                      markerBuilder: (context, date, events) {
                        final status = _attendanceData[date];
                        final color = _getDotColor(status);
                        if (color == null) return null;
                        return Positioned(
                          bottom: 4,
                          child: Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // 선택한 날짜 출결 상태
            if (_selectedDay != null)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 8),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${_selectedDay!.year}년 ${_selectedDay!.month}월 ${_selectedDay!.day}일",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      _attendanceData[_selectedDay!] ?? "정보 없음",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
