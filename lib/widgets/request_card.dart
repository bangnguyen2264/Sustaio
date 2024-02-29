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
      height: 0.2 * h,
      width: 0.9 * h,
      margin: const EdgeInsets.all(20),
      decoration: _buildDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 0.098 * h,
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
            height: 0.098 * h,
            width: 0.9 * w,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(15.0),
              ),
            ),
            child: Expanded(
              child: _buildBottomCard(),
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
          SizedBox(height: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                collabRequest.title,
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
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextContentAtBottom(
            'assets/icons/paperclip.png',
            'Đính kèm 1 ảnh',
          ),
          _buildTextContentAtBottom(
            'assets/icons/Group.png',
            collabRequest.tag,
          ),
          _buildTextContentAtBottom(
            'assets/icons/location.png',
            collabRequest.address,
          ),
        ],
      ),
    );
  }

  Widget _buildTextContentAtBottom(String path, String content) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(path),
        SizedBox(width: 5),
        Expanded(
          child: Text(
            content,
            style: AppStyles.Body2,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildBackgroundCheck() {
    return Image.asset('assets/icons/Checked.png');
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
