import 'package:flutter/material.dart';
import 'package:taekwon/decoration/color_palette.dart';
import 'package:taekwon/login/register/dojang_verification.dart';
import 'package:taekwon/login/register/register_screen.dart';

class RegisterAuthentication extends StatefulWidget {
  const RegisterAuthentication({super.key});

  @override
  State<RegisterAuthentication> createState() => _RegisterAuthenticationState();
}

class _RegisterAuthenticationState extends State<RegisterAuthentication> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  void loginFunction() {
    String name = nameController.text.trim();
    String address = addressController.text.trim();

    if (name.isEmpty || address.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("인증번호를 입력해주세요.")));
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterScreen()),
    );
  }

  void backFunction() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const DojangVerification()),
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
              "휴대폰 인증",
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
                    controller: nameController,
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
                const SizedBox(height: 24),

                // 도장 주소 레이블
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 24.0), // ← 왼쪽 여백 추가
                    child: const Text(
                      "인증번호",
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
                  child: Row(
                    children: [
                      // 입력 필드
                      Expanded(
                        flex: 2,
                        child: TextField(
                          controller: addressController,
                          textAlign: TextAlign.left,
                          style: const TextStyle(fontSize: 16),
                          decoration: const InputDecoration(
                            hintText: "인증번호 입력",
                            hintStyle: TextStyle(
                              color: Color(0xFFA3A0A0),
                              fontSize: 16,
                            ),
                            filled: true,
                            fillColor: Color(0xFFF0F0F0),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(100),
                              ),
                              borderSide: BorderSide(
                                color: Color(0xFFE0E0E0),
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(100),
                              ),
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

                      const SizedBox(width: 8),

                      // 인증 버튼
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("인증번호 확인 클릭됨")),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: mainColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 0,
                              vertical: 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          child: const Text(
                            "인증번호 전송",
                            style: TextStyle(fontSize: 11),
                          ),
                        ),
                      ),
                    ],
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
