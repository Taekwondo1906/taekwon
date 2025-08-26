// 쓰는파일2

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taekwon/decoration/color_palette.dart';

// 경로는 프로젝트 구조에 맞게 수정하세요.
import 'add_student.dart';

class AddScheduleDialog extends StatefulWidget {
  final DateTime initialDateTime;

  const AddScheduleDialog({super.key, required this.initialDateTime});

  @override
  State<AddScheduleDialog> createState() => _AddScheduleDialogState();
}

class _AddScheduleDialogState extends State<AddScheduleDialog> {
  late int selYear;
  late int selMonth;
  late int selDay;
  late int selHour;

  int? _attendanceCount; // ← 참여 인원 수

  final items = <_CheckItem>[
    _CheckItem(title: '발차기', point: 20),
    _CheckItem(title: '품새', point: 20),
    _CheckItem(title: '체력단련', point: 10),
  ];

  @override
  void initState() {
    super.initState();
    final dt = widget.initialDateTime;
    selYear = dt.year;
    selMonth = dt.month;
    selDay = dt.day;
    selHour = dt.hour;
  }

  int daysInMonth(int year, int month) {
    final first = DateTime(year, month, 1);
    final firstNext = DateTime(year, month + 1, 1);
    return firstNext.subtract(const Duration(days: 1)).day;
  }

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
                          child: Text(e, style: const TextStyle(fontSize: 18)),
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

  // 제목 수정 다이얼로그
  Future<String?> _promptEditTitle(BuildContext context, String current) async {
    final controller = TextEditingController(text: current);
    return showDialog<String>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: Colors.white, // 다이얼로그 배경 흰색
          title: const Text('항목 이름 수정'),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: '새 이름을 입력하세요',
              border: OutlineInputBorder(), // 기본 테두리
              enabledBorder: OutlineInputBorder(
                // 평소 테두리
                borderSide: BorderSide(color: Colors.black54),
              ),
              focusedBorder: OutlineInputBorder(
                // 포커스될 때 테두리
                borderSide: BorderSide(color: mainColor, width: 2),
              ),
            ),
          ),
          actions: [
            // 확인 버튼
            TextButton(
              onPressed: () {
                final text = controller.text.trim();
                Navigator.pop(ctx, text.isEmpty ? null : text);
              },
              style: TextButton.styleFrom(
                backgroundColor: mainColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                  side: BorderSide.none,
                ),
              ),
              child: const Text('확인'),
            ),
            // 취소 버튼
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              style: TextButton.styleFrom(
                foregroundColor: Colors.black54,
                backgroundColor: const Color(0xFFF2F4F7),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                  side: BorderSide.none, // 테두리 제거
                ),
              ),
              child: const Text('취소'),
            ),
          ],
        );
      },
    );
  }

  // 가운데에서 등장하는 전환 라우트 (fade + scale)
  PageRoute<T> _centerScaleRoute<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (_, __, ___) => page,
      transitionDuration: const Duration(milliseconds: 220),
      reverseTransitionDuration: const Duration(milliseconds: 180),
      transitionsBuilder: (_, animation, __, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        );
        return FadeTransition(
          opacity: curved,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.95, end: 1).animate(curved),
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final monthLabel = '$selMonth월';
    final dayLabel = '$selDay일';
    final hourLabel = '$selHour시';

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

    Widget pillButton(
      String text,
      VoidCallback onTap, {
      bool filled = false, // ← 채움 여부
      Color? bgColor, // ← 배경색
      Color? fgColor, // ← 글자색
    }) {
      final decoration = filled
          ? BoxDecoration(
              // 채움 스타일
              color: bgColor ?? mainColor,
              borderRadius: BorderRadius.circular(24),
            )
          : chipBg(); // 기존 아웃라인 스타일

      return Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: onTap,
          child: Container(
            decoration: decoration,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
            alignment: Alignment.center,
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: fgColor ?? (filled ? Colors.white : Colors.black),
              ),
            ),
          ),
        ),
      );
    }

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 제목 + 좌측 파란 언더라인
              const Text(
                '일정 추가',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              Stack(
                children: [
                  const Divider(height: 1),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(height: 2, width: 44, color: mainColor),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // 날짜 선택 라인
              Row(
                children: [
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
                      final months = List.generate(12, (i) => '${i + 1}월');
                      await showWheelPicker(
                        title: '월 선택',
                        items: months,
                        initialIndex: selMonth - 1,
                        onSelectedIndex: (idx) {
                          setState(() {
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
                      final days = List.generate(maxD, (i) => '${i + 1}일');
                      await showWheelPicker(
                        title: '일 선택',
                        items: days,
                        initialIndex: selDay - 1,
                        onSelectedIndex: (idx) =>
                            setState(() => selDay = idx + 1),
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
                        onSelectedIndex: (idx) => setState(() => selHour = idx),
                      );
                    }),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // 참여 인원 선택 라인
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: chipBg(),
                    child: const Text(
                      '참여 인원',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: pillButton(
                      _attendanceCount != null
                          ? '$_attendanceCount명 선택됨'
                          : '선택하기',
                      () async {
                        final result = await Navigator.of(
                          context,
                        ).push<int>(_centerScaleRoute(const AddStudentPage()));
                        if (result != null) {
                          setState(() => _attendanceCount = result);
                        }
                      },
                      filled: true, // ← 채움 ON
                      bgColor: mainColor, // ← 배경색
                      fgColor: Colors.white, // ← 글자색
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // 체크 리스트
              ...items.map(
                (it) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _TaskRowCard(
                    title: it.title,
                    point: it.point,
                    checked: it.checked,
                    onToggle: () => setState(() => it.checked = !it.checked),
                    onEditPoint: () async {
                      final points = List.generate(101, (i) => '$i포인트');
                      final initial = it.point.clamp(0, 100);
                      await showWheelPicker(
                        title: '포인트 선택',
                        items: points,
                        initialIndex: initial,
                        onSelectedIndex: (idx) =>
                            setState(() => it.point = idx),
                      );
                    },
                    onEditTitle: () async {
                      final newTitle = await _promptEditTitle(
                        context,
                        it.title,
                      );
                      if (newTitle != null) {
                        setState(() => it.title = newTitle);
                      }
                    },
                  ),
                ),
              ),

              const SizedBox(height: 2),

              // + 항목 추가 버튼
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      items.add(_CheckItem(title: '눌러서 이름 변경', point: 5));
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

              // 하단 액션
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // TODO: 필요하면 결과를 만들어 Navigator.pop(context, result);
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
      ),
    );
  }
}

//// ---------------- 모델 ----------------
class _CheckItem {
  String title;
  int point;
  bool checked;
  _CheckItem({required this.title, required this.point, this.checked = false});
}

//// --------------- 체크 항목 카드 ---------------
class _TaskRowCard extends StatelessWidget {
  final String title;
  final int point;
  final bool checked;
  final VoidCallback onToggle;
  final VoidCallback onEditPoint;
  final VoidCallback onEditTitle;

  const _TaskRowCard({
    super.key,
    required this.title,
    required this.point,
    required this.checked,
    required this.onToggle,
    required this.onEditPoint,
    required this.onEditTitle,
  });

  @override
  Widget build(BuildContext context) {
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
          // 체크박스
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

          // 제목 (탭 → 이름 수정)
          Expanded(
            child: InkWell(
              onTap: onEditTitle,
              borderRadius: BorderRadius.circular(6),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: checked ? FontWeight.w700 : FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),

          // 포인트 칩 (탭 → 포인트 수정)
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

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(14),
      child: card,
    );
  }
}
