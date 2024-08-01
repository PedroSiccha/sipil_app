import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:sipil_app/src/domain/models/UnsafeAction.dart';
import 'package:sipil_app/src/domain/utils/Resource.dart';
import 'package:sipil_app/src/presentation/utils/BlocFormItem.dart';

class RegisterUnsafeActionState extends Equatable {
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
  final Map<String, bool>? unsafeActions;

  const RegisterUnsafeActionState({
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
    this.unsafeActions,
  });

  toUnsafeAction() => UnsafeAction(
      date: DateTime.parse(dateReport.value),
      hour: timeReport.value ?? '',
      location: locationReport.value ?? '',
      repAct1: unsafeActions?['Mala postura corporal'] ?? false,
      repAct2: unsafeActions?['Trabajo con calzado inadecuado'] ?? false,
      repAct3: unsafeActions?['Ingerir bebidas calientes en el escritorio de trabajo'] ?? false,
      repAct4: unsafeActions?['Sobrecargar las instalaciones eléctricas'] ?? false,
      repAct5: unsafeActions?['Jugar/bromear durante el desarrollo de una actividad de riesgo'] ?? false,
      repAct6: unsafeActions?['Trabajar o permitir trabajar sin EPP’s'] ?? false,
      repAct7: unsafeActions?['Operar equipos sin autorización'] ?? false,
      repAct8: unsafeActions?['Usar equipos defectuosos'] ?? false,
      repAct9: unsafeActions?['Trabajar bajo los efectos del alcohol y/o drogas'] ?? false,
      repAct10: unsafeActions?['Desactivar dispositivos de seguridad'] ?? false,
      repAct11: unsafeActions?['Cargar o levantar incorrectamente'] ?? false,
      repAct12: unsafeActions?['Dar servicio a equipo en funcionamiento'] ?? false,
      repAct13: unsafeActions?['Uso indebido de equipos o materiales'] ?? false,
      immediateAction: immediateAction.value ?? '',
      suggestionImprovement: suggestionImprovement.value ?? '',
      status: "ENVIADO",
      answer: "",
      userId: 2,
      id: 0,
      action: unsafeActions.toString()
  );

  RegisterUnsafeActionState copyWith({
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
    Map<String, bool>? unsafeActions,
  }) {
    return RegisterUnsafeActionState(
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
      img: img?? this.img,
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
    nameCompany,
    nameUser,
    lastnameUser,
    dniUser,
    areaProject,
    responsableProject,
    img,
    unsafeActions,
  ];

  @override
  String toString() {
    return 'RegisterUnsafeActionState { dateReport: $dateReport, timeReport: $timeReport, locationReport: $locationReport, immediateAction: $immediateAction, suggestionImprovement: $suggestionImprovement, response: $response, nameCompany: $nameCompany, nameUser: $nameUser, lastnameUser: $lastnameUser, dniUser: $dniUser, areaProject: $areaProject, responsableProject: $responsableProject, img: $img, unsafeActions: $unsafeActions }';
  }

}