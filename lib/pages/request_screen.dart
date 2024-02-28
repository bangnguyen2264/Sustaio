import 'package:flutter/material.dart';
import 'package:gdsc_2024/components/app_bar.dart';
import 'package:gdsc_2024/model/collab_form.dart';
import 'package:gdsc_2024/model/collab_request_dto.dart';
import 'package:gdsc_2024/pages/collabdetails_screen.dart';
import 'package:gdsc_2024/services/collab_request_service.dart';
import 'package:gdsc_2024/services/collab_service.dart';
import 'package:gdsc_2024/utils/app_styles.dart';
import 'package:gdsc_2024/utils/data.dart';
import 'package:gdsc_2024/widgets/collab_card.dart';
import 'package:gdsc_2024/widgets/request_card.dart';

class RequestScreen extends StatelessWidget {
  const RequestScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const TitleAppbar(title: 'Request'),
          actions: [
            _buildIconSearch(),
          ],
          automaticallyImplyLeading: false,
          bottom: TabBar(
            tabs: [
              Tab(text: 'Pending'),
              Tab(text: 'Accepted'),
            ],
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppStyles.primaryColor1,
                width: 1.0,
              ),
            ),
            labelColor: AppStyles.primaryColor1,
            unselectedLabelColor: Color(0xffB4B4C3),
            labelStyle: AppStyles.Body1,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: EdgeInsets.symmetric(horizontal: 16.0),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        body: TabBarView(
          children: [
            // Content of Tab 1
            _buildRecommendedTab(),

            // Content of Tab 2
            _buildNewProfileTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendedTab() {
    return FutureBuilder<List<CollabRequestDto>>(
      future: CollabRequestService().getAllCollabRequest(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<CollabRequestDto> collabList = snapshot.data ?? [];
          return _buildListCardToCollab(collabList, context);
        }
      },
    );
  }

  Widget _buildNewProfileTab() {
    // You can add similar logic to fetch data for the New Profile tab
    return Center(
      child: Text('Tab 2 Content'),
    );
  }

  Widget _buildListCardToCollab(
      List<CollabRequestDto> collabList, BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: collabList.length,
        itemBuilder: (context, index) {
          return RequestCard(collabRequestDto: collabList[index]);
        },
      ),
    );
  }

  Widget _buildIconSearch() {
    return IconButton(
      onPressed: () {},
      icon: Container(
        height: 65,
        width: 65,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(65),
        ),
        child: Image.asset('assets/icons/search.png'),
      ),
    );
  }
}
