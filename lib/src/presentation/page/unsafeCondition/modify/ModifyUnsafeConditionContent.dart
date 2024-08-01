import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/modify/widget/UnsafeActionTable.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/show/widget/ShowUnsafeActionTable.dart';
import 'package:sipil_app/src/presentation/page/unsafeCondition/modify/bloc/ModifyUnsafeConditionBloc.dart';
import 'package:sipil_app/src/presentation/page/unsafeCondition/modify/bloc/ModifyUnsafeConditionEvent.dart';
import 'package:sipil_app/src/presentation/page/unsafeCondition/modify/bloc/ModifyUnsafeConditionState.dart';
import 'package:sipil_app/src/presentation/utils/BlocFormItem.dart';
import 'package:sipil_app/src/presentation/widget/DefaultButtom.dart';
import 'package:sipil_app/src/presentation/widget/LabelTextField.dart';
import 'package:sipil_app/src/utils/colors.dart';

class ModifyUnsafeConditionContent extends StatelessWidget {
  final ModifyUnsafeConditionBloc bloc;
  final ModifyUnsafeConditionState state;

  final TextEditingController empresaController = TextEditingController();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController dniController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final ValueNotifier<String> modifyFechaDesdeNotifier;
  final ValueNotifier<String> modifyFechaHastaNotifier;

  ModifyUnsafeConditionContent({
    required this.bloc,
    required this.state,
  }) : modifyFechaDesdeNotifier = ValueNotifier<String>(state.initDate.value ?? ''),
        modifyFechaHastaNotifier = ValueNotifier<String>(state.endDate.value ?? '') {
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
                    valueListenable: modifyFechaDesdeNotifier,
                    builder: (context, value, child) {
                      return LabelTextField(
                        label: 'Fecha Desde',
                        hint: 'Fecha',
                        colorLabel: Colors.black,
                        onChanged: (text) {
                          bloc.add(InitDateConditionChange(initDate: BlocFormItem(value: text)));
                        },
                        obscureText: false,
                        readOnly: true,
                        controller: TextEditingController(text: value),
                        icon: Icons.calendar_today,
                        onIconTap: () => _selectDate(context, modifyFechaDesdeNotifier, (newValue) {
                          bloc.add(InitDateConditionChange(initDate: BlocFormItem(value: newValue)));
                        }),
                        validator: (value) {
                          return state.initDate.error;
                        },
                      );
                    },
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: ValueListenableBuilder<String>(
                    valueListenable: modifyFechaHastaNotifier,
                    builder: (context, value, child) {
                      return LabelTextField(
                        icon: Icons.calendar_today,
                        label: 'Fecha Hasta',
                        hint: 'Fecha',
                        colorLabel: Colors.black,
                        onChanged: (text) {
                          bloc.add(EndDateConditionChange(endDate: BlocFormItem(value: text)));
                        },
                        obscureText: false,
                        readOnly: true,
                        controller: TextEditingController(text: value),
                        onIconTap: () => _selectDate(context, modifyFechaHastaNotifier, (newValue) {
                          bloc.add(EndDateConditionChange(endDate: BlocFormItem(value: newValue)));
                        }),
                        validator: (value) {
                          return state.endDate.error;
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16,),
            DefaultButtom(
              text: 'Buscar',
              onPressed: () {
                // bloc.add(SearchConditionSubmit());
                if (state.formKey!.currentState!.validate()) {
                  bloc.add(SearchConditionSubmit());
                } else {
                  Fluttertoast.showToast(msg: 'Por favor complete los datos', toastLength: Toast.LENGTH_LONG);
                }
              },
              isEnable: true,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              child: Container(
                color: AppColors.ColorPrincipal,
                padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                UnsafeActionTable(unsafeActions: state.unsafeActions!) :
                Text('No hay resultados disponibles'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}