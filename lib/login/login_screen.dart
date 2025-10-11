//로그인 화면

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// 색상 팔레트
import 'package:taekwon/decoration/color_palette.dart';
import 'package:taekwon/login/login_authentication.dart';
import 'package:taekwon/login/register/terms_of_service.dart';

import '../utils/phone_number_formatter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController phoneController = TextEditingController();

  // --- 여기를 수정했습니다 ---
  void loginFunction() {
    String phoneNumber = phoneController.text.trim();

    // phone_number_formatter.dart에 있는 유효성 검사 함수를 재사용합니다.
    if (!isValidPhoneNumber(phoneNumber)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("올바른 형식의 전화번호를 입력해주세요.")));
      return;
    }

    // 유효성 검사를 통과하면 인증 화면으로 이동합니다.
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginAuthentication()),
    );
  }

  void signUp() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TermsOfService(),
      ), // 클래스 이름 오타 수정된 것 확인
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
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Colors.black, // 입력한 글씨 색상
                        fontSize: 16,
                      ),
                      decoration: const InputDecoration(
                        hintText: "전화번호 입력", // 힌트 텍스트
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
                      // PhoneNumberFormatter가 정상적으로 동작하는 것을 확인
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(11),
                        PhoneNumberFormatter(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 86),
                SizedBox(
                  width: screenWidth * 0.6, // Row 전체 너비 조절
                  height: 45,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // 양쪽 정렬
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: signUp,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: mainColor,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text("회원가입"),
                        ),
                      ),
                      const SizedBox(width: 12), // 버튼 사이 간격
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
                    ],
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
