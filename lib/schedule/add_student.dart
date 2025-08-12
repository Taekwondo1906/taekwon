import 'package:flutter/material.dart';

class AddStudentPage extends StatefulWidget {
  const AddStudentPage({super.key});

  @override
  State<AddStudentPage> createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final TextEditingController _searchController = TextEditingController();

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
    super.dispose();
  }

  void _onConfirm() {
    final selectedStudents = _students
        .where((student) => student['selected'])
        .toList();
    Navigator.pop(context, selectedStudents);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('수업 인원선택'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
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
              decoration: InputDecoration(
                hintText: '찾기',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListView.builder(
                itemCount: _filteredStudents.length,
                itemBuilder: (context, index) {
                  final student = _filteredStudents[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue[400],
                      child: const Icon(Icons.person, color: Colors.white),
                    ),
                    title: Text('${student['name']}(${student['id']})'),
                    trailing: Checkbox(
                      value: student['selected'],
                      onChanged: (value) {
                        _toggleSelected(index);
                      },
                    ),
                    onTap: () {
                      _toggleSelected(index);
                    },
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
