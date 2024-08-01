import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sipil_app/src/domain/models/SearchUnsafeAction.dart';
import 'package:sipil_app/src/domain/models/UnsafeAction.dart';
import 'package:sipil_app/src/domain/utils/Resource.dart';
import 'package:sipil_app/src/presentation/utils/BlocFormItem.dart';

class ShowUnsafeActionState extends Equatable {
  final List<UnsafeAction>? unsafeActions;
  final BlocFormItem? nameCompany;
  final BlocFormItem? nameUser;
  final BlocFormItem? lastnameUser;
  final BlocFormItem? dniUser;
  final BlocFormItem? areaProject;
  final BlocFormItem? responsableProject;
  final BlocFormItem showInitDate;
  final BlocFormItem showEndDate;
  final Resource? response;
  final GlobalKey<FormState>? formKey;

  const ShowUnsafeActionState({
    this.unsafeActions,
    this.nameCompany,
    this.nameUser,
    this.lastnameUser,
    this.dniUser,
    this.areaProject,
    this.responsableProject,
    this.showInitDate = const BlocFormItem(error: 'Verifique la fecha de Inicio'),
    this.showEndDate = const BlocFormItem(error: 'Verifique la fecha Fin'),
    this.formKey,
    this.response,
  });

  toUnsafeAction() => SearchUnsafeAction(
      companyName: nameCompany?.value ?? '',
      username: nameUser?.value ?? '',
      dni: dniUser?.value ?? '',
      area: areaProject?.value ?? '',
      fromDate: showInitDate.value ?? '',
      toDate: showEndDate.value ?? ''
  );

  ShowUnsafeActionState copyWith({
    BlocFormItem? nameCompany,
    BlocFormItem? nameUser,
    BlocFormItem? lastnameUser,
    BlocFormItem? dniUser,
    BlocFormItem? areaProject,
    BlocFormItem? responsableProject,
    BlocFormItem? showInitDate,
    BlocFormItem? showEndDate,
    Resource? response,
    GlobalKey<FormState>? formKey,
    List<UnsafeAction>? unsafeActions,
  }) {
    return ShowUnsafeActionState(
      nameCompany: nameCompany ?? this.nameCompany,
      nameUser: nameUser ?? this.nameUser,
      lastnameUser: lastnameUser ?? this.lastnameUser,
      dniUser: dniUser ?? this.dniUser,
      areaProject: areaProject ?? this.areaProject,
      responsableProject: responsableProject ?? this.responsableProject,
      showInitDate: showInitDate ?? this.showInitDate,
      showEndDate: showEndDate ?? this.showEndDate,
      response: response,
      formKey: formKey,
      unsafeActions: unsafeActions,
    );
  }

  @override
  List<Object?> get props => [nameUser, lastnameUser, dniUser, areaProject, responsableProject, showInitDate, showEndDate, response,nameCompany, unsafeActions];

}