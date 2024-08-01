import 'package:flutter/material.dart';
import 'package:sipil_app/src/presentation/widget/DefaultButtom.dart';
import 'package:sipil_app/src/utils/routesName.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bienvenido al APP para el registro de Actos o Condiciones Inseguras',
            ),
            const SizedBox(
              height: 8,
            ),
            DefaultButtom(
              text: 'Ver videos de seguridad',
              onPressed: () {
                Navigator.pushNamed(context, RoutesName.VIEWMOVIE);
              },
              isEnable: true,
            ),
            DefaultButtom(
              text: 'Actos Inseguros',
              onPressed: () {
                Navigator.pushNamed(context, RoutesName.DASHBOARDINSECUREACT);
              },
              isEnable: true,
            ),
            DefaultButtom(
              text: 'Condiciones Inseguras',
              onPressed: () {
                Navigator.pushNamed(context, RoutesName.DASHBOARDUNSAFEACT);
              },
              isEnable: true,
            )
          ],
        ),
      ),
    );
  }
}
