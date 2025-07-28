import 'package:flutter/material.dart';
import 'package:taekwon/decoration/color_palette.dart';
import 'package:taekwon/login/login_complete.dart';
import 'package:taekwon/login/register/dojang_verification.dart';

class SelectUser extends StatefulWidget {
  const SelectUser({super.key});

  @override
  State<SelectUser> createState() => _SelectUserState();
}

class _SelectUserState extends State<SelectUser> {
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

  void loginFunction() {
    if (!agreeService || !agreePrivacy) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("필수 항목에 모두 동의해주세요.")));
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginComplete()),
    );
  }

  void userSelected() {
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.15),
              const Text(
                "유저 선택",
                style: TextStyle(fontSize: 29, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenHeight * 0.13),
              SizedBox(
                width: screenWidth * 0.6,
                height: 45,
                child: ElevatedButton(
                  onPressed: userSelected,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainColor,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("일반 회원"),
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
              SizedBox(
                width: screenWidth * 0.6,
                height: 45,
                child: ElevatedButton(
                  onPressed: userSelected,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainColor,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("학부모"),
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
              SizedBox(
                width: screenWidth * 0.6,
                height: 45,
                child: ElevatedButton(
                  onPressed: userSelected,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainColor,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("관장님"),
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
              SizedBox(
                width: screenWidth * 0.6,
                height: 45,
                child: ElevatedButton(
                  onPressed: userSelected,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainColor,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("사범님"),
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
