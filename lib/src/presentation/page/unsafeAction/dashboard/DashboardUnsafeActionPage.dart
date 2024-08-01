import 'package:flutter/material.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/dashboard/DashboardUnsafeActionContent.dart';

class DashboardUnsafeActionPage extends StatelessWidget {
  const DashboardUnsafeActionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.only(left: 32.0, right: 32.0, top: 64),
        child: Column(
          children: [
            Image.asset(
              'assets/img/logo.png',
            ),
            Expanded(
              child: DashboardUnsafeActionContent(),
            ),
          ],
        ),
      ),
    );
  }
}
