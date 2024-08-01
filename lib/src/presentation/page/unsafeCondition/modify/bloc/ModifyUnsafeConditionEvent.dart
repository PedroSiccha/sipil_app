import 'package:equatable/equatable.dart';
import 'package:sipil_app/src/presentation/utils/BlocFormItem.dart';

abstract class ModifyUnsafeConditionEvent extends Equatable {
  const ModifyUnsafeConditionEvent();
  @override
  List<Object?> get props => [];
}

class ModifyUnsafeConditionInitEvent extends ModifyUnsafeConditionEvent {
  const ModifyUnsafeConditionInitEvent();
}

class InitDateConditionChange extends ModifyUnsafeConditionEvent {
  final BlocFormItem initDate;
  const InitDateConditionChange({
    required this.initDate
  });
  @override
  List<Object?> get props => [initDate];
}

class EndDateConditionChange extends ModifyUnsafeConditionEvent {
  final BlocFormItem endDate;
  const EndDateConditionChange({
    required this.endDate
  });
  @override
  List<Object?> get props => [endDate];
}

class SearchConditionSubmit extends ModifyUnsafeConditionEvent {
  const SearchConditionSubmit();
}

class ModifyUnsafeConditionFormReset extends ModifyUnsafeConditionEvent {
  const ModifyUnsafeConditionFormReset();
}

class ModifyUnsafeConditionResetEvent extends ModifyUnsafeConditionEvent {
  const ModifyUnsafeConditionResetEvent();
}