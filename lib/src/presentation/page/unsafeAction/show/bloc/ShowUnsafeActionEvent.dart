import 'package:equatable/equatable.dart';
import 'package:sipil_app/src/presentation/utils/BlocFormItem.dart';

abstract class ShowUnsafeActionEvent extends Equatable {
  const ShowUnsafeActionEvent();
  @override
  List<Object?> get props => throw UnimplementedError();
}

class ShowUnsafeActionInitEvent extends ShowUnsafeActionEvent {
  const ShowUnsafeActionInitEvent();
}

class ShowInitDateChange extends ShowUnsafeActionEvent {
  final BlocFormItem showInitDate;
  const ShowInitDateChange({
    required this.showInitDate
  });
  @override
  List<Object?> get props => [showInitDate];
}

class ShowEndDateChange extends ShowUnsafeActionEvent {
  final BlocFormItem showEndDate;
  const ShowEndDateChange({
    required this.showEndDate
  });
  @override
  List<Object?> get props => [showEndDate];
}

class ShowSearchSubmit extends ShowUnsafeActionEvent {
  const ShowSearchSubmit();
}

class ShowUnsafeActionFormReset extends ShowUnsafeActionEvent {
  const ShowUnsafeActionFormReset();
}

class ShowUnsafeActionResetEvent extends ShowUnsafeActionEvent {
  const ShowUnsafeActionResetEvent();
}