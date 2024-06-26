import 'package:flutter/material.dart';
import 'package:gdsc_2024/model/post.dart';
import 'package:gdsc_2024/utils/app_styles.dart';

class RegularPostCard extends StatelessWidget {
  final Post post;

  RegularPostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;

    // Maximum length of the displayed title
    const int maxTitleLength = 55;

    // Truncate the title if it exceeds the maximum length
    String truncatedTitle = post.title.length > maxTitleLength
        ? '${post.title.substring(0, maxTitleLength)}...'
        : post.title;

    return Container(
      height: 0.11 * deviceHeight,
      width: 0.9 * deviceWidth,
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: Colors.grey,
        width: 1.0,
      ))),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                post.imageUrl,
                width: 80.0,
                height: 0.1 * deviceHeight,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 26), // Spacer between image and text

            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Text(truncatedTitle, style: AppStyles.Subtitle)),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          post.categoryDto.name,
                          maxLines: 1,
                          style: AppStyles.Body2,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          post.createdAt,
                          maxLines: 1,
                          style: AppStyles.smallText,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
