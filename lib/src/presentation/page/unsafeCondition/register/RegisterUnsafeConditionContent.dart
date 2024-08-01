import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:sipil_app/src/presentation/page/unsafeCondition/register/bloc/RegisterUnsafeConditionBloc.dart';
import 'package:sipil_app/src/presentation/page/unsafeCondition/register/bloc/RegisterUnsafeConditionState.dart';
import 'package:sipil_app/src/presentation/page/unsafeCondition/register/widget/ListInsafeConditionPage.dart';
import 'package:sipil_app/src/presentation/utils/BlocFormItem.dart';
import 'package:sipil_app/src/presentation/widget/DefaultButtom.dart';
import 'package:sipil_app/src/presentation/widget/LabelTextField.dart';
import 'package:sipil_app/src/presentation/widget/SelectOptionImageDialog.dart';
import 'package:sipil_app/src/presentation/widget/TextAreaCustom.dart';
import 'package:sipil_app/src/utils/colors.dart';
import 'package:sipil_app/src/utils/routesName.dart';

import 'bloc/RegisterUnsafeConditionEvent.dart';

class RegisterUnsafeConditionContent extends StatelessWidget {
  final RegisterUnsafeConditionBloc bloc;
  final RegisterUnsafeConditionState state;
  final Map<String, bool> actionUnsafe = {};

  RegisterUnsafeConditionContent({
    required this.bloc,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: state.formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/img/logo.png'),
            _buildTextField('Empresa', state.nameCompany?.value ?? ''),
            _buildTextField('Nombres y Apellidos', state.nameUser?.value ?? ''),
            _buildTextField('DNI', state.dniUser?.value ?? ''),
            _buildTextField('Área / Proyecto', state.areaProject?.value ?? ''),
            _buildTextField('Responsable', state.responsableProject?.value ?? ''),
            _buildDateField(context),
            _buildTimeField(context),
            TextAreaCustom(
              label: 'Lugar de Hallazgo',
              maxLine: 2,
              onChanged: (text) {
                bloc.add(LocationConditionReportChange(
                    locationReport: BlocFormItem(value: text)));
              },
              validator: (value) {
                return value != null && value.isNotEmpty ? null : 'Ingrese un lugar de hallazgo';
              },
            ),
            const SizedBox(height: 12),
            ListUnsafeConditionPage(
              onChanged: (actionUnsafe) {
                this.actionUnsafe.addAll(actionUnsafe);
                bloc.add(ActionUnsafeListChange(actionUnsafe: actionUnsafe));
              },
            ),
            _buildImagePicker(context),
            _buildImageDisplay(),
            TextAreaCustom(
              label: '¿Se tomó alguna acción inmediata?',
              maxLine: 3,
              onChanged: (text) {
                bloc.add(ImmediateActionConditionReportChange(
                    immediateAction: BlocFormItem(value: text)));
              },
              validator: (value) {
                return null;
              },
            ),
            TextAreaCustom(
              label: '¿Cuál sería la sugerencia de mejora?',
              maxLine: 3,
              onChanged: (text) {
                bloc.add(SuggestionImprovementConditionReportChange(
                    suggestionImprovement: BlocFormItem(value: text)));
              },
              validator: (value) {
                return null;
              },
            ),
            _buildButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String initialValue) {
    return LabelTextField(
      label: label,
      hint: label,
      readOnly: true,
      colorLabel: Colors.black,
      controller: TextEditingController(text: initialValue),
      onChanged: (text) {},
      obscureText: false,
    );
  }

  Widget _buildDateField(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: LabelTextField(
            label: 'Fecha',
            hint: 'Fecha',
            colorLabel: Colors.black,
            onChanged: (text) {
              bloc.add(DateConditionReportChange(
                  dateReport: BlocFormItem(value: text)));
            },
            obscureText: false,
            controller: TextEditingController(text: state.dateReport.value),
            readOnly: true,
            validator: (value) {
              return value != null && value.isNotEmpty ? null : 'Ingrese una fecha';
            },
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(top: 58.0),
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
                  bloc.add(DateConditionReportChange(
                      dateReport: BlocFormItem(
                          value: DateFormat('yyyy-MM-dd').format(selectedDate))));
                }
              },
              child: Icon(Icons.calendar_today),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeField(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: LabelTextField(
            label: 'Hora',
            hint: 'Hora',
            colorLabel: Colors.black,
            onChanged: (text) {
              bloc.add(TimeConditionReportChange(
                  timeReport: BlocFormItem(value: text)));
            },
            obscureText: false,
            controller: TextEditingController(text: state.timeReport.value),
            readOnly: true,
            validator: (value) {
              return value != null && value.isNotEmpty ? null : 'Ingrese una hora';
            },
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(top: 58.0),
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
                  bloc.add(TimeConditionReportChange(
                      timeReport: BlocFormItem(value: formattedTime)));
                }
              },
              child: Icon(Icons.access_time),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImagePicker(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton.icon(
        icon: const Icon(
          Icons.camera_alt,
          color: Colors.white,
        ),
        label: const Text(
          'Adjuntar fotografía',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          SelectedOptionImageDialog(context, () {
            bloc.onTakeImage();
          }, () {
            bloc.onTakePhoto();
          });
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.ColorPrincipal),
      ),
    );
  }

  Widget _buildImageDisplay() {
    return BlocBuilder<RegisterUnsafeConditionBloc, RegisterUnsafeConditionState>(
      buildWhen: (previous, current) => previous.img != current.img,
      builder: (context, state) {
        return (state.img != null)
            ? Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 16),
              width: 150,
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.file(
                    state.img!,
                    fit: BoxFit.cover,
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
                  BlocProvider.of<RegisterUnsafeConditionBloc>(context).add(ClearImageConditionEvent());
                },
              ),
            ),
          ],
        )
            : Container();
      },
    );
  }



  Widget _buildButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: DefaultButtom(
              text: 'Enviar',
              onPressed: () {
                if (state.formKey?.currentState?.validate() ?? false) {
                  bloc.add(SaveConditionSubmit(unsafeConditions: state.unsafeConditions ?? {}));
                } else {
                  Fluttertoast.showToast(
                      msg: 'Verifique los datos',
                      toastLength: Toast.LENGTH_LONG);
                }
              },
              isEnable: true,
            ),
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
            ),
          ),
        ],
      ),
    );
  }
}
