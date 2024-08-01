import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sipil_app/src/domain/models/UnsafeAction.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/detailModify/DetailModifyUnsafeActionPage.dart';
import 'package:sipil_app/src/presentation/widget/DefaultButtom.dart';
import 'package:sipil_app/src/utils/colors.dart';
import 'package:sipil_app/src/utils/routesName.dart';

class UnsafeActionTable extends StatelessWidget {
  final List<UnsafeAction> unsafeActions;

  const UnsafeActionTable({
    required this.unsafeActions,
  });

  @override
  Widget build(BuildContext context) {
    print('UnsafeActions: $unsafeActions');
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
          return DataRow(cells: [
            DataCell(Text(action.location.toString())),
            DataCell(Text(formattedDate)),
            DataCell(Text(action.status.toString())),
            DataCell(
                GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RoutesName.DETAILMODIFYUNSAFEACTION, arguments: action);
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => DetailModifyUnsafeActionPage(action: action)),
                      // );
                    },
                    child: Icon(Icons.edit)
                )
          ),
          ]);
        }).toList(),
      ),
    );

  }
}
