import 'package:flutter/material.dart';
import 'package:gdsc_2024/components/app_bar.dart';
import 'package:gdsc_2024/model/collab_form.dart';
import 'package:gdsc_2024/model/collab_request.dart';
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
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 3,
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
              Tab(text: 'Rejected')
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
          toolbarHeight: 0.1 * h,
        ),
        body: TabBarView(
          children: [
            _buildPendingTab(),
            _buildAcceptedTab(),
            _buildRejectedTab()
          ],
        ),
      ),
    );
  }

  Widget _buildPendingTab() {
    return FutureBuilder<List<CollabRequest>>(
      future: CollabRequestService().getCollabRequestByStatus('PENDING'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<CollabRequest> collabList = snapshot.data ?? [];
          return _buildListCardToCollab(collabList, context);
        }
      },
    );
  }

  Widget _buildAcceptedTab() {
    return FutureBuilder<List<CollabRequest>>(
      future: CollabRequestService().getCollabRequestByStatus('ACCEPTED'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<CollabRequest> collabList = snapshot.data ?? [];
          return _buildListCardToCollab(collabList, context);
        }
      },
    );
  }

  Widget _buildListCardToCollab(
      List<CollabRequest> collabList, BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: collabList.length,
        itemBuilder: (context, index) {
          return RequestCard(collabRequest: collabList[index]);
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

  Widget _buildRejectedTab() {
    return FutureBuilder<List<CollabRequest>>(
      future: CollabRequestService().getCollabRequestByStatus('REJECTED'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<CollabRequest> collabList = snapshot.data ?? [];
          return _buildListCardToCollab(collabList, context);
        }
      },
    );
  }
}
