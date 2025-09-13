//휴대폰 인증 화면

import 'package:flutter/material.dart';
// 색상 팔레트
import 'package:taekwon/decoration/color_palette.dart';
import 'package:taekwon/login/login_complete.dart';

class LoginAuthentication extends StatefulWidget {
  const LoginAuthentication({super.key});

  @override
  State<LoginAuthentication> createState() => _LoginAuthenticationState();
}

class _LoginAuthenticationState extends State<LoginAuthentication> {
  final TextEditingController phoneController = TextEditingController();

  void loginFunction() {
    String phone = phoneController.text.trim();

    if (phone.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("인증번호를 입력해주세요.")));
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginComplete()),
    );
  }

  void backFunction() {
    Navigator.pop(context); // pop으로 변경
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
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: SizedBox(
                    width: screenWidth * 0.76,
                    child: TextField(
                      controller: phoneController,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Colors.black, // 입력한 글씨 색상
                        fontSize: 16,
                      ),
                      decoration: const InputDecoration(
                        hintText: "인증번호 입력", // 힌트 텍스트
                        hintStyle: TextStyle(
                          color: Color.fromARGB(255, 163, 160, 160),
                          fontSize: 16,
                        ),
                        filled: true,
                        fillColor: Color.fromARGB(255, 240, 240, 240), // 배경색
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 224, 224, 224),
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          borderSide: BorderSide(
                            color: Color.fromARGB(
                              255,
                              236,
                              236,
                              236,
                            ), // 포커스됐을 때 색
                            width: 2.0,
                          ),
                        ),

                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: screenWidth * 0.76,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: loginFunction, //재발송 기능으로 바꿔야됨 나중에
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("재발송"),
                  ),
                ),
                const SizedBox(height: 44),
                SizedBox(
                  width: screenWidth * 0.5, // Row 전체 너비 조절
                  height: 45,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // 양쪽 정렬
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
                      const SizedBox(width: 12), // 버튼 사이 간격
                      Expanded(
                        child: ElevatedButton(
                          onPressed: backFunction,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 224, 224, 224),
                            foregroundColor: Color.fromARGB(255, 163, 160, 160),
                          ),
                          child: const Text("취소"),
                        ),
                      ),
                    ],
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
