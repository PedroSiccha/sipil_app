import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sipil_app/src/domain/models/UnsafeAction.dart';
import 'package:sipil_app/src/domain/utils/Resource.dart';
import 'package:sipil_app/src/presentation/utils/BlocFormItem.dart';

class DetailShowUnsafeActionState extends Equatable {
  final BlocFormItem dateReport;
  final BlocFormItem? nameCompany;
  final BlocFormItem? nameUser;
  final BlocFormItem? lastnameUser;
  final BlocFormItem? dniUser;
  final BlocFormItem? areaProject;
  final BlocFormItem? responsableProject;
  final BlocFormItem timeReport;
  final BlocFormItem locationReport;
  final BlocFormItem immediateAction;
  final BlocFormItem suggestionImprovement;
  final Resource? response;
  final GlobalKey<FormState>? formKey;
  final Map<String, bool> unsafeActions;

  const DetailShowUnsafeActionState({
    this.dateReport = const BlocFormItem(error: 'Verifique la fecha'),
    this.timeReport = const BlocFormItem(error: 'Verifique la hora'),
    this.locationReport = const BlocFormItem(error: 'Verifique la ubicacion'),
    this.immediateAction = const BlocFormItem(error: ''),
    this.suggestionImprovement = const BlocFormItem(error: ''),
    this.formKey,
    this.response,
    this.nameCompany,
    this.nameUser,
    this.lastnameUser,
    this.dniUser,
    this.areaProject,
    this.responsableProject,
    this.unsafeActions = const {},
  });

  // toUnsafeAction() => UnsafeAction(
  //     date: DateTime.now(),
  //     hour: timeReport.value ?? '',
  //     location: locationReport.value ?? '',
  //     repAct1: false,
  //     repAct2: false,
  //     repAct3: false,
  //     repAct4: false,
  //     repAct5: false,
  //     repAct6: false,
  //     repAct7: false,
  //     repAct8: false,
  //     repAct9: false,
  //     repAct10: false,
  //     repAct11: false,
  //     repAct12: false,
  //     repAct13: false,
  //     img: "",
  //     immediateAction: immediateAction.value ?? '',
  //     suggestionImprovement: suggestionImprovement.value ?? '',
  //     status: "ENVIADO",
  //     answer: "",
  //     userId: 2,
  //     id: 0
  // );

  DetailShowUnsafeActionState copyWith({
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
    Map<String, bool>? unsafeActions,
  }) {
    return DetailShowUnsafeActionState(
      dateReport: dateReport ?? this.dateReport,
      timeReport: timeReport ?? this.timeReport,
      locationReport: locationReport ?? this.locationReport,
      immediateAction: immediateAction ?? this.immediateAction,
      suggestionImprovement: suggestionImprovement ?? this.suggestionImprovement,
      response: response,
      formKey: formKey,
      nameCompany: nameCompany ?? this.nameCompany,
      nameUser: nameUser ?? this.nameUser,
      lastnameUser: lastnameUser ?? this.lastnameUser,
      dniUser: dniUser ?? this.dniUser,
      areaProject: areaProject ?? this.areaProject,
      responsableProject: responsableProject ?? this.responsableProject,
      unsafeActions: unsafeActions ?? this.unsafeActions,
    );
  }
  @override
  List<Object?> get props => [dateReport, timeReport, locationReport, immediateAction, suggestionImprovement, response,nameCompany, nameUser, lastnameUser, dniUser, areaProject, responsableProject, unsafeActions,];
}