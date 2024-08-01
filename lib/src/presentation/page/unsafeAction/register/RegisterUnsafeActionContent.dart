import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/register/bloc/RegisterUnsafeActionBloc.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/register/bloc/RegisterUnsafeActionEvent.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/register/bloc/RegisterUnsafeActionState.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/register/widget/ListUnsafeActionPage.dart';
import 'package:sipil_app/src/presentation/utils/BlocFormItem.dart';
import 'package:sipil_app/src/presentation/widget/DefaultButtom.dart';
import 'package:sipil_app/src/presentation/widget/LabelTextField.dart';
import 'package:sipil_app/src/presentation/widget/SelectOptionImageDialog.dart';
import 'package:sipil_app/src/presentation/widget/TextAreaCustom.dart';
import 'package:sipil_app/src/utils/colors.dart';
import 'package:sipil_app/src/utils/routesName.dart';

class RegisterUnsafeActionContent extends StatelessWidget {
  final RegisterUnsafeActionBloc bloc;
  final RegisterUnsafeActionState state;
  final Map<String, bool> actosInseguros = {};

  RegisterUnsafeActionContent(this.bloc, this.state);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: state.formKey,
      child: SingleChildScrollView(
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
                controller: TextEditingController(text: state.responsableProject?.value ?? ''),
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
                      bloc.add(DateReportChange(dateReport: BlocFormItem(value: text)));
                    },
                    obscureText: false,
                    controller: TextEditingController(text: state.dateReport.value),
                    readOnly: true,
                    validator: (value) => state.dateReport.error,
                  ),
                ),
                SizedBox(width: 8.0),
                Padding(
                  padding: const EdgeInsets.only(top: 58.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(foregroundColor: AppColors.ColorPrincipal),
                      onPressed: () async {
                        var selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2024),
                            lastDate: DateTime(2026));
                        if (selectedDate != null) {
                          bloc.add(DateReportChange(dateReport: BlocFormItem(value: selectedDate.toLocal().toString().split(' ')[0])));
                        }
                      },
                      child: Icon(Icons.calendar_today)),
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
                      bloc.add(TimeReportChange(timeReport: BlocFormItem(value: text)));
                    },
                    obscureText: false,
                    controller: TextEditingController(text: state.timeReport.value),
                    readOnly: true,
                    validator: (value) => state.timeReport.error,
                  ),
                ),
                SizedBox(width: 8.0),
                Padding(
                  padding: const EdgeInsets.only(top: 58.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(foregroundColor: AppColors.ColorPrincipal),
                      onPressed: () async {
                        TimeOfDay? selectedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (selectedTime != null) {
                          String formattedTime = selectedTime.format(context);
                          bloc.add(TimeReportChange(timeReport: BlocFormItem(value: formattedTime)));
                        }
                      },
                      child: Icon(Icons.access_time)),
                )
              ],
            ),
            TextAreaCustom(
              label: 'Lugar de Hallazgo',
              maxLine: 2,
              onChanged: (text) {
                bloc.add(LocationReportChange(locationReport: BlocFormItem(value: text)));
              },
              validator: (value) => state.locationReport.error,
            ),
            const SizedBox(
              height: 12,
            ),
            ListUnsafeActionPage(
              onChanged: (actosInseguros) {
                this.actosInseguros.addAll(actosInseguros);
                bloc.add(ActionInsegurosListChange(actionInseguro: actosInseguros));
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                icon: const Icon(Icons.camera_alt, color: Colors.white),
                label: const Text('Adjuntar fotografía', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  SelectedOptionImageDialog(context, () {
                    bloc.onTakeImage();
                  }, () {
                    bloc.onTakePhoto();
                  });
                },
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.ColorPrincipal),
              ),
            ),
            if (state.img != null)
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 16.0),
                    width: 150,
                    child: AspectRatio(
                      aspectRatio: 1 / 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.file(state.img!, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 0.0,
                      right: 0.0,
                      child: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          bloc.add(ClearImageEvent());
                        },
                      )
                  )
                ],
              ),
            TextAreaCustom(
              label: '¿Se tomó alguna acción inmediata?',
              maxLine: 3,
              onChanged: (text) {
                bloc.add(ImmediateActionReportChange(immediateAction: BlocFormItem(value: text)));
              },
            ),
            TextAreaCustom(
              label: '¿Cual sería la sugerencia de mejora?',
              maxLine: 3,
              onChanged: (text) {
                bloc.add(SuggestionImprovementReportChange(suggestionImprovement: BlocFormItem(value: text)));
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                      child: DefaultButtom(
                        text: 'Enviar',
                        onPressed: () {
                          if (state.formKey?.currentState?.validate() ?? false) {
                            bloc.add(SaveSubmit(unsafeActions: actosInseguros));
                          } else {
                            Fluttertoast.showToast(msg: 'Verifique los datos', toastLength: Toast.LENGTH_LONG);
                          }
                        },
                        isEnable: true,
                      )),
                  const SizedBox(width: 8),
                  Expanded(
                      child: DefaultButtom(
                        text: 'Cancelar',
                        color: Colors.redAccent,
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
      ),
    );
  }
}