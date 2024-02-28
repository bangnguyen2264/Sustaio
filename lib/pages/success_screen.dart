import 'package:flutter/material.dart';
import 'package:gdsc_2024/backgrounds/home_background.dart';
import 'package:gdsc_2024/pages/collab_screen.dart';
import 'package:gdsc_2024/pages/home_screen.dart';
import 'package:gdsc_2024/utils/app_styles.dart';

class SuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/success.png'),
            SizedBox(height: 40),
            Text(
              'Apply Successfull',
              style: AppStyles.Label,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeBackground(),
                  ),
                );
              },
              child: Text(
                'Return',
                style: AppStyles.Label.copyWith(
                  color: Colors.white,
                ),
              ),
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(
                  Size(
                    0.9 * MediaQuery.of(context).size.width,
                    0.06 * MediaQuery.of(context).size.height,
                  ),
                ),
                backgroundColor:
                    MaterialStateProperty.all(AppStyles.primaryColor1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
