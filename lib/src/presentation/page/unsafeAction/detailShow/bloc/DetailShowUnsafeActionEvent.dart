import 'package:equatable/equatable.dart';
import 'package:sipil_app/src/domain/models/UnsafeAction.dart';
import 'package:sipil_app/src/presentation/utils/BlocFormItem.dart';

abstract class DetailShowUnsafeActionEvent extends Equatable {
  const DetailShowUnsafeActionEvent();
  @override
  List<Object?> get props => [];
}

class DetailShowUnsafeActionInitEvent extends DetailShowUnsafeActionEvent {
  const DetailShowUnsafeActionInitEvent();
}

class DateReportChange extends DetailShowUnsafeActionEvent {
  final BlocFormItem dateReport;
  const DateReportChange({
    required this.dateReport
  });
  @override
  List<Object?> get props => [dateReport];
}

class TimeReportChange extends DetailShowUnsafeActionEvent {
  final BlocFormItem timeReport;
  const TimeReportChange({
    required this.timeReport
  });
  @override
  List<Object?> get props => [timeReport];
}

class LocationReportChange extends DetailShowUnsafeActionEvent {
  final BlocFormItem locationReport;
  const LocationReportChange({
    required this.locationReport
  });
  @override
  List<Object?> get props => [locationReport];
}

class ImmediateActionReportChange extends DetailShowUnsafeActionEvent {
  final BlocFormItem immediateAction;
  const ImmediateActionReportChange({
    required this.immediateAction
  });
  @override
  List<Object?> get props => [immediateAction];
}

class SuggestionImprovementReportChange extends DetailShowUnsafeActionEvent {
  final BlocFormItem suggestionImprovement;
  const SuggestionImprovementReportChange({
    required this.suggestionImprovement
  });
  @override
  List<Object?> get props => [suggestionImprovement];
}

class SaveSubmit extends DetailShowUnsafeActionEvent {
  const SaveSubmit();
}

class InitShowUnsafeActions extends DetailShowUnsafeActionEvent {
  final UnsafeAction action;
  const InitShowUnsafeActions({required this.action});

  @override
  List<Object?> get props => [action];
}

class ActionInsegurosShowListChange extends DetailShowUnsafeActionEvent {
  final Map<String, bool> unsafeActions;
  const ActionInsegurosShowListChange({
    required this.unsafeActions,
  });
  @override
  List<Object?> get props => [unsafeActions];
}