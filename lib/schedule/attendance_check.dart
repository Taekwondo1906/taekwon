import 'package:flutter/material.dart';
import 'package:taekwon/decoration/color_palette.dart';

class Student {
  final int id;
  final String name;
  final String code;
  bool present;

  Student({
    required this.id,
    required this.name,
    required this.code,
    this.present = false,
  });
}

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  List<Student> students = List.generate(
    11,
    (index) => Student(
      id: index,
      name: "김영철",
      code: "1235",
      present: index % 3 == 1, // 일부만 출석
    ),
  );

  void toggleAttendance(int id) {
    setState(() {
      students[id].present = !students[id].present;
    });
  }

  // ---------- Overlay Tooltip ----------
  OverlayEntry? _overlayEntry;
  final GlobalKey _helpIconKey = GlobalKey();

  void _showCustomTooltip(BuildContext context, GlobalKey key) {
    final RenderBox renderBox =
        key.currentContext!.findRenderObject() as RenderBox;
    final Size size = renderBox.size;
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: offset.dy + size.height + 8, // 아이콘 아래쪽에 뜨도록
        left: 0,
        right: 0,
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: Container(
              width: 240,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: const Text(
                "처음엔 모두 빨강(결석) 상태에서\n"
                "한 번 클릭하면 출석(파랑),\n"
                "두 번 클릭하면 다시 결석(빨강)으로 처리됩니다.",
                style: TextStyle(fontSize: 12, color: Colors.black87),
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);

    Future.delayed(const Duration(seconds: 4), () {
      _removeTooltip();
    });
  }

  void _removeTooltip() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  // ---------- UI ----------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 전체 배경
      appBar: AppBar(
        backgroundColor: Colors.white, // 상단바
        elevation: 0, // 그림자 제거
        centerTitle: false, // ✅ 왼쪽 정렬
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("출석 체크", style: TextStyle(color: Colors.black)),
            const SizedBox(width: 6),
            GestureDetector(
              key: _helpIconKey,
              onTap: () {
                if (_overlayEntry == null) {
                  _showCustomTooltip(context, _helpIconKey);
                } else {
                  _removeTooltip();
                }
              },
              child: const Icon(
                Icons.help_outline,
                color: Colors.grey,
                size: 18,
              ),
            ),
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.black), // 뒤로가기/아이콘 색
        actions: const [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          color: Colors.white, // 카드
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: mainColor, // 상단 박스 색
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    "김영희 사범님 / 화요일 17:00 - 20:00",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.9,
                        ),
                    itemCount: students.length,
                    itemBuilder: (context, index) {
                      final student = students[index];
                      return GestureDetector(
                        onTap: () => toggleAttendance(index),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: student.present
                                  ? mainColor
                                  : Colors.red,
                              child: const Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                            const SizedBox(height: 6),
                            // 프로필과 이름 사이 밑줄
                            SizedBox(
                              width: 50,
                              child: Divider(
                                thickness: 1,
                                color: Colors.black12,
                                height: 10,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "${student.name}(${student.code})",
                              style: const TextStyle(color: Colors.black),
                              textAlign: TextAlign.center,
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
        ),
      ),
    );
  }
}
