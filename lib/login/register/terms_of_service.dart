import 'package:flutter/material.dart';
import 'package:taekwon/decoration/color_palette.dart';
import 'package:taekwon/login/register/select_user.dart';

class TermsOfService extends StatefulWidget {
  const TermsOfService({super.key});

  @override
  State<TermsOfService> createState() => _TermsOfServiceState();
}

class _TermsOfServiceState extends State<TermsOfService> {
  bool agreeAll = false;
  bool agreeService = false;
  bool agreePrivacy = false;
  bool agreeMarketing = false;

  void toggleAll(bool? value) {
    setState(() {
      agreeAll = value ?? false;
      agreeService = value ?? false;
      agreePrivacy = value ?? false;
      agreeMarketing = value ?? false;
    });
  }

  void selectUserFunction() {
    if (!agreeService || !agreePrivacy) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("필수 항목에 모두 동의해주세요.")));
      return;
    }

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.15),
            const Text(
              "이용 약관 동의",
              style: TextStyle(fontSize: 29, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: screenHeight * 0.08),
            SizedBox(
              width: screenWidth * 0.6,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: mainColor,
                  foregroundColor: Colors.white,
                ),
                child: const Text("이용 약관 ( 내용 보기 )"),
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: Container(
                width: screenWidth * 0.85,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(30, 0, 0, 0),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: screenWidth * 0.75,
                      child: const Text(
                        "이용 약관 동의",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    // 전체 동의
                    SizedBox(
                      width: screenWidth * 0.75,
                      child: CheckboxListTile(
                        dense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                        title: const Text(
                          "전체 동의",
                          style: TextStyle(fontSize: 14),
                        ),
                        value: agreeAll,
                        onChanged: toggleAll,
                        controlAffinity: ListTileControlAffinity.trailing,
                        activeColor: mainColor, // 체크됐을 때 배경(테두리 및 내부)
                        checkColor: Colors.white, // 체크 아이콘(✓) 색상
                        fillColor: WidgetStateProperty.resolveWith((states) {
                          if (states.contains(WidgetState.selected)) {
                            return mainColor; // 체크 상태
                          }
                          return const Color.fromARGB(
                            255,
                            255,
                            255,
                            255,
                          ); // 미체크 상태
                        }),
                      ),
                    ),
                    // 서비스 이용약관
                    SizedBox(
                      width: screenWidth * 0.75,
                      child: CheckboxListTile(
                        dense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                        title: const Text(
                          "서비스 이용약관 동의 (필수)",
                          style: TextStyle(fontSize: 14),
                        ),
                        value: agreeService,
                        onChanged: (val) {
                          setState(() => agreeService = val ?? false);
                        },
                        controlAffinity: ListTileControlAffinity.trailing,
                        activeColor: mainColor, // 체크됐을 때 배경(테두리 및 내부)
                        checkColor: Colors.white, // 체크 아이콘(✓) 색상
                        fillColor: WidgetStateProperty.resolveWith((states) {
                          if (states.contains(WidgetState.selected)) {
                            return mainColor; // 체크 상태
                          }
                          return const Color.fromARGB(
                            255,
                            255,
                            255,
                            255,
                          ); // 미체크 상태
                        }),
                      ),
                    ),
                    // 개인정보 수집
                    SizedBox(
                      width: screenWidth * 0.75,
                      child: CheckboxListTile(
                        dense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                        title: const Text(
                          "개인정보 수집 및 이용 동의 (필수)",
                          style: TextStyle(fontSize: 14),
                        ),
                        value: agreePrivacy,
                        onChanged: (val) {
                          setState(() => agreePrivacy = val ?? false);
                        },
                        controlAffinity: ListTileControlAffinity.trailing,
                        activeColor: mainColor, // 체크됐을 때 배경(테두리 및 내부)
                        checkColor: Colors.white, // 체크 아이콘(✓) 색상
                        fillColor: WidgetStateProperty.resolveWith((states) {
                          if (states.contains(WidgetState.selected)) {
                            return mainColor; // 체크 상태
                          }
                          return const Color.fromARGB(
                            255,
                            255,
                            255,
                            255,
                          ); // 미체크 상태
                        }),
                      ),
                    ),
                    // 마케팅 수신
                    SizedBox(
                      width: screenWidth * 0.75,
                      child: CheckboxListTile(
                        dense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                        title: const Text(
                          "마케팅 수신 동의 (선택)",
                          style: TextStyle(fontSize: 14),
                        ),
                        value: agreeMarketing,
                        onChanged: (val) {
                          setState(() => agreeMarketing = val ?? false);
                        },
                        controlAffinity: ListTileControlAffinity.trailing,
                        activeColor: mainColor, // 체크됐을 때 배경(테두리 및 내부)
                        checkColor: Colors.white, // 체크 아이콘(✓) 색상
                        fillColor: WidgetStateProperty.resolveWith((states) {
                          if (states.contains(WidgetState.selected)) {
                            return mainColor; // 체크 상태
                          }
                          return const Color.fromARGB(
                            255,
                            255,
                            255,
                            255,
                          ); // 미체크 상태
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: screenWidth * 0.3,
              height: 45,
              child: ElevatedButton(
                onPressed: selectUserFunction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: mainColor,
                  foregroundColor: Colors.white,
                ),
                child: const Text("확인"),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
