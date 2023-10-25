import 'package:flutter/material.dart';
import 'package:spec/view/widget/popup/profile_popup.dart';

class TestForPopup extends StatelessWidget {
  const TestForPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const ProfilePopup(
                      name: '우디',
                      role: '수료생',
                      position: '개발자 / 1기',
                    );
                  },
                );
              },
              child: const Text('popup'),
            ),
          ],
        ),
      ),
    );
  }
}
