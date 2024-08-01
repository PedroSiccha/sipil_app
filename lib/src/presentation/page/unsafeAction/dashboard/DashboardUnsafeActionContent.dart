import 'package:flutter/material.dart';
import 'package:sipil_app/src/presentation/widget/DefaultButtom.dart';
import 'package:sipil_app/src/utils/routesName.dart';

class DashboardUnsafeActionContent extends StatelessWidget {
  const DashboardUnsafeActionContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DefaultButtom(
              text: 'Registrar Acto Inseguro',
              onPressed: () {
                // Navigator.pushNamed(context, RoutesName.REGISTERUNSAFEACT);
                Navigator.pushNamed(context, RoutesName.REGISTERINSECUREACT);
              },
              isEnable: true,
            ),
            DefaultButtom(
              text: 'Modificar Acto Inseguro',
              onPressed: () {
                Navigator.pushNamed(context, RoutesName.MODIFYINSECUREACT);
              },
              isEnable: true,
            ),
            DefaultButtom(
              text: 'Consultar Acto Inseguro',
              onPressed: () {
                Navigator.pushNamed(context, RoutesName.SHOWINSECUREACT);
              },
              isEnable: true,
            )
          ],
        ),
      ),
    );
  }
}
