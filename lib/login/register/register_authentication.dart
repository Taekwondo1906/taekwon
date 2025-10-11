import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taekwon/decoration/color_palette.dart';
import 'package:taekwon/login/login_screen.dart';
import '../../utils/phone_number_formatter.dart';

class RegisterAuthentication extends StatefulWidget {
  const RegisterAuthentication({super.key});

  @override
  State<RegisterAuthentication> createState() => _RegisterAuthenticationState();
}

class _RegisterAuthenticationState extends State<RegisterAuthentication> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController authCodeController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? _verificationId; // Firebase에서 받은 인증 ID 저장용
  bool _isCodeSent = false; // 인증번호 입력란 활성화 여부 제어

  // 전화번호 유효성 검증 (예: 010-xxxx-xxxx)
  bool isValidPhoneNumber(String phoneNumber) {
    final cleaned = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
    return cleaned.length == 11 && cleaned.startsWith('010');
  }

  // 인증번호 전송 함수
  Future<void> sendVerificationCode() async {
    String phoneNumber = phoneController.text.trim();

    if (!isValidPhoneNumber(phoneNumber)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("올바른 형식의 전화번호를 입력해주세요.")),
      );
      return;
    }

    // Firebase용 형식(+82로 시작)
    String formatted = '+82${phoneNumber.substring(1)}';

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: formatted,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Android에서 자동 인증되는 경우
          await _auth.signInWithCredential(credential);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("자동으로 인증이 완료되었습니다.")),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        },
        verificationFailed: (FirebaseAuthException e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("인증 실패: ${e.message}")),
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            _verificationId = verificationId;
            _isCodeSent = true;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("인증번호가 전송되었습니다.")),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("에러 발생: $e")),
      );
    }
  }

  // 인증번호 확인 및 로그인
  Future<void> verifyCodeAndLogin() async {
    String smsCode = authCodeController.text.trim();
    if (_verificationId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("먼저 인증번호를 전송해주세요.")),
      );
      return;
    }
    if (smsCode.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("인증번호를 입력해주세요.")),
      );
      return;
    }

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: smsCode,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final isNewUser = userCredential.additionalUserInfo?.isNewUser ?? false;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isNewUser ? "회원가입 완료!" : "로그인 완료!"),
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("인증 실패: $e")),
      );
    }
  }

  void backFunction() => Navigator.pop(context);

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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 전화번호 입력
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 24.0),
                    child: Text("전화번호", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  ),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: screenWidth * 0.76,
                  child: TextField(
                    controller: phoneController,
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontSize: 16),
                    decoration: const InputDecoration(
                      hintText: "전화번호 입력",
                      filled: true,
                      fillColor: Color(0xFFF0F0F0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        borderSide: BorderSide(color: Color(0xFFE0E0E0)),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    ),
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(11),
                      PhoneNumberFormatter(),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // 인증번호 입력
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 24.0),
                    child: Text("인증번호", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  ),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: screenWidth * 0.76,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: TextField(
                          controller: authCodeController,
                          textAlign: TextAlign.left,
                          enabled: _isCodeSent, // 인증번호 전송 후에만 입력 가능
                          style: const TextStyle(fontSize: 16),
                          decoration: const InputDecoration(
                            hintText: "인증번호 입력",
                            filled: true,
                            fillColor: Color(0xFFF0F0F0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(100)),
                              borderSide: BorderSide(color: Color(0xFFE0E0E0)),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          onPressed: sendVerificationCode,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: mainColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                          ),
                          child: const Text("인증번호 전송", style: TextStyle(fontSize: 11)),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 44),

                // 확인 / 취소 버튼
                Center(
                  child: SizedBox(
                    width: screenWidth * 0.5,
                    height: 45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: verifyCodeAndLogin,
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
