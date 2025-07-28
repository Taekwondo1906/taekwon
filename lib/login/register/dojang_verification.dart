import 'package:flutter/material.dart';
import 'package:taekwon/decoration/color_palette.dart';
import 'package:taekwon/login/register/register_authentication.dart';
import 'package:taekwon/login/register/select_user.dart';

class DojangVerification extends StatefulWidget {
  const DojangVerification({super.key});

  @override
  State<DojangVerification> createState() => _DojangVerificationState();
}

class _DojangVerificationState extends State<DojangVerification> {
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
      MaterialPageRoute(builder: (context) => const RegisterAuthentication()),
    );
  }

  void backFunction() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SelectUser()),
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
              "도장 인증",
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
                // 도장 이름 레이블
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 24.0), // ← 왼쪽 여백 추가
                    child: const Text(
                      "도장 이름",
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
                      hintText: "도장 입력",
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

                // 도장 주소 레이블
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 24.0), // ← 왼쪽 여백 추가
                    child: const Text(
                      "도장 주소",
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
                      hintText: "도장 주소 입력",
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
                const SizedBox(height: 44),

                // 버튼 영역
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
