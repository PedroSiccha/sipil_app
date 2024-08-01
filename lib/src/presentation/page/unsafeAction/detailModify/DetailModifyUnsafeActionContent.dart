import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sipil_app/src/domain/models/UnsafeAction.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/detailModify/bloc/DetailModifyUnsafeActionBloc.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/detailModify/bloc/DetailModifyUnsafeActionEvent.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/detailModify/bloc/DetailModifyUnsafeActionState.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/register/widget/ListUnsafeActionPage.dart';
import 'package:sipil_app/src/presentation/utils/BlocFormItem.dart';
import 'package:sipil_app/src/presentation/widget/DefaultButtom.dart';
import 'package:sipil_app/src/presentation/widget/LabelTextField.dart';
import 'package:sipil_app/src/presentation/widget/SelectOptionImageDialog.dart';
import 'package:sipil_app/src/presentation/widget/TextAreaCustom.dart';
import 'package:sipil_app/src/utils/colors.dart';
import 'package:sipil_app/src/utils/routesName.dart';

class DetailModifyUnsafeActionContent extends StatelessWidget {
  final DetailModifyUnsafeActionBloc bloc;
  final DetailModifyUnsafeActionState state;
  final UnsafeAction action;

  DetailModifyUnsafeActionContent(this.bloc, this.state, this.action);

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
              initialValue: state.nameCompany?.value ?? '',
              obscureText: false,
              onChanged: (text) {},
            ),
            LabelTextField(
              label: 'Nombres y Apellidos',
              hint: 'Nombres y Apellidos del reportante',
              readOnly: true,
              colorLabel: Colors.black,
              initialValue: state.nameUser?.value ?? '',
              obscureText: false,
              onChanged: (text) {},
            ),
            LabelTextField(
              label: 'DNI',
              hint: 'DNI',
              colorLabel: Colors.black,
              readOnly: true,
              initialValue: state.dniUser?.value ?? '',
              onChanged: (text) {},
              obscureText: false,
            ),
            LabelTextField(
              label: 'Area / Proyecto',
              hint: 'Área o Proyecto',
              readOnly: true,
              colorLabel: Colors.black,
              initialValue: state.areaProject?.value ?? '',
              onChanged: (text) {},
              obscureText: false,
            ),
            LabelTextField(
              label: 'Responsable',
              hint: 'Responsable Área / Proyecto',
              readOnly: true,
              colorLabel: Colors.black,
              initialValue: state.responsableProject?.value ?? '',
              onChanged: (text) {},
              obscureText: false,
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: LabelTextField(
                    label: 'Fecha',
                    hint: 'Seleccione la fecha',
                    colorLabel: Colors.black,
                    onChanged: (text) {
                      bloc.add(DateReportChange(dateReport: BlocFormItem(value: text)));
                    },
                    obscureText: false,
                    controller: TextEditingController(text: DateFormat('yyyy-MM-dd').format(DateTime.parse(state.dateReport.value)) ),
                    readOnly: true,
                    validator: (value) => state.dateReport.error,
                  ),
                ),
                SizedBox(width: 8.0),
                Padding(
                  padding: const EdgeInsets.only(top: 58.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: AppColors.ColorPrincipal
                      ),
                      onPressed: () async {
                        var selectedDate = await showDatePicker(
                            context: context,
                            // initialDate: DateTime.parse(dateController.text),
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2024),
                            lastDate: DateTime(2026)
                        );
                        if (selectedDate != null) {
                          bloc.add(DateReportChange(dateReport: BlocFormItem(value: selectedDate.toLocal().toString().split(' ')[0])));
                        }
                      },
                      child: Icon(Icons.calendar_today)
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
                    hint: 'Seleccione la hora',
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
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors.ColorPrincipal,
                    ),
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
                    child: Icon(Icons.access_time),
                  ),
                ),
              ],
            ),
            LabelTextField(
              label: 'Lugar',
              hint: 'Lugar de Hallazgo',
              colorLabel: Colors.black,
              onChanged: (text) {
                bloc?.add(LocationReportChange(locationReport: BlocFormItem(value: text)));
              },
              obscureText: false,
              initialValue: action.location ?? '',
            ),
            const SizedBox(height: 12,),
            ListUnsafeActionPage(
              onChanged: (actosInseguros) {
                bloc.add(ActionInsegurosModifyListChange(unsafeActions: actosInseguros));
              },
              initialState: state.unsafeActions,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                icon: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                ),
                label: const Text(
                  'Adjuntar fotografía',
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
                onPressed: () {
                  SelectedOptionImageDialog(context,
                          () {
                        bloc?.onTakeImage();
                      },
                          () {
                        bloc?.onTakePhoto();
                      }
                  );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.ColorPrincipal
                ),
              ),
            ),
            if (state.img != null)
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    width: 150,
                    child: AspectRatio(
                      aspectRatio: 1/1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: state.img != null
                            ? Image.file(
                          state.img!,
                          fit: BoxFit.cover,
                        )
                            : FadeInImage.assetNetwork(
                          placeholder: 'assets/img/user_image.png',
                          image: state.img!.toString(),
                          fit: BoxFit.cover,
                          fadeInDuration: Duration(seconds: 1),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        bloc.add(ClearImageModifyEvent());
                      },
                    ),
                  ),
                ],
              ),
            TextAreaCustom(
              label: '¿Se tomó alguna acción inmediata?',
              maxLine: 3,
              initialValue: action.immediateAction,
              onChanged: (text) {
                bloc?.add(ImmediateActionReportChange(immediateAction: BlocFormItem(value: text)));
              },
            ),
            TextAreaCustom(
              label: '¿Cual sería la sugerencia de mejora?',
              maxLine: 3,
              initialValue: action.suggestionImprovement,
              onChanged: (text) {
                bloc?.add(SuggestionImprovementReportChange(suggestionImprovement: BlocFormItem(value: text)));
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                      child: DefaultButtom(
                        text: 'Guardar',
                        onPressed: () {
                          bloc.add(SaveSubmit());
                        },
                        isEnable: true,
                      )
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                      child: DefaultButtom(
                        text: 'Cancelar',
                        color: Colors.redAccent,
                        onPressed: () {
                          Navigator.pushNamed(context, RoutesName.DASHBOARD);
                        },
                        isEnable: true,
                      )
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}