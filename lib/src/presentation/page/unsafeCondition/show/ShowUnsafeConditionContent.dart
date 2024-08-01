import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/show/widget/ShowUnsafeActionTable.dart';
import 'package:sipil_app/src/presentation/page/unsafeCondition/show/bloc/ShowUnsafeConditionBloc.dart';
import 'package:sipil_app/src/presentation/page/unsafeCondition/show/bloc/ShowUnsafeConditionEvent.dart';
import 'package:sipil_app/src/presentation/page/unsafeCondition/show/bloc/ShowUnsafeConditionState.dart';
import 'package:sipil_app/src/presentation/utils/BlocFormItem.dart';
import 'package:sipil_app/src/presentation/widget/DefaultButtom.dart';
import 'package:sipil_app/src/presentation/widget/LabelTextField.dart';
import 'package:sipil_app/src/utils/colors.dart';

class ShowUnsafeConditionContent extends StatelessWidget {
  final ShowUnsafeConditionBloc bloc;
  final ShowUnsafeConditionState state;

  final TextEditingController empresaController = TextEditingController();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController dniController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final ValueNotifier<String> _fechaDesdeNotifier;
  final ValueNotifier<String> _fechaHastaNotifier;

  ShowUnsafeConditionContent({
    required this.bloc,
    required this.state,
  }) : _fechaDesdeNotifier = ValueNotifier<String>(state.showInitDate.value ?? ''),
        _fechaHastaNotifier = ValueNotifier<String>(state.showEndDate.value ?? '') {
    // Inicializar los controladores con los valores del estado
    empresaController.text = state.nameCompany?.value ?? '';
    nombreController.text = state.nameUser?.value ?? '';
    dniController.text = state.dniUser?.value ?? '';
    areaController.text = state.areaProject?.value ?? '';
  }

  Future<void> _selectDate(BuildContext context, ValueNotifier<String> notifier, Function(String) onChanged) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2026),
    );
    if (selectedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
      notifier.value = formattedDate;
      onChanged(formattedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (state.nameCompany == null || state.nameUser == null) {
      return Center(child: CircularProgressIndicator());
    }
    return Form(
      key: state.formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/img/logo.png'),
            LabelTextField(
              label: 'Empresa',
              hint: 'Empresa',
              readOnly: true,
              colorLabel: Colors.black,
              controller: empresaController,
              obscureText: false,
              onChanged: (text) {},
            ),
            LabelTextField(
                label: 'Nombres y Apellidos',
                hint: 'Nombres y Apellidos del Reportante',
                readOnly: true,
                colorLabel: Colors.black,
                controller: nombreController,
                onChanged: (text) {},
                obscureText: false
            ),
            Row(
              children: [
                Expanded(
                  child: LabelTextField(
                      label: 'Dni',
                      hint: 'DNI',
                      readOnly: true,
                      colorLabel: Colors.black,
                      controller: dniController,
                      onChanged: (text) {},
                      obscureText: false
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: LabelTextField(
                      label: 'Área / Proyecto',
                      hint: 'Área',
                      readOnly: true,
                      colorLabel: Colors.black,
                      controller: areaController,
                      onChanged: (text) {},
                      obscureText: false
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ValueListenableBuilder<String>(
                    valueListenable: _fechaDesdeNotifier,
                    builder: (context, value, child) {
                      return LabelTextField(
                        label: 'Fecha Desde',
                        hint: 'Fecha',
                        colorLabel: Colors.black,
                        onChanged: (text) {
                          bloc.add(ShowInitDateConditionChange(
                              showInitDate: BlocFormItem(value: text)));
                        },
                        obscureText: false,
                        readOnly: true,
                        controller: TextEditingController(text: value),
                        icon: Icons.calendar_today,
                        onIconTap: () => _selectDate(context, _fechaDesdeNotifier, (newValue) {
                          bloc.add(ShowInitDateConditionChange(showInitDate: BlocFormItem(value: newValue)));
                        }),
                        validator: (value) {
                          return state.showInitDate.error;
                        },
                      );
                    },
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: ValueListenableBuilder<String>(
                    valueListenable: _fechaHastaNotifier,
                    builder: (context, value, child) {
                      return LabelTextField(
                        icon: Icons.calendar_today,
                        label: 'Fecha Hasta',
                        hint: 'Fecha',
                        colorLabel: Colors.black,
                        onChanged: (text) {
                          bloc.add(ShowEndDateConditionChange(showEndDate: BlocFormItem(value: text)));
                        },
                        obscureText: false,
                        readOnly: true,
                        controller: TextEditingController(text: value),
                        onIconTap: () => _selectDate(context, _fechaHastaNotifier, (newValue) {
                          bloc.add(ShowEndDateConditionChange(showEndDate: BlocFormItem(value: newValue)));
                        }),
                        validator: (value) {
                          return state.showEndDate.error;
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 12,),
            DefaultButtom(
              text: 'Buscar',
              onPressed: () {
                bloc.add(ShowSearchConditionSubmit());
                // if (state.formKey!.currentState!.validate()) {
                //   bloc.add(ShowSearchConditionSubmit());
                // } else {
                //   Fluttertoast.showToast(msg: 'Por favor complete los datos', toastLength: Toast.LENGTH_LONG);
                // }
              },
              isEnable: true,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                color: AppColors.ColorPrincipal,
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                width: double.infinity,
                child: Text(
                  'Lista de Condiciones Inseguras',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                width: double.infinity,
                child: (state.unsafeActions != null && state.unsafeActions!.isNotEmpty)?
                ShowUnsafeActionTable(unsafeActions: state.unsafeActions!) :
                Text('No hay resultados disponibles'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}