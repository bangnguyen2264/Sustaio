import 'package:flutter/material.dart';
import 'package:gdsc_2024/model/post.dart';
import 'package:gdsc_2024/pages/noti_screen.dart';
import 'package:gdsc_2024/services/post_service.dart';
import 'package:gdsc_2024/utils/app_styles.dart';
import 'package:gdsc_2024/utils/data.dart';
import 'package:gdsc_2024/widgets/hot_post_card.dart';
import 'package:gdsc_2024/widgets/regular_post_card.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: _buildAppBar(context),
      key: _scaffoldKey,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 25.0,
        ),
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              _buildListHotNews(deviceHeight),
              _buildListRegularNews(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Container(
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Image.asset('assets/images/User-50.png'),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Farmer",
                    style: AppStyles.Subtitle,
                  ),
                  Text(
                    "Farmer",
                    style: AppStyles.Body1,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NotificationScreen(),
              ),
            );
          },
          icon: Image.asset('assets/icons/noti.png'),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Today",
            style: AppStyles.Heading4,
          ),
          Text(
            "News & Popular",
            style: AppStyles.Heading3,
          ),
        ],
      ),
    );
  }

  Widget _buildListHotNews(double deviceHeight) {
    return FutureBuilder<List<Post>>(
      future: PostService().get5NewestPosts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Container(
            margin: EdgeInsets.only(
              top: 13,
              bottom: 22,
            ),
            height: 0.26 * deviceHeight,
            child: PageView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return HotPostCard(post: snapshot.data![index]);
              },
            ),
          );
        }
      },
    );
  }

  Widget _buildListRegularNews() {
    return Expanded(
      child: FutureBuilder<List<Post>>(
        future: PostService().getAllPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.data != null) {
            return Expanded(
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return RegularPostCard(post: snapshot.data![index]);
                },
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
