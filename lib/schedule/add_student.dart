import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taekwon/decoration/color_palette.dart'; // mainColor 사용

class AddStudentPage extends StatefulWidget {
  const AddStudentPage({super.key});

  @override
  State<AddStudentPage> createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  bool _searchFocused = false;

  // 더미 데이터: 이름(학번)
  final List<Map<String, dynamic>> _students = [
    {'name': '김영진', 'id': '1234', 'selected': false},
    {'name': '김수아', 'id': '1234', 'selected': false},
    {'name': '김철수', 'id': '1234', 'selected': false},
    {'name': '김철수', 'id': '1234', 'selected': false},
    {'name': '김철수', 'id': '1234', 'selected': false},
    {'name': '김철수', 'id': '1234', 'selected': false},
    {'name': '김철수', 'id': '1234', 'selected': false},
  ];

  List<Map<String, dynamic>> _filteredStudents = [];

  @override
  void initState() {
    super.initState();
    _filteredStudents = List.from(_students);
    _searchController.addListener(_onSearchChanged);

    _searchFocusNode.addListener(() {
      setState(() => _searchFocused = _searchFocusNode.hasFocus);
    });
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredStudents = _students.where((student) {
        final name = student['name'].toString().toLowerCase();
        final id = student['id'].toString();
        return name.contains(query) || id.contains(query);
      }).toList();
    });
  }

  void _toggleSelected(int index) {
    setState(() {
      _filteredStudents[index]['selected'] =
          !_filteredStudents[index]['selected'];
      // 원본 리스트에도 동기화
      final originalIndex = _students.indexWhere(
        (element) =>
            element['name'] == _filteredStudents[index]['name'] &&
            element['id'] == _filteredStudents[index]['id'],
      );
      if (originalIndex != -1) {
        _students[originalIndex]['selected'] =
            _filteredStudents[index]['selected'];
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  // 호출부에서 push<int> 로 받으므로 인원수(int) 반환
  void _onConfirm() {
    final selectedCount = _students
        .where((student) => student['selected'])
        .length;
    Navigator.pop<int>(context, selectedCount);
  }

  @override
  Widget build(BuildContext context) {
    // 화면 비율 기반 높이 (반응형)
    final double boxHeight = MediaQuery.of(context).size.height * 0.45;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          '수업 인원선택',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check, color: Colors.black),
            onPressed: _onConfirm,
            tooltip: '확인',
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              focusNode: _searchFocusNode,
              cursorColor: mainColor, // 커서 색
              decoration: InputDecoration(
                hintText: '찾기',
                prefixIcon: Icon(
                  Icons.search,
                  color: _searchFocused
                      ? mainColor
                      : Colors.black45, // 포커스 시 아이콘 색
                ),
                // 평소 테두리
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFDDDDDD)),
                ),
                // 포커스 테두리
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: mainColor, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),

          // 반응형 높이 박스
          SizedBox(
            height: boxHeight, // 화면 높이의 45%
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x11000000),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: ListView.builder(
                itemCount: _filteredStudents.length,
                itemBuilder: (context, index) {
                  final student = _filteredStudents[index];
                  return ListTile(
                    visualDensity: const VisualDensity(vertical: -2),
                    leading: CircleAvatar(
                      backgroundColor: mainColor,
                      child: const Icon(Icons.person, color: Colors.white),
                    ),
                    title: Text('${student['name']}(${student['id']})'),
                    trailing: Checkbox(
                      value: student['selected'],
                      onChanged: (_) => _toggleSelected(index),
                    ),
                    onTap: () => _toggleSelected(index),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
