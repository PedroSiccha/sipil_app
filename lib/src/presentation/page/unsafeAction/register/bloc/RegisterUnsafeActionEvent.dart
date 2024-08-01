import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:sipil_app/src/presentation/utils/BlocFormItem.dart';

abstract class RegisterUnsafeActionEvent extends Equatable {
  const RegisterUnsafeActionEvent();
  @override
  List<Object?> get props => [];
}

class RegisterUnsafeActionInitEvent extends RegisterUnsafeActionEvent {
  const RegisterUnsafeActionInitEvent();
}

class DateReportChange extends RegisterUnsafeActionEvent {
  final BlocFormItem dateReport;
  const DateReportChange({
    required this.dateReport
  });
  @override
  List<Object?> get props => [dateReport];
}

class TimeReportChange extends RegisterUnsafeActionEvent {
  final BlocFormItem timeReport;
  const TimeReportChange({
    required this.timeReport
  });
  @override
  List<Object?> get props => [timeReport];
}

class LocationReportChange extends RegisterUnsafeActionEvent {
  final BlocFormItem locationReport;
  const LocationReportChange({
    required this.locationReport
  });
  @override
  List<Object?> get props => [locationReport];
}

class ImmediateActionReportChange extends RegisterUnsafeActionEvent {
  final BlocFormItem immediateAction;
  const ImmediateActionReportChange({
    required this.immediateAction
  });
  @override
  List<Object?> get props => [immediateAction];
}

class SuggestionImprovementReportChange extends RegisterUnsafeActionEvent {
  final BlocFormItem suggestionImprovement;
  const SuggestionImprovementReportChange({
    required this.suggestionImprovement
  });
  @override
  List<Object?> get props => [suggestionImprovement];
}

class ActionInsegurosListChange extends RegisterUnsafeActionEvent {
  final Map<String, bool> actionInseguro;
  const ActionInsegurosListChange({
    required this.actionInseguro
  });
  @override
  List<Object?> get props => [actionInseguro];
}

class ImgChange extends RegisterUnsafeActionEvent {
  final File image;
  ImgChange({
    required this.image
  });
  @override
  List<Object?> get props => [image];
}

// class SaveSubmit extends RegisterUnsafeActionEvent {
//   const SaveSubmit();
// }

class SaveSubmit extends RegisterUnsafeActionEvent {
  final Map<String, bool> unsafeActions;
  const SaveSubmit({required this.unsafeActions});
  @override
  List<Object?> get props => [unsafeActions];
}

class RegisterFormReset extends RegisterUnsafeActionEvent {
  const RegisterFormReset();
}

class ClearImageEvent extends RegisterUnsafeActionEvent {
  ClearImageEvent();
}

class SaveUnsafeActions extends RegisterUnsafeActionEvent {
  final Map<String, bool> unsafeActions;
  const SaveUnsafeActions({
    required this.unsafeActions
  });
  @override
  List<Object?> get props => [unsafeActions];
}
