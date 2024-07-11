import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gdsc_2024/model/collab_form.dart';
import 'package:gdsc_2024/pages/success_screen.dart';
import 'package:gdsc_2024/services/collab_request_service.dart';
import 'package:gdsc_2024/services/image_service.dart';
import 'package:gdsc_2024/utils/app_styles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class ApllyCollabScreen extends StatefulWidget {
  final Collab collab;

  const ApllyCollabScreen({
    Key? key,
    required this.collab,
  }) : super(key: key);

  @override
  _ApllyCollabScreenState createState() => _ApllyCollabScreenState();
}

class _ApllyCollabScreenState extends State<ApllyCollabScreen> {
  late PageController _pageController;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();
  TextEditingController tagController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController describtionController = TextEditingController();
  File? image;

  Future _pickImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return;

      setState(() {
        image = File(pickedFile.path);
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    int _currentPage = 0;

    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    _buildUserImage(context),
                    _buildTextContent(),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 0.25 * MediaQuery.of(context).size.height,
            right: 0,
            left: 0,
            child: Material(
              elevation: 10,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 0.75 * MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: PageView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: [
                      _buildFirst(),
                      _buildSecond(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormBasic() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildInputField(
          nameController,
          'Họ và tên',
        ),
        _buildInputField(
          emailController,
          'Email',
        ),
        _buildInputField(
          addressController,
          'Địa chỉ',
        ),
        _buildInputField(
          phonenumberController,
          'Số điện thoại',
        ),
        _buildInputField(
          tagController,
          'Lĩnh vực cây trồng',
        ),
      ],
    );
  }

  Widget _buildFormDetail() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Minh chứng'),
        _buildButtonAddFile(context),
        _buildInputField(titleController, 'Tiêu đề'),
        _buildDescField(
          describtionController,
          'Mô tả',
        ),
      ],
    );
  }

  Widget _buildDescField(TextEditingController controller, String labelText) {
    return Container(
      width: 293,
      height: 170,
      child: Align(
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Mô tả'),
            TextField(
              controller: controller,
              maxLines: 5,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String labelText) {
    return Container(
      width: 293,
      height: 54,
      child: Align(
        alignment: Alignment.center,
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: labelText,
          ),
        ),
      ),
    );
  }

  Widget _buildUserImage(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            widget.collab.userDto.avatarUrl,
            width: 0.2 * MediaQuery.of(context).size.height,
            height: 0.2 * MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  Widget _buildTextContent() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.collab.content,
            style: AppStyles.Label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            children: [
              Image.asset('assets/icons/discount.png'),
              Text(widget.collab.userDto.categoryAccount,
                  style: AppStyles.Body2),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButtonAddFile(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: image == null ? AppStyles.neutralColor6 : Color(0xFFF007AFF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        fixedSize: Size(110, 33),
      ),
      onPressed: () {
        _pickImage();
      },
      child: Text(
        'Thêm tệp',
        style: TextStyle(
          color: Colors.white,
          fontFamily: GoogleFonts.roboto().fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        maxLines: 1,
      ),
    );
  }

  Widget _buildFirst() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Thông tin cơ bản',
            style: AppStyles.Heading3,
          ),
          SizedBox(height: 10),
          Text(
            'Điền dữ liệu cho hồ sơ. Quá trình này sẽ mất vài phút.',
            style: AppStyles.Body2,
          ),
          SizedBox(height: 15),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
                bottom: Radius.circular(8),
              ),
            ),
            child: Center(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(20),
                    child: _buildFormBasic(),
                  ),
                ],
              ),
            ),
          ),
          _buildButtonToContinue(),
        ],
      ),
    );
  }

  Widget _buildSecond() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mô tả và minh chứng',
            style: AppStyles.Heading3,
          ),
          SizedBox(height: 10),
          Text(
            'Mô tả chi tiết và thêm minh chứng (nếu có)',
            style: AppStyles.Body2,
          ),
          SizedBox(height: 15),
          Container(
            height: 334,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
                bottom: Radius.circular(8),
              ),
            ),
            child: Center(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(20),
                    child: _buildFormDetail(),
                  ),
                ],
              ),
            ),
          ),
          _buildRowButtonToApply(),
        ],
      ),
    );
  }

  Widget _buildButtonToContinue() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Color(0xFFF007AFF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          maximumSize: Size(127, 50),
        ),
        onPressed: () {
          allFieldsNotEmpty()
              ? _pageController.nextPage(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.ease,
                )
              : showErrorMessage();
        },
        child: Center(
          child: Text(
            'Continue',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRowButtonToApply() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: AppStyles.neutralColor7,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              maximumSize: Size(124, 50),
            ),
            onPressed: () {
              _pageController.previousPage(
                duration: Duration(milliseconds: 200),
                curve: Curves.ease,
              );
            },
            child: Text(
              'Back',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontFamily: GoogleFonts.poppins().fontFamily,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xFFF007AFF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              maximumSize: Size(127, 50),
            ),
            onPressed: () {
              ImageNotEmpty()
                  ? {
                      _submitForm(),
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SuccessScreen(),
                        ),
                      ),
                    }
                  : showErrorImageNull();
            },
            child: Text(
              'Submit',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontFamily: GoogleFonts.poppins().fontFamily,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool allFieldsNotEmpty() {
    return nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        phonenumberController.text.isNotEmpty &&
        addressController.text.isNotEmpty;
  }

  bool ImageNotEmpty() {
    return image != null;
  }

  void showErrorMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          'Please fill in all fields',
          style: AppStyles.Body1.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void showErrorImageNull() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          'Requires photo proof',
          style: AppStyles.Body1.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Future<void> _submitForm() async {
    String? imageUrl = await ImageService().uploadImage(image!);

    if (imageUrl != null) {
      Map<String, dynamic> requestData = {
        "fullName": nameController.text,
        "email": emailController.text,
        "phone": phonenumberController.text,
        "address": addressController.text,
        "tag": tagController.text,
        "title": titleController.text,
        "description": describtionController.text,
        "photographicEvidenceUrl": imageUrl,
        "collabId": widget.collab.id
      };

      await CollabRequestService().postCollabRequest(requestData);
    } else {
      print('failed to get image url');
    }
  }
}
