import 'package:equatable/equatable.dart';
import 'package:sipil_app/src/presentation/utils/BlocFormItem.dart';

abstract class ShowUnsafeConditionEvent extends Equatable {
  const ShowUnsafeConditionEvent();
  @override
  List<Object?> get props => [];
}

class ShowUnsafeConditionInitEvent extends ShowUnsafeConditionEvent {
  const ShowUnsafeConditionInitEvent();
}

class ShowInitDateConditionChange extends ShowUnsafeConditionEvent {
  final BlocFormItem showInitDate;
  const ShowInitDateConditionChange({
    required this.showInitDate
  });
  @override
  List<Object?> get props => [showInitDate];
}

class ShowEndDateConditionChange extends ShowUnsafeConditionEvent {
  final BlocFormItem showEndDate;
  const ShowEndDateConditionChange({
    required this.showEndDate
  });
  @override
  List<Object?> get props => [showEndDate];
}

class ShowSearchConditionSubmit extends ShowUnsafeConditionEvent {
  const ShowSearchConditionSubmit();
}

class ShowUnsafeConditionFormReset extends ShowUnsafeConditionEvent {
  const ShowUnsafeConditionFormReset();
}

class ShowUnsafeConditionResetEvent extends ShowUnsafeConditionEvent {
  const ShowUnsafeConditionResetEvent();
}