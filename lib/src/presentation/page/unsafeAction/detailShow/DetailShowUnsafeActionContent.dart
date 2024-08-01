import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sipil_app/src/domain/models/UnsafeAction.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/detailShow/bloc/DetailShowUnsafeActionBloc.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/detailShow/bloc/DetailShowUnsafeActionEvent.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/detailShow/bloc/DetailShowUnsafeActionState.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/register/widget/ListUnsafeActionPage.dart';
import 'package:sipil_app/src/presentation/utils/BlocFormItem.dart';
import 'package:sipil_app/src/presentation/widget/DefaultButtom.dart';
import 'package:sipil_app/src/presentation/widget/LabelTextField.dart';
import 'package:sipil_app/src/presentation/widget/SelectOptionImageDialog.dart';
import 'package:sipil_app/src/presentation/widget/TextAreaCustom.dart';
import 'package:sipil_app/src/utils/colors.dart';
import 'package:sipil_app/src/utils/routesName.dart';

class DetailShowUnsafeActionContent extends StatelessWidget {
  final DetailShowUnsafeActionBloc bloc;
  final DetailShowUnsafeActionState state;
  final UnsafeAction action;

  DetailShowUnsafeActionContent(this.bloc, this.state, this.action);

  @override
  Widget build(BuildContext context) {
    var date = action.date?.toString() ?? '';
    DateTime dateTime = date.isNotEmpty ? DateTime.parse(date) : DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);

    print('Datos del action: $action'); // Para depuración
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.asset(
            'assets/img/logo.png',
          ),
          LabelTextField(
            label: 'Empresa',
            hint: 'Empresa',
            readOnly: true,
            colorLabel: Colors.black,
            controller: TextEditingController(text: state.nameCompany?.value ?? ''),
            obscureText: false,
            onChanged: (text) {},
          ),
          LabelTextField(
              label: 'Nombres y Apellidos',
              hint: 'Nombres y Apellidos del reportante',
              readOnly: true,
              colorLabel: Colors.black,
              controller: TextEditingController(text: state.nameUser?.value ?? ''),
              onChanged: (text) {},
              obscureText: false),
          LabelTextField(
              label: 'DNI',
              hint: 'DNI',
              colorLabel: Colors.black,
              readOnly: true,
              controller: TextEditingController(text: state.dniUser?.value ?? ''),
              onChanged: (text) {},
              obscureText: false),
          LabelTextField(
              label: 'Area / Proyecto',
              hint: 'Área o Proyecto',
              readOnly: true,
              colorLabel: Colors.black,
              controller: TextEditingController(text: state.areaProject?.value ?? ''),
              onChanged: (text) {},
              obscureText: false),
          LabelTextField(
              label: 'Responsable',
              hint: 'Responsable Área / Proyecto',
              readOnly: true,
              colorLabel: Colors.black,
              controller:
              TextEditingController(text: state.responsableProject?.value ?? ''),
              onChanged: (text) {},
              obscureText: false),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: LabelTextField(
                  label: 'Fecha',
                  hint: 'Fecha',
                  colorLabel: Colors.black,
                  onChanged: (text) {
                    bloc.add(DateReportChange(
                        dateReport: BlocFormItem(value: text)));
                  },
                  obscureText: false,
                  controller: TextEditingController(text: formattedDate),
                  readOnly: true,
                ),
              ),
              SizedBox(width: 8.0),
              Padding(
                padding: const EdgeInsets.only(top: 58.0),
                child: Expanded(
                  flex: 1,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: AppColors.ColorPrincipal),
                      onPressed: () async {
                        var selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2024),
                            lastDate: DateTime(2026));
                        if (selectedDate != null) {
                          bloc.add(DateReportChange(
                              dateReport: BlocFormItem(
                                  value: selectedDate
                                      .toLocal()
                                      .toString()
                                      .split(' ')[0])));
                        }
                      },
                      child: Icon(Icons.calendar_today)),
                ),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: LabelTextField(
                  label: 'Hora',
                  hint: 'Hora',
                  colorLabel: Colors.black,
                  onChanged: (text) {
                    bloc.add(TimeReportChange(
                        timeReport: BlocFormItem(value: text)));
                  },
                  obscureText: false,
                  controller: TextEditingController(text: action.hour ?? ''),
                  readOnly: true,
                ),
              ),
              SizedBox(width: 8.0),
              Padding(
                padding: const EdgeInsets.only(top: 58.0),
                child: Expanded(
                  flex: 1,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: AppColors.ColorPrincipal),
                      onPressed: () async {
                        TimeOfDay? selectedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (selectedTime != null) {
                          String formattedTime = selectedTime.format(context);
                          bloc.changeTime(formattedTime);
                          bloc.add(TimeReportChange(
                              timeReport: BlocFormItem(value: formattedTime)));
                        }
                      },
                      child: Icon(Icons.access_time)),
                ),
              )
            ],
          ),
          LabelTextField(
            label: 'Lugar',
            hint: 'Lugar de Hallazgo',
            colorLabel: Colors.black,
            onChanged: (text) {
              bloc.add(LocationReportChange(
                  locationReport: BlocFormItem(value: text)));
            },
            obscureText: false,
            controller: TextEditingController(text: action.location ?? ''),
            readOnly: true,
          ),
          const SizedBox(height: 12,),
          ListUnsafeActionPage(
            onChanged: (actosInseguros) {
              bloc.add(ActionInsegurosShowListChange(unsafeActions: actosInseguros));
            },
            initialState: state.unsafeActions,
          ),
          const SizedBox(
            height: 12,
          ),
          (action.img != null && action.img!.isNotEmpty)
              ? Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 16),
                width: 150,
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/img/user_image.png',
                      image: action.img!,
                      fit: BoxFit.cover,
                      fadeInDuration: Duration(seconds: 1),
                    ),
                  ),
                ),
              ),
            ],
          )
              : Container(),
          TextAreaCustom(
            label: '¿Se tomó alguna acción inmediata?',
            maxLine: 3,
            readOnly: true,
            controller: TextEditingController(text: action.immediateAction ?? ''),
            onChanged: (text) {
              bloc.add(ImmediateActionReportChange(
                  immediateAction: BlocFormItem(value: text)));
            },
          ),
          TextAreaCustom(
            label: '¿Cual sería la sugerencia de mejora?',
            maxLine: 3,
            readOnly: true,
            controller: TextEditingController(text: action.suggestionImprovement ?? ''),
            onChanged: (text) {
              bloc.add(SuggestionImprovementReportChange(
                  suggestionImprovement: BlocFormItem(value: text)));
            },
          ),
          LabelTextField(
            label: 'Estado',
            hint: 'Estado',
            colorLabel: Colors.black,
            onChanged: (text) {
              bloc.add(LocationReportChange(
                  locationReport: BlocFormItem(value: text)));
            },
            obscureText: false,
            controller: TextEditingController(text: action.status ?? ''),
            readOnly: true,
          ),
          const SizedBox(
            height: 12,
          ),
          TextAreaCustom(
            label: 'Respuesta del equipo de SST',
            maxLine: 3,
            readOnly: true,
            controller: TextEditingController(text: action.suggestionImprovement ?? ''),
            onChanged: (text) {
              bloc.add(SuggestionImprovementReportChange(
                  suggestionImprovement: BlocFormItem(value: text)));
            },
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                    child: DefaultButtom(
                      text: 'OK',
                      onPressed: () {
                        Navigator.pushNamed(context, RoutesName.DASHBOARD);
                      },
                      isEnable: true,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
