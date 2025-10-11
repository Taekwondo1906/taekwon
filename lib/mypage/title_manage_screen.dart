import 'package:flutter/material.dart';
import 'package:taekwon/decoration/color_palette.dart';
import 'package:taekwon/notification/notification_screen.dart';

class TitleManageScreen extends StatefulWidget {
  const TitleManageScreen({super.key});

  @override
  State<TitleManageScreen> createState() => _TitleManageScreenState();
}

class _TitleManageScreenState extends State<TitleManageScreen> {
  String currentTitle = '태권도 새싹'; // 현재 대표 칭호
  String? selectedTitle; // 클릭된 칭호
  final List<String> myTitles = ['발차기 입문자', '발차기 수련자', '성실왕', '태권도 새싹'];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final bool isChanged =
        selectedTitle != null && selectedTitle != currentTitle;

    return Scaffold(
      body: GestureDetector(
        // 카드 밖 클릭 시 선택 취소
        onTap: () {
          FocusScope.of(context).unfocus();
          setState(() {
            selectedTitle = null;
          });
        },
        behavior: HitTestBehavior.translucent, // 빈 공간 터치 감지
        child: Stack(
          children: [
            Container(color: Colors.white),
            Container(
              height: screenHeight * 0.3,
              decoration: const BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(55),
                  bottomRight: Radius.circular(55),
                ),
              ),
            ),
            Positioned(
              top: screenHeight * 0.1,
              left: screenWidth * 0.07,
              right: screenWidth * 0.07,
              child: Material(
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 24,
                      ),
                      onPressed: () => Navigator.pop(context),
                      splashRadius: 24,
                    ),
                    const Text(
                      '칭호 관리',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontFamily: 'inter',
                        fontWeight: FontWeight.w600,
                        height: 0.92,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.notifications_outlined,
                        color: Colors.white,
                        size: 28,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NotificationScreen(),
                          ),
                        );
                      },
                      splashRadius: 24,
                    ),
                  ],
                ),
              ),
            ),

            // 콘텐츠
            Positioned.fill(
              top: screenHeight * 0.18,
              left: screenWidth * 0.08,
              right: screenWidth * 0.08,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // 현재 대표 칭호 카드
                    Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '현재 대표 칭호',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: labelColor,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Divider(height: 1, color: Colors.grey.shade300),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  currentTitle,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: mainColor,
                                  ),
                                ),
                                TextButton(
                                  onPressed: isChanged
                                      ? () {
                                          if (selectedTitle == currentTitle)
                                            return; // 같은 칭호면 무시
                                          setState(() {
                                            currentTitle = selectedTitle!;
                                            selectedTitle = null;
                                          });
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text('대표 칭호가 변경되었습니다.'),
                                            ),
                                          );
                                        }
                                      : null,
                                  style: TextButton.styleFrom(
                                    backgroundColor: isChanged
                                        ? mainColor
                                        : Colors.white,
                                    side: const BorderSide(color: mainColor),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                  ),
                                  child: Text(
                                    '변경',
                                    style: TextStyle(
                                      color: isChanged
                                          ? Colors.white
                                          : mainColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),

                    // 내 칭호 카드
                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '내 칭호',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: labelColor,
                                ),
                              ),
                              const SizedBox(height: 12),
                              for (var title in myTitles) ...[
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedTitle = title;
                                    });
                                  },
                                  onTapDown: (_) {}, // 내부 탭이 카드 외부 취소를 막지 않게 함
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 12,
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: selectedTitle == title
                                          ? mainColor.withOpacity(0.15)
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: selectedTitle == title
                                            ? mainColor
                                            : Colors.grey.shade300,
                                      ),
                                    ),
                                    child: Text(
                                      title,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: selectedTitle == title
                                            ? mainColor
                                            : Colors.black,
                                        fontWeight: selectedTitle == title
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
