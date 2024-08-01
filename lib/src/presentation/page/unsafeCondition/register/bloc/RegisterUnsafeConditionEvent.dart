import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:sipil_app/src/presentation/utils/BlocFormItem.dart';

abstract class RegisterUnsafeConditionEvent extends Equatable {
  const RegisterUnsafeConditionEvent();
  @override
  List<Object?> get props => [];
}

class RegisterUnsafeConditionInitEvent extends RegisterUnsafeConditionEvent {
  const RegisterUnsafeConditionInitEvent();
}

class DateConditionReportChange extends RegisterUnsafeConditionEvent {
  final BlocFormItem dateReport;
  const DateConditionReportChange({required this.dateReport});
  @override
  List<Object?> get props => [dateReport];
}

class TimeConditionReportChange extends RegisterUnsafeConditionEvent {
  final BlocFormItem timeReport;
  const TimeConditionReportChange({required this.timeReport});
  @override
  List<Object?> get props => [timeReport];
}

class LocationConditionReportChange extends RegisterUnsafeConditionEvent {
  final BlocFormItem locationReport;
  const LocationConditionReportChange({required this.locationReport});
  @override
  List<Object?> get props => [locationReport];
}

class ImmediateActionConditionReportChange extends RegisterUnsafeConditionEvent {
  final BlocFormItem immediateAction;
  const ImmediateActionConditionReportChange({required this.immediateAction});
  @override
  List<Object?> get props => [immediateAction];
}

class SuggestionImprovementConditionReportChange extends RegisterUnsafeConditionEvent {
  final BlocFormItem suggestionImprovement;
  const SuggestionImprovementConditionReportChange({required this.suggestionImprovement});
  @override
  List<Object?> get props => [suggestionImprovement];
}

class ConditionUnsafeListChange extends RegisterUnsafeConditionEvent {
  final Map<String, bool> conditionUnsafe;
  const ConditionUnsafeListChange({required this.conditionUnsafe});
  @override
  List<Object?> get props => [conditionUnsafe];
}

class ActionUnsafeListChange extends RegisterUnsafeConditionEvent {
  final Map<String, bool> actionUnsafe;
  const ActionUnsafeListChange({required this.actionUnsafe});
  @override
  List<Object?> get props => [actionUnsafe];
}

class ImgConditionChange extends RegisterUnsafeConditionEvent {
  final File image;
  const ImgConditionChange({required this.image});
  @override
  List<Object?> get props => [image];
}

class SaveConditionSubmit extends RegisterUnsafeConditionEvent {
  final Map<String, bool> unsafeConditions;
  const SaveConditionSubmit({required this.unsafeConditions});
  @override
  List<Object?> get props => [unsafeConditions];
}

class RegisterConditionFormReset extends RegisterUnsafeConditionEvent {
  const RegisterConditionFormReset();
}

class ClearImageConditionEvent extends RegisterUnsafeConditionEvent {
  const ClearImageConditionEvent();
}

class SaveUnsafeConditions extends RegisterUnsafeConditionEvent {
  final Map<String, bool> unsafeConditions;
  const SaveUnsafeConditions({required this.unsafeConditions});
  @override
  List<Object?> get props => [unsafeConditions];
}