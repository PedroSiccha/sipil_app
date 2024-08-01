import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sipil_app/src/domain/models/UnsafeAction.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/detailModify/DetailModifyUnsafeActionPage.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/detailShow/DetailShowUnsafeActionPage.dart';
import 'package:sipil_app/src/presentation/widget/DefaultButtom.dart';
import 'package:sipil_app/src/utils/colors.dart';
import 'package:sipil_app/src/utils/routesName.dart';

class ShowUnsafeActionTable extends StatelessWidget {
  final List<UnsafeAction> unsafeActions;

  const ShowUnsafeActionTable({
    required this.unsafeActions,
  });

  @override
  Widget build(BuildContext context) {
    print('unsafeActions ${unsafeActions}');
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor: MaterialStateColor.resolveWith((states) => AppColors.ColorPrincipal),
        // dataRowColor: MaterialStateColor.resolveWith((states) => Colors.lightBlueAccent),
        columns: const [
          DataColumn(
            label: Text('Lugar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          DataColumn(
            label: Text('Fecha', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          DataColumn(
            label: Text('Estado', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          DataColumn(
            label: Text('Acción', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
        rows: unsafeActions.map((action) {
          DateTime dateTime = DateTime.parse(action.date.toString());
          String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
          print('DATE $formattedDate');
          return DataRow(cells: [
            DataCell(Text(action.location.toString())),
            DataCell(Text(formattedDate)),
            DataCell(Text(action.status.toString())),
            DataCell(

            GestureDetector(
            onTap: () {
              print('ACTION $action');
              Navigator.pushNamed(
                context,
                RoutesName.DETAILSHOWUNSAFEACTION,
                arguments: action,
              );
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => DetailShowUnsafeActionPage(),
              //     settings: RouteSettings(
              //       arguments: action, // Aquí asegúrate de pasar el objeto correcto
              //     ),
              //   ),
              // );

              // Navigator.pushNamed(context, RoutesName.DETAILMODIFYUNSAFEACTION, arguments: action);
          //     MaterialPageRoute(builder: (context) => DetailShowUnsafeActionPage(action: action));
          //     Navigator.pushNamed(context, RoutesName.DETAILSHOWUNSAFEACTION, arguments: action);
              // Navigator.push(
              //   context,
                // MaterialPageRoute(builder: (context) => DetailShowUnsafeActionPage(action: action)),
              //   Navigator.pushNamed(context, RoutesName.DETA, arguments: action);
              // );
              },
              child: Icon(Icons.search)
              )

            //     DefaultButtom(text: 'VER', onPressed: (){
            //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => DetailShowUnsafeActionPage(action: action)),
            //     );
            //
            //   });
            // }, isEnable: true, color: Colors.deepOrangeAccent,)
          ),
          ]);
        }).toList(),
      ),
    );
  }
}
