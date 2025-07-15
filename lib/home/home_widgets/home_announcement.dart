import 'package:flutter/material.dart';
import 'package:taekwon/decoration/color_palette.dart';

class HomeAnnouncement extends StatefulWidget {
  const HomeAnnouncement({super.key});

  @override
  State<HomeAnnouncement> createState() => _HomeAnnouncementState();
}

class _HomeAnnouncementState extends State<HomeAnnouncement> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '공지',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontFamily: 'inter',
                fontWeight: FontWeight.w600,
                height: 0.92,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: iconColor,
                borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '자세히',
                  style: TextStyle(
                    color: detailColor,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 30,),
        ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            _buildAnnouncementRow('제목1', '내용1', null),
            _buildAnnouncementRow(
              '제목2',
              '긴줄내용긴줄내용긴줄내용긴줄내용긴줄내용긴줄내용긴줄내용긴줄내용긴줄내용긴줄내용긴줄내용긴줄내용긴줄내용긴줄내용긴줄내용긴줄내용긴줄내용긴줄내용긴줄내용긴줄내용',
              null,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAnnouncementRow(String title, String content, String? img) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(19)),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              blurRadius: 22.7,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: img == null || img.isEmpty ? iconColor : null,
                  image: img != null && img.isNotEmpty
                      ? DecorationImage(image: NetworkImage(img), fit: BoxFit.cover)
                      : null,
                ),
              ),
            ),
            const SizedBox(width: 16),
      
            // 제목 + 내용
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      content,
                      style: TextStyle(fontSize: 14, color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
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
