import 'package:flutter/material.dart';
import 'package:taekwon/decoration/color_palette.dart';

class AnnouncementItems extends StatelessWidget {
  const AnnouncementItems({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(5),
      children: [
        _buildAnnouncementRow(context, 15, '제목1', '내용1'),
        _buildAnnouncementRow(
          context,
          15,
          '제목2',
          '긴줄내용긴줄내용긴줄내용긴줄내용긴줄내용긴줄내용긴줄내용긴줄내용긴줄내용긴줄내용긴줄내용긴줄내용긴줄내용긴줄내용긴줄내용긴줄내용긴줄내용긴줄내용긴줄내용긴줄내용',
        ),
      ],
    );
  }

  Widget _buildAnnouncementRow(
    BuildContext context,
    int viewCount,
    String title,
    String content,
  ) {
    final screenHeight = MediaQuery.of(context).size.height;
    String view = '조회수 $viewCount';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: screenHeight * 0.15,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(19)),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              blurRadius: 10,
              offset: const Offset(0, 2),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    view,
                    style: TextStyle(
                      color: detailColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Divider(color: detailColor),
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
    );
  }
}
