import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:sipil_app/src/domain/models/UnsafeAction.dart';
import 'package:sipil_app/src/presentation/utils/BlocFormItem.dart';

abstract class DetailModifyUnsafeActionEvent extends Equatable {
  const DetailModifyUnsafeActionEvent();

  @override
  List<Object?> get props => [];
}

class DetailModifyUnsafeActionInitEvent extends DetailModifyUnsafeActionEvent {
  const DetailModifyUnsafeActionInitEvent();
}

class DateReportChange extends DetailModifyUnsafeActionEvent {
  final BlocFormItem dateReport;

  const DateReportChange({required this.dateReport});

  @override
  List<Object?> get props => [dateReport];
}

class TimeReportChange extends DetailModifyUnsafeActionEvent {
  final BlocFormItem timeReport;

  const TimeReportChange({required this.timeReport});

  @override
  List<Object?> get props => [timeReport];
}

class LocationReportChange extends DetailModifyUnsafeActionEvent {
  final BlocFormItem locationReport;

  const LocationReportChange({required this.locationReport});

  @override
  List<Object?> get props => [locationReport];
}

class ImmediateActionReportChange extends DetailModifyUnsafeActionEvent {
  final BlocFormItem immediateAction;

  const ImmediateActionReportChange({required this.immediateAction});

  @override
  List<Object?> get props => [immediateAction];
}

class SuggestionImprovementReportChange extends DetailModifyUnsafeActionEvent {
  final BlocFormItem suggestionImprovement;

  const SuggestionImprovementReportChange({required this.suggestionImprovement});

  @override
  List<Object?> get props => [suggestionImprovement];
}

class SaveSubmit extends DetailModifyUnsafeActionEvent {
  const SaveSubmit();
}

class ModifyFormReset extends DetailModifyUnsafeActionEvent {
  const ModifyFormReset();
}

class ClearImageModifyEvent extends DetailModifyUnsafeActionEvent {
  const ClearImageModifyEvent();
}

class ImgModifyChange extends DetailModifyUnsafeActionEvent {
  final File image;

  const ImgModifyChange({required this.image});

  @override
  List<Object?> get props => [image];
}

class InitUnsafeActions extends DetailModifyUnsafeActionEvent {
  final UnsafeAction action;

  const InitUnsafeActions({required this.action});

  @override
  List<Object?> get props => [action];
}

class ActionInsegurosModifyListChange extends DetailModifyUnsafeActionEvent {
  final Map<String, bool> unsafeActions;

  const ActionInsegurosModifyListChange({required this.unsafeActions});

  @override
  List<Object?> get props => [unsafeActions];
}