import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:taekwon/decoration/color_palette.dart';
import 'package:taekwon/notification/notification_screen.dart';

class AttendanceHistoryScreen extends StatefulWidget {
  const AttendanceHistoryScreen({super.key});

  @override
  State<AttendanceHistoryScreen> createState() =>
      _AttendanceHistoryScreenState();
}

class _AttendanceHistoryScreenState extends State<AttendanceHistoryScreen> {
  DateTime _focusedDay = DateTime(2025, 8, 17);
  DateTime? _selectedDay;

  // 출결 임시 데이터
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

  DateTime _dateOnly(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  ///
  Color? _getBarColor(String? status) {
    switch (status) {
      case "출석":
        return Colors.green;
      case "지각":
        return Colors.orangeAccent;
      case "결석":
        return Colors.redAccent;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // 이번 달 출결 요약 계산식
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
          // 상단&알림박스
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
                    onPressed: () => Navigator.pop(context),
                    splashRadius: 24,
                  ),
                  const Text(
                    '출결 내역',
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
            top: screenHeight * 0.18,
            left: screenWidth * 0.08,
            right: screenWidth * 0.08,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // 이번 달 출결 요약 카드
                  Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "이번 달 수업 $totalClasses회",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("출석 $attend회"),
                              Text("지각 $late회"),
                              Text("결석 $absent회"),
                              Text("미정 $undecided회"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),

                  // ✅ 달력 카드 (흰색 박스)
                  Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: TableCalendar(
                        firstDay: DateTime.utc(2025, 1, 1),
                        lastDay: DateTime.utc(2025, 12, 31),
                        focusedDay: _focusedDay,
                        selectedDayPredicate: (day) =>
                            isSameDay(day, _selectedDay),
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            _selectedDay = selectedDay;
                            _focusedDay = focusedDay;
                          });
                        },
                        headerStyle: const HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: true,
                        ),
                        calendarFormat: CalendarFormat.month,

                        // ✅ 날짜 셀 커스터마이즈
                        calendarBuilders: CalendarBuilders(
                          defaultBuilder: (context, date, _) {
                            final key = _dateOnly(date);
                            final status = _attendanceData[key];
                            final color = _getBarColor(status);

                            return Stack(
                              children: [
                                Center(
                                  child: Text(
                                    '${date.day}',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                                if (color != null)
                                  Positioned(
                                    bottom: 4,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      height: 3,
                                      color: color,
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                      ),
                                    ),
                                  ),
                              ],
                            );
                          },
                          selectedBuilder: (context, date, _) {
                            final key = _dateOnly(date);
                            final status = _attendanceData[key];
                            final color = _getBarColor(status);

                            return Stack(
                              children: [
                                Center(
                                  child: Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      color: Colors.red.shade100,
                                      shape: BoxShape.circle,
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${date.day}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                if (color != null)
                                  Positioned(
                                    bottom: 4,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      height: 3,
                                      color: color,
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                      ),
                                    ),
                                  ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ✅ 선택된 날짜 카드 (흰색 박스)
                  if (_selectedDay != null)
                    Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
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
                              _attendanceData[_dateOnly(_selectedDay!)] ??
                                  "정보 없음",
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                          ],
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
    );
  }
}
