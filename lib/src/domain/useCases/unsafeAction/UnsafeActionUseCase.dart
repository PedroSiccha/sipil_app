import 'package:sipil_app/src/domain/useCases/unsafeAction/CreateUnsafeActionUseCase.dart';
import 'package:sipil_app/src/domain/useCases/unsafeAction/SearchUnsafeActUseCase.dart';
import 'package:sipil_app/src/domain/useCases/unsafeAction/UpdateUnsafeActionUseCase.dart';

class UnsafeActionUseCase {
  CreateUnsafeActionUseCase create;
  UpdateUnsafeActionUseCase update;
  SearchUnsafeActionUseCase search;
  UnsafeActionUseCase({
    required this.create,
    required this.update,
    required this.search
  });
}