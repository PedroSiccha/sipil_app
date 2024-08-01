import 'package:equatable/equatable.dart';
import 'package:sipil_app/src/presentation/utils/BlocFormItem.dart';

abstract class ModifyUnsafeActionEvent extends Equatable {
  const ModifyUnsafeActionEvent();
  @override
  List<Object?> get props => throw UnimplementedError();
}

class ModifyUnsafeActionInitEvent extends  ModifyUnsafeActionEvent {
  const ModifyUnsafeActionInitEvent();
}

class InitDateChange extends ModifyUnsafeActionEvent {
  final BlocFormItem initDate;
  const InitDateChange({
    required this.initDate
  });
  @override
  List<Object?> get props => [initDate];
}

class EndDateChange extends ModifyUnsafeActionEvent {
  final BlocFormItem endDate;
  const EndDateChange({
    required this.endDate
  });
  @override
  List<Object?> get props => [endDate];
}

class SearchSubmit extends ModifyUnsafeActionEvent {
  const SearchSubmit();
}

class ModifyUnsafeActionFormReset extends ModifyUnsafeActionEvent {
  const ModifyUnsafeActionFormReset();
}

class ModifyUnsafeActionResetEvent extends ModifyUnsafeActionEvent {
  const ModifyUnsafeActionResetEvent();
}