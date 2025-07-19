//로그인 화면

import 'package:flutter/material.dart';
// 색상 팔레트
import 'package:taekwon/decoration/color_palette.dart';
import 'package:taekwon/login/login_authentication.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController phoneController = TextEditingController();

  void loginFunction() {
    String phone = phoneController.text.trim();

    if (phone.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("전화번호를 입력해주세요.")));
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginAuthentication()),
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
          const Text(
            "로그인",
            style: TextStyle(fontSize: 29, fontWeight: FontWeight.bold),
          ),
          const Spacer(), // 로그인 폼을 아래로 밀어줌
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
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: "전화번호",
                        hintStyle: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16,
                        ),
                        filled: true,
                        fillColor: mainColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                ),

                const SizedBox(height: 24),
                SizedBox(
                  width: screenWidth * 0.23,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: loginFunction,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("로그인"),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(flex: 2), // 아래쪽 더 많은 공간 확보
        ],
      ),
    );
  }
}
