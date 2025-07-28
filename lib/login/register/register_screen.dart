import 'package:flutter/material.dart';
import 'package:taekwon/decoration/color_palette.dart';
import 'package:taekwon/login/register/register_complete.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  void loginFunction() {
    String name = nameController.text.trim();
    String address = addressController.text.trim();

    if (name.isEmpty || address.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("도장 정보를 모두 입력해주세요.")));
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterComplete()),
    );
  }

  void backFunction() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterComplete()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: screenHeight * 0.18),
          const Center(
            child: Text(
              "회원가입",
              style: TextStyle(fontSize: 29, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: screenHeight * 0.08),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center, // 전체 가운데 정렬 유지
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 24.0), // ← 왼쪽 여백 추가
                    child: const Text(
                      "이름",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: screenWidth * 0.76,
                  child: TextField(
                    controller: nameController,
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontSize: 16),
                    decoration: const InputDecoration(
                      hintText: "이름 입력",
                      hintStyle: TextStyle(
                        color: Color(0xFFA3A0A0),
                        fontSize: 16,
                      ),
                      filled: true,
                      fillColor: Color(0xFFF0F0F0),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        borderSide: BorderSide(
                          color: Color(0xFFE0E0E0),
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        borderSide: BorderSide(
                          color: Color(0xFFECECEC),
                          width: 2.0,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 24.0), // ← 왼쪽 여백 추가
                    child: const Text(
                      "이메일",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 6),
                SizedBox(
                  width: screenWidth * 0.76,
                  child: TextField(
                    controller: addressController,
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontSize: 16),
                    decoration: const InputDecoration(
                      hintText: "이메일 입력",
                      hintStyle: TextStyle(
                        color: Color(0xFFA3A0A0),
                        fontSize: 16,
                      ),
                      filled: true,
                      fillColor: Color(0xFFF0F0F0),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        borderSide: BorderSide(
                          color: Color(0xFFE0E0E0),
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        borderSide: BorderSide(
                          color: Color(0xFFECECEC),
                          width: 2.0,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 24.0), // ← 왼쪽 여백 추가
                    child: const Text(
                      "전화번호",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 6),
                SizedBox(
                  width: screenWidth * 0.76,
                  child: TextField(
                    controller: addressController,
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontSize: 16),
                    decoration: const InputDecoration(
                      hintText: "전화번호 입력",
                      hintStyle: TextStyle(
                        color: Color(0xFFA3A0A0),
                        fontSize: 16,
                      ),
                      filled: true,
                      fillColor: Color(0xFFF0F0F0),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        borderSide: BorderSide(
                          color: Color(0xFFE0E0E0),
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        borderSide: BorderSide(
                          color: Color(0xFFECECEC),
                          width: 2.0,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 14,
                      ),
                    ),
                  ),
                ),
                // 버튼 영역
                const SizedBox(height: 44),
                const SizedBox(height: 24),
                Center(
                  child: SizedBox(
                    width: screenWidth * 0.5,
                    height: 45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: loginFunction,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: mainColor,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text("확인"),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: backFunction,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFE0E0E0),
                              foregroundColor: Color(0xFFA3A0A0),
                            ),
                            child: const Text("취소"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
