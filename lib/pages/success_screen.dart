import 'package:flutter/material.dart';
import 'package:gdsc_2024/pages/collab_screen.dart';
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
                    builder: (context) => const CollabScreen(),
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
