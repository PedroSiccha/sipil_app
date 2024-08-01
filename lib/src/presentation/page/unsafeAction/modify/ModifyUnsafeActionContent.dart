import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/modify/bloc/ModifyUnsafeActionBloc.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/modify/bloc/ModifyUnsafeActionEvent.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/modify/bloc/ModifyUnsafeActionState.dart';
import 'package:sipil_app/src/presentation/utils/BlocFormItem.dart';
import 'package:sipil_app/src/presentation/widget/DefaultButtom.dart';
import 'package:sipil_app/src/presentation/widget/LabelTextField.dart';
import 'package:sipil_app/src/utils/colors.dart';

import 'widget/UnsafeActionTable.dart';

class ModifyUnsafeActionContent extends StatelessWidget {

  ModifyUnsafeActionBloc? bloc;
  ModifyUnsafeActionState state;
  ValueNotifier<String> _modifyFechaDesdeNotifier;
  ValueNotifier<String> _modifyFechaHastaNotifier;

  ModifyUnsafeActionContent(this.bloc, this.state)
      : _modifyFechaDesdeNotifier = ValueNotifier<String>(state.initDate.value),
        _modifyFechaHastaNotifier = ValueNotifier<String>(state.endDate.value);

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
            Image.asset(
              'assets/img/logo.png',
            ),
            LabelTextField(
              label: 'Empresa',
              hint: 'Empresa',
              readOnly: true,
              colorLabel: Colors.black,
              controller: TextEditingController(text: state.nameCompany!.value),
              obscureText: false,
              onChanged: (text) {},
            ),
            LabelTextField(
                label: 'Nombres y Apellidos',
                hint: 'Nombres y Apellidos del Reportante',
                readOnly: true,
                colorLabel: Colors.black,
                controller: TextEditingController(text: state.nameUser!.value),
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
                      controller: TextEditingController(text: state.dniUser!.value),
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
                      controller: TextEditingController(text: state.areaProject!.value),
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
                    valueListenable: _modifyFechaDesdeNotifier,
                    builder: (context, value, child) {
                      return LabelTextField(
                        label: 'Fecha Desde',
                        hint: 'Fecha',
                        colorLabel: Colors.black,
                        onChanged: (text) {
                          bloc?.add(
                              InitDateChange(initDate: BlocFormItem(value: text)));
                        },
                        obscureText: false,
                        readOnly: true,
                        controller: TextEditingController(text: value),
                        icon: Icons.calendar_today,
                        onIconTap: () => _selectDate(context, _modifyFechaDesdeNotifier, (newValue) {
                          bloc?.add(InitDateChange(initDate: BlocFormItem(value: newValue)));
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
                    valueListenable: _modifyFechaHastaNotifier,
                    builder: (context, value, child) {
                      return LabelTextField(
                        icon: Icons.calendar_today,
                        label: 'Fecha Hasta',
                        hint: 'Fecha',
                        colorLabel: Colors.black,
                        onChanged: (text) {
                          bloc?.add(EndDateChange(endDate: BlocFormItem(value: text)));
                        },
                        obscureText: false,
                        readOnly: true,
                        controller: TextEditingController(text: value),
                        onIconTap: () => _selectDate(context, _modifyFechaHastaNotifier, (newValue) {
                          bloc?.add(EndDateChange(endDate: BlocFormItem(value: newValue)));
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
                if (state.formKey!.currentState!.validate()) {
                  bloc?.add(SearchSubmit());
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
                  'Lista de Actos Inseguros',
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