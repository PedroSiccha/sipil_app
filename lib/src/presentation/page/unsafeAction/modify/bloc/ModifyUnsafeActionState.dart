import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:sipil_app/src/domain/models/SearchUnsafeAction.dart';
import 'package:sipil_app/src/domain/models/UnsafeAction.dart';
import 'package:sipil_app/src/domain/utils/Resource.dart';
import 'package:sipil_app/src/presentation/utils/BlocFormItem.dart';

class ModifyUnsafeActionState extends Equatable {
  final List<UnsafeAction>? unsafeActions;
  final BlocFormItem? nameCompany;
  final BlocFormItem? nameUser;
  final BlocFormItem? lastnameUser;
  final BlocFormItem? dniUser;
  final BlocFormItem? areaProject;
  final BlocFormItem? responsableProject;
  final BlocFormItem initDate;
  final BlocFormItem endDate;
  final Resource? response;
  final GlobalKey<FormState>? formKey;

  const ModifyUnsafeActionState({
    this.unsafeActions,
    this.nameCompany,
    this.nameUser,
    this.lastnameUser,
    this.dniUser,
    this.areaProject,
    this.responsableProject,
    this.initDate = const BlocFormItem(error: 'Verifique la fecha de inicio'),
    this.endDate = const BlocFormItem(error: 'Verifique la fecha fin'),
    this.formKey,
    this.response,
  });

  toUnsafeAction() => SearchUnsafeAction(
      companyName: nameCompany?.value ?? '',
      username: nameUser?.value ?? '',
      dni: dniUser?.value ?? '',
      area: areaProject?.value ?? '',
      fromDate: initDate.value ?? '',
      toDate: endDate.value ?? ''
  );

  ModifyUnsafeActionState copyWith({
    BlocFormItem? nameCompany,
    BlocFormItem? nameUser,
    BlocFormItem? lastnameUser,
    BlocFormItem? dniUser,
    BlocFormItem? areaProject,
    BlocFormItem? responsableProject,
    BlocFormItem? initDate,
    BlocFormItem? endDate,
    Resource? response,
    GlobalKey<FormState>? formKey,
    List<UnsafeAction>? unsafeActions,
  }) {
    return ModifyUnsafeActionState(
      nameCompany: nameCompany ?? this.nameCompany,
      nameUser: nameUser ?? this.nameUser,
      lastnameUser: lastnameUser ?? this.lastnameUser,
      dniUser: dniUser ?? this.dniUser,
      areaProject: areaProject ?? this.areaProject,
      responsableProject: responsableProject ?? this.responsableProject,
      initDate: initDate ?? this.initDate,
      endDate: endDate ?? this.endDate,
      response: response,
      formKey: formKey,
      unsafeActions: unsafeActions,
    );
  }

  @override
  List<Object?> get props => [nameUser, lastnameUser, dniUser, areaProject, responsableProject, initDate, endDate, response,nameCompany, unsafeActions];

}