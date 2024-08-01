import 'package:flutter/material.dart';
import 'package:sipil_app/src/presentation/page/home/dashboard/DashboardContent.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(left: 32.0, right: 32.0, top: 64),
        child: Column(
          children: [
            Image.asset(
              'assets/img/logo.png',
            ),
            Expanded(
              child: DashboardContent(),
            ),
          ],
        ),
      ),
    );
  }
}
