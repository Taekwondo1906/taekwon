import 'package:flutter/services.dart';

/// 전화번호 형식(예: 010-1234-5678)으로 자동 변환해주는 클래스
// --- 바로 이 부분! "extends TextInputFormatter"가 반드시 있어야 합니다. ---
class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    var formattedText = "";

    if (newText.isEmpty) {
      return newValue.copyWith(text: '');
    }

    if (newText.startsWith('02')) {
      if (newText.length > 2) {
        formattedText = '${newText.substring(0, 2)}-';
        if (newText.length > 6) {
          formattedText += '${newText.substring(2, 6)}-${newText.substring(6)}';
        } else if (newText.length > 2) {
          formattedText += newText.substring(2);
        }
      } else {
        formattedText = newText;
      }
    } else {
      if (newText.length > 3) {
        formattedText = '${newText.substring(0, 3)}-';
        if (newText.length > 7) {
          formattedText += '${newText.substring(3, 7)}-${newText.substring(7)}';
        } else if (newText.length > 3) {
          formattedText += newText.substring(3);
        }
      } else {
        formattedText = newText;
      }
    }

    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

/// 입력된 전화번호 문자열이 유효한 길이인지 확인하는 함수
/// (true: 유효함, false: 유효하지 않음)
bool isValidPhoneNumber(String phoneNumber) {
  // 비어있는지 먼저 확인
  if (phoneNumber.isEmpty) {
    return false;
  }
  // 하이픈(-) 등 다른 문자를 모두 제거하고 순수 숫자만 추출
  final digitsOnly = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');

  // 대한민국 전화번호는 보통 10자리 또는 11자리입니다.
  return digitsOnly.length >= 10 && digitsOnly.length <= 11;
}
