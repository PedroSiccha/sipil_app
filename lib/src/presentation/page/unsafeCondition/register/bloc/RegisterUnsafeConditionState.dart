import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sipil_app/src/domain/models/UnsafeAction.dart';
import 'package:sipil_app/src/domain/models/UnsafeCondition.dart';
import 'package:sipil_app/src/domain/utils/Resource.dart';
import 'package:sipil_app/src/presentation/utils/BlocFormItem.dart';

class RegisterUnsafeConditionState extends Equatable {
  final BlocFormItem dateReport;
  final BlocFormItem? nameCompany;
  final BlocFormItem? nameUser;
  final BlocFormItem? lastnameUser;
  final BlocFormItem? dniUser;
  final BlocFormItem? areaProject;
  final BlocFormItem? responsableProject;
  final File? img;
  final BlocFormItem timeReport;
  final BlocFormItem locationReport;
  final BlocFormItem immediateAction;
  final BlocFormItem suggestionImprovement;
  final Resource? response;
  final GlobalKey<FormState>? formKey;
  final Map<String, bool>? unsafeConditions;
  final Map<String, bool>? unsafeActions;

  const RegisterUnsafeConditionState({
    this.dateReport = const BlocFormItem(error: 'Verifique la fecha'),
    this.timeReport = const BlocFormItem(error: 'Verifique la hora'),
    this.locationReport = const BlocFormItem(error: 'Verifique el lugar de hallazgo'),
    this.immediateAction = const BlocFormItem(error: ''),
    this.suggestionImprovement = const BlocFormItem(error: ''),
    this.img,
    this.formKey,
    this.response,
    this.nameCompany,
    this.nameUser,
    this.lastnameUser,
    this.dniUser,
    this.areaProject,
    this.responsableProject,
    this.unsafeConditions,
    this.unsafeActions,
  });

  UnsafeAction toUnsafeAction() => UnsafeAction(
    date: DateTime.parse(dateReport.value),
    hour: timeReport.value ?? '',
    location: locationReport.value ?? '',
    repAct1: unsafeActions?['Falta de orden y limpieza'] ?? false,
    repAct2: unsafeActions?['Guardas o barreras inadecuadas'] ?? false,
    repAct3: unsafeActions?['Pasamanos de las escaleras inadecuadas o mal estado'] ?? false,
    repAct4: unsafeActions?['Iluminacion deficiente/excesiva en el ambiente del trabajo'] ?? false,
    repAct5: unsafeActions?['Equipos de protección personal incorrectos o inadecuados'] ?? false,
    repAct6: unsafeActions?['Ruido excesivo en el área de trabajo'] ?? false,
    repAct7: unsafeActions?['Piso en mal estado'] ?? false,
    repAct8: unsafeActions?['Ascensores en mal estado'] ?? false,
    repAct9: unsafeActions?['Falta de señalización en área o equipo'] ?? false,
    repAct10: unsafeActions?['Presencia de polvos/gases en el área de trabajo'] ?? false,
    repAct11: unsafeActions?['Condiciones de trabajo peligrosas'] ?? false,
    repAct12: unsafeActions?['Herramientas y equipos defectuoso'] ?? false,
    repAct13: unsafeActions?['Materiales químicos peligrosos expuestos'] ?? false,
    immediateAction: immediateAction.value ?? '',
    suggestionImprovement: suggestionImprovement.value ?? '',
    status: "ENVIADO",
    answer: "",
    userId: 2,
    id: 0,
    action: unsafeActions.toString(),
  );

  RegisterUnsafeConditionState copyWith({
    BlocFormItem? dateReport,
    BlocFormItem? timeReport,
    BlocFormItem? locationReport,
    BlocFormItem? immediateAction,
    BlocFormItem? suggestionImprovement,
    Resource? response,
    GlobalKey<FormState>? formKey,
    BlocFormItem? nameCompany,
    BlocFormItem? nameUser,
    BlocFormItem? lastnameUser,
    BlocFormItem? dniUser,
    BlocFormItem? areaProject,
    BlocFormItem? responsableProject,
    File? img,
    Map<String, bool>? unsafeConditions,
    Map<String, bool>? unsafeActions,
  }) {
    return RegisterUnsafeConditionState(
      dateReport: dateReport ?? this.dateReport,
      timeReport: timeReport ?? this.timeReport,
      locationReport: locationReport ?? this.locationReport,
      immediateAction: immediateAction ?? this.immediateAction,
      suggestionImprovement: suggestionImprovement ?? this.suggestionImprovement,
      response: response ?? this.response,
      formKey: formKey ?? this.formKey,
      nameCompany: nameCompany ?? this.nameCompany,
      nameUser: nameUser ?? this.nameUser,
      lastnameUser: lastnameUser ?? this.lastnameUser,
      dniUser: dniUser ?? this.dniUser,
      areaProject: areaProject ?? this.areaProject,
      responsableProject: responsableProject ?? this.responsableProject,
      img: img ?? this.img,
      unsafeConditions: unsafeConditions ?? this.unsafeConditions,
      unsafeActions: unsafeActions ?? this.unsafeActions,
    );
  }

  @override
  List<Object?> get props => [
    dateReport,
    timeReport,
    locationReport,
    immediateAction,
    suggestionImprovement,
    response,
    nameUser,
    nameCompany,
    lastnameUser,
    dniUser,
    areaProject,
    responsableProject,
    img,
    unsafeConditions,
    unsafeActions,
  ];
}
