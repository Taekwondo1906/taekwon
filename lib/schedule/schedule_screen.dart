import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:taekwon/decoration/color_palette.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  DateTime _focusedDay = DateTime(2025, 8, 17);
  DateTime? _selectedDay;

  // ---------- 다이얼로그 열기 ----------
  void _openAddScheduleDialog() {
    // 포커스된 날짜/시간을 초기값으로 사용
    int selYear = _focusedDay.year;
    int selMonth = _focusedDay.month;
    int selDay = _focusedDay.day;
    int selHour = _focusedDay.hour;

    // 체크 항목(상태 유지)
    final items = <_CheckItem>[
      _CheckItem(title: '발차기', point: 20, checked: true),
      _CheckItem(title: '품새', point: 20),
      _CheckItem(title: '체력단련', point: 10),
    ];

    int daysInMonth(int year, int month) {
      final first = DateTime(year, month, 1);
      final firstNext = DateTime(year, month + 1, 1);
      return firstNext.subtract(const Duration(days: 1)).day;
    }

    // 하단 휠 피커 (월/일/시/포인트 공용)
    Future<void> showWheelPicker({
      required String title,
      required List<String> items,
      required int initialIndex,
      required ValueChanged<int> onSelectedIndex,
    }) async {
      int tempIndex = initialIndex;

      await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (_) {
          return SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  child: Row(
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          onSelectedIndex(tempIndex);
                          Navigator.pop(context);
                        },
                        child: const Text('완료'),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                SizedBox(
                  height: 220,
                  child: CupertinoPicker(
                    itemExtent: 36,
                    magnification: 1.08,
                    squeeze: 1.15,
                    useMagnifier: true,
                    scrollController: FixedExtentScrollController(
                      initialItem: initialIndex,
                    ),
                    onSelectedItemChanged: (i) => tempIndex = i,
                    children: items
                        .map(
                          (e) => Center(
                            child: Text(
                              e,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 24,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.white,
          child: StatefulBuilder(
            builder: (context, setLocal) {
              final monthLabel = '$selMonth월';
              final dayLabel = '$selDay일';
              final hourLabel = '$selHour시';

              // 공용 스타일
              BoxDecoration chipBg([bool pressed = false]) => BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0x22000000)),
                boxShadow: pressed
                    ? const [
                        BoxShadow(
                          color: Color(0x12000000),
                          blurRadius: 4,
                          offset: Offset(0, 1),
                        ),
                      ]
                    : null,
              );

              Widget pillButton(String text, VoidCallback onTap) {
                return InkWell(
                  borderRadius: BorderRadius.circular(24),
                  onTap: onTap,
                  child: Container(
                    decoration: chipBg(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 9,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      text,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                );
              }

              return ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 제목 + 좌측 파란 언더라인
                      Row(
                        children: [
                          const Text(
                            '일정 추가',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Stack(
                        children: [
                          const Divider(height: 1),
                          // 좌측만 파란 밑줄 느낌
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              height: 2,
                              width: 44,
                              color: mainColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // 날짜 선택 라인 (이미지 스타일)
                      Row(
                        children: [
                          // '날짜 선택' 작은 칩
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            decoration: chipBg(),
                            child: const Text(
                              '날짜 선택',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: pillButton(monthLabel, () async {
                              final months = List.generate(
                                12,
                                (i) => '${i + 1}월',
                              );
                              await showWheelPicker(
                                title: '월 선택',
                                items: months,
                                initialIndex: selMonth - 1,
                                onSelectedIndex: (idx) {
                                  setLocal(() {
                                    selMonth = idx + 1;
                                    final maxD = daysInMonth(selYear, selMonth);
                                    if (selDay > maxD) selDay = maxD;
                                  });
                                },
                              );
                            }),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: pillButton(dayLabel, () async {
                              final maxD = daysInMonth(selYear, selMonth);
                              final days = List.generate(
                                maxD,
                                (i) => '${i + 1}일',
                              );
                              await showWheelPicker(
                                title: '일 선택',
                                items: days,
                                initialIndex: selDay - 1,
                                onSelectedIndex: (idx) =>
                                    setLocal(() => selDay = idx + 1),
                              );
                            }),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: pillButton(hourLabel, () async {
                              final hours = List.generate(24, (i) => '$i시');
                              await showWheelPicker(
                                title: '시간 선택',
                                items: hours,
                                initialIndex: selHour.clamp(0, 23),
                                onSelectedIndex: (idx) =>
                                    setLocal(() => selHour = idx),
                              );
                            }),
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      // 체크 리스트 (이미지 스타일)
                      ...items.map(
                        (it) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: _TaskRowCard(
                            title: it.title,
                            point: it.point,
                            checked: it.checked,
                            onToggle: () =>
                                setLocal(() => it.checked = !it.checked),
                            onEditPoint: () async {
                              final points = List.generate(101, (i) => '$i포인트');
                              final initial = it.point.clamp(0, 100);
                              await showWheelPicker(
                                title: '포인트 선택',
                                items: points,
                                initialIndex: initial,
                                onSelectedIndex: (idx) =>
                                    setLocal(() => it.point = idx),
                              );
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: 2),

                      // + 늘려서 항목 추가하기 (파란 꽉 찬 버튼)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            setLocal(() {
                              items.add(_CheckItem(title: '새 항목', point: 5));
                            });
                          },
                          icon: const Icon(Icons.add),
                          label: const Text('늘려서 항목 추가하기'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: mainColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),

                      const SizedBox(height: 14),

                      // 하단 액션 (적용/취소) : 적용=파란 필, 취소=회색칩
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // 적용
                          ElevatedButton(
                            onPressed: () {
                              // TODO: 선택값 저장 로직 연결
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: mainColor,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 10,
                              ),
                              elevation: 0,
                            ),
                            child: const Text('적용'),
                          ),
                          const SizedBox(width: 8),
                          // 취소 (회색 배경 칩)
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.black54,
                              backgroundColor: const Color(0xFFF2F4F7),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                            ),
                            child: const Text('취소'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final weekdayNames = ['일', '월', '화', '수', '목', '금', '토'];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        title: const Padding(
          padding: EdgeInsets.only(left: 23),
          child: Text(
            "일정",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 29),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 8),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 날짜 + 일정 추가 버튼
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: "2025\n",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text:
                                  "${_focusedDay.month}월 ${_focusedDay.day}일 ${weekdayNames[_focusedDay.weekday % 7]}요일",
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _openAddScheduleDialog,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: mainColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                        ),
                        child: const Text("일정 추가"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
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
                    calendarStyle: CalendarStyle(
                      todayDecoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: mainColor, width: 2),
                        color: Colors.transparent,
                      ),
                      todayTextStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      selectedDecoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: mainColor,
                      ),
                    ),
                    headerVisible: false,
                    calendarFormat: CalendarFormat.month,
                    daysOfWeekVisible: true,
                    startingDayOfWeek: StartingDayOfWeek.sunday,
                  ),
                ],
              ),
            ),

            // 출결 카드 (그대로)
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "출결 확인",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "김영희 사범님 / 화요일 17:00 ~ 20:00",
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mainColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                      ),
                      child: const Text("출석 체크"),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

/// ---------------- 모델 ----------------
class _CheckItem {
  final String title;
  int point;
  bool checked;
  _CheckItem({required this.title, required this.point, this.checked = false});
}

/// --------------- 체크 항목 카드(이미지와 동일한 톤) ---------------
class _TaskRowCard extends StatelessWidget {
  final String title;
  final int point;
  final bool checked;
  final VoidCallback onToggle;
  final VoidCallback onEditPoint;

  const _TaskRowCard({
    required this.title,
    required this.point,
    required this.checked,
    required this.onToggle,
    required this.onEditPoint,
  });

  @override
  Widget build(BuildContext context) {
    // 카드 컨테이너
    final card = Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0x22000000)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        children: [
          // 커스텀 체크 (이미지 스타일)
          InkWell(
            onTap: onToggle,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                color: checked ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: checked ? Colors.black : const Color(0x33000000),
                  width: 2,
                ),
              ),
              child: checked
                  ? const Center(
                      child: Icon(Icons.check, size: 18, color: Colors.black),
                    )
                  : null,
            ),
          ),
          const SizedBox(width: 12),

          // 제목
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: checked ? FontWeight.w700 : FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),

          // 포인트 배지(회색 칩, 탭 가능)
          InkWell(
            onTap: onEditPoint,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFF2F4F7),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0x22000000)),
              ),
              child: Text(
                '$point포인트',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );

    // 전체를 탭해도 토글 (이미지와 같은 UX)
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onToggle,
        child: card,
      ),
    );
  }
}
