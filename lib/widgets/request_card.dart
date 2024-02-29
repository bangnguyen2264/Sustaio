import 'package:flutter/material.dart';
import 'package:gdsc_2024/model/collab_request.dart';
import 'package:gdsc_2024/utils/app_styles.dart';
import 'package:google_fonts/google_fonts.dart';

class RequestCard extends StatelessWidget {
  final CollabRequest collabRequest;

  const RequestCard({super.key, required this.collabRequest});

  @override
  Widget build(BuildContext context) {
    bool _isTapped = false;
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Container(
      height: 0.18 * h,
      width: 0.9 * h,
      margin: const EdgeInsets.all(20),
      decoration: _buildDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 0.088 * h,
            width: 0.9 * w,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(15.0),
              ),
              color: Color(0xFFF3F3F3),
            ),
            child: Row(
              children: [
                _buildUserImage(context),
                _buildTextContent(),
              ],
            ),
          ),
          Container(
            height: 0.088 * h,
            width: 0.9 * w,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(15.0),
              ),
            ),
            child: Row(
              children: [
                _buildBottomCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration _buildDecoration() {
    return BoxDecoration(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(15.0),
        bottom: Radius.circular(12),
      ),
      border: Border.all(
        color: Colors.grey,
        width: 1.0,
      ),
    );
  }

  Widget _buildUserImage(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(0.07 * MediaQuery.of(context).size.height),
        child: Image.network(
          collabRequest.collabDto.userDto.avatarUrl,
          width: 0.07 * MediaQuery.of(context).size.height,
          height: 0.07 * MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildTextContent() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Phân phối sản phẩm',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: GoogleFonts.inter().fontFamily,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Gửi đến: ${collabRequest.collabDto.userDto.name}',
                style: AppStyles.Body2,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomCard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 7),
              _buildTextContentatBottom('assets/icons/paperclip.png'),
              _buildTextContentatBottom('assets/icons/Group.png'),
              _buildTextContentatBottom('assets/icons/location.png'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextContentatBottom(String path) {
    return Row(
      children: [
        Image.asset(path),
      ],
    );
  }

  Widget _buildBackgroundCheck() {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      child: Image.asset('assets/icons/Checked.png'),
    );
  }

  Widget _buildHeartIcon(bool _isTapped) {
    return GestureDetector(
      onTap: () {
        // Toggle the tapped state when the icon is pressed
        _isTapped = !_isTapped;
      },
      child: SizedBox(
        width: 24.0, // Set your desired width
        height: 24.0, // Set your desired height
        child: _isTapped
            ? Image.asset('assets/icons/like.png')
            : Image.asset('assets/icons/like-filled.png'),
      ),
    );
  }
}
