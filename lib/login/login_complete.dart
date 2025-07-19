// 로그인 완료 화면

import 'package:flutter/material.dart';
import 'package:taekwon/decoration/color_palette.dart';
import 'package:taekwon/main.dart';

class LoginComplete extends StatelessWidget {
  const LoginComplete({super.key});

  void navigateToHome(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MyApp()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: screenHeight * 0.25),
            const Text(
              "로그인이\n완료되었습니다!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 29, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            SizedBox(
              width: screenWidth * 0.3,
              height: 45,
              child: ElevatedButton(
                onPressed: () => navigateToHome(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: mainColor,
                  foregroundColor: Colors.white,
                ),
                child: const Text("홈으로 이동"),
              ),
            ),
            SizedBox(height: screenHeight * 0.15),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
