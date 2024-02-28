import 'package:flutter/material.dart';
import 'package:gdsc_2024/model/collab_form.dart';
import 'package:gdsc_2024/pages/apply_collab_screen.dart';
import 'package:gdsc_2024/utils/app_styles.dart';

class CollabDetailsScreen extends StatelessWidget {
  final Collab collab;

  const CollabDetailsScreen({
    Key? key, // Correct the parameter name to key
    required this.collab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;
    final double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              child: Image.asset(
                'assets/images/avtBr.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: h * 0.4,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20.0),
                ),
              ),
              margin: EdgeInsets.symmetric(horizontal: 15),
              height: 0.61 * h,
              width: w,
              alignment: Alignment.bottomLeft,
              child: ListView(
                children: [
                  _buildDiscr(),
                  _buildAddDiscr(),
                  _buildConnectInfor(),
                  _buildConnectInfor(),
                ],
              ),
            ),
          ),
          Positioned(
            top: h * 0.26,
            right: 0,
            left: 0,
            bottom: 0,
            child: Container(
              width: 0.88 * w,
              height: 0.15 * h,
              margin: EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildUserImage(context),
                  SizedBox(width: 15),
                  _buildTextContent(context),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildButtonApply(context),
          ),
          Positioned(
            top: h * 0.04,
            left: w * 0.03,
            child: IconButton(
              icon: Image.asset('assets/icons/Back.png'),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserImage(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ClipOval(
          child: Image.network(
            collab.userDto.avatarUrl,
            width: 0.14 * MediaQuery.of(context).size.height,
            height: 0.14 * MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  Widget _buildTextContent(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 35),
          Text(
            collab.userDto.name,
            style: AppStyles.Heading3,
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset('assets/icons/discount.png'),
                    SizedBox(
                      width: 5,
                    ),
                    // Add some space between the icon and the text
                    Text(
                      collab.userDto.categoryAccount,
                      style: AppStyles.Subtitle,
                    ),
                  ],
                ),
                if (collab.verified) // Remove curly braces here
                  Container(
                    width: 0.425 * MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Color(0xFF00E632),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/icons/Checked.png'),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Background Check",
                          style: AppStyles.Body1.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiscr() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mô tả',
          style: AppStyles.Heading3,
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          collab.descEnterprise,
          style: AppStyles.Body1,
          maxLines: 7,
        ),
      ],
    );
  }

  Widget _buildAddDiscr() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset('assets/icons/Groupfill.png'),
              Text(collab.categoryDto.name, style: AppStyles.Subtitle),
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Image.asset('assets/icons/locationfill.png'),
              Text(collab.address, style: AppStyles.Subtitle),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: Image.asset('assets/images/Contact.png'),
          )
        ],
      ),
    );
  }

  Widget _buildConnectInfor() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nội dung liên kết',
            style: AppStyles.Heading3,
          ),
          SizedBox(height: 15),
          Text(
            '\u2022 Asperger syndrome/Autism',
            style: AppStyles.Body1,
          ),
          Text(
            '\u2022 Tourette syndrome',
            style: AppStyles.Body1,
          ),
          Text(
            '\u2022 Diabetes',
            style: AppStyles.Body1,
          ),
          Text(
            '\u2022 Behavior challenged',
            style: AppStyles.Body1,
          ),
        ],
      ),
    );
  }

  Widget _buildButtonApply(BuildContext context) {
    return Material(
      elevation: 10,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.0),
          ),
        ),
        width: MediaQuery.of(context).size.width,
        height: 0.1 * MediaQuery.of(context).size.height,
        child: Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xFFF77E26),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              minimumSize: Size(145, 50),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ApllyCollabScreen(
                    collab: collab,
                  ),
                ),
              );
            },
            child: Text(
              'Apply',
              style: AppStyles.Subtitle.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
