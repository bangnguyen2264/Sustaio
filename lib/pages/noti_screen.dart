import 'package:flutter/material.dart';
import 'package:gdsc_2024/model/notification.dart';
import 'package:gdsc_2024/services/notification_service.dart';
import 'package:gdsc_2024/utils/app_styles.dart';
import 'package:gdsc_2024/widgets/noti_card.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  Future<List<NotificationModel>> listNoti =
      NotificationService().getAllNotifications();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications",
          style: AppStyles.Heading4,
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<NotificationModel>>(
        future: listNoti,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<NotificationModel> notiList = snapshot.data ?? [];

            if (notiList.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/empty.png'),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      'You don’t have any messages.',
                      style: AppStyles.Body1,
                    ),
                  ],
                ),
              );
            }

            return _buildListNotificationCard(notiList, context);
          }
        },
      ),
    );
  }

  Widget _buildListNotificationCard(
      List<NotificationModel> notiList, BuildContext context) {
    return ListView.builder(
      itemCount: notiList.length + 1, // +1 for the empty view
      itemBuilder: (context, index) {
        if (index == notiList.length) {
          // This is the last item, which is an empty view
          return SizedBox(height: 16);
        }
        return NotificationCard(
          notification: notiList[index],
        );
      },
    );
  }
}
