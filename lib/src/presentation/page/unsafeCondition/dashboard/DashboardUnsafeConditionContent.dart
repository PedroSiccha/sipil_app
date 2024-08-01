import 'package:flutter/material.dart';
import 'package:sipil_app/src/presentation/widget/DefaultButtom.dart';
import 'package:sipil_app/src/utils/routesName.dart';

class DashboardUnsafeConditionContent extends StatelessWidget {
  const DashboardUnsafeConditionContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DefaultButtom(
              text: 'Registrar Condición Insegura',
              onPressed: () {
                Navigator.pushNamed(context, RoutesName.REGISTERUNSAFEACT);
              },
              isEnable: true,
            ),
            DefaultButtom(
              text: 'Modificar Condición Insegura',
              onPressed: () {
                Navigator.pushNamed(context, RoutesName.MODIFYUNSAFEACT);
              },
              isEnable: true,
            ),
            DefaultButtom(
              text: 'Consultar Condición Insegura',
              onPressed: () {
                Navigator.pushNamed(context, RoutesName.SHOWUNSAFEACT);
              },
              isEnable: true,
            ),

          ],
        ),
      ),
    );
  }
}
