import 'package:sipil_app/src/domain/models/SearchUnsafeAction.dart';
import 'package:sipil_app/src/domain/repository/UnsafeActionRepository.dart';

class SearchUnsafeActionUseCase {
  UnsafeActionRepository unsafeActionRepository;
  SearchUnsafeActionUseCase(this.unsafeActionRepository);
  run(SearchUnsafeAction searchUnsafeAction) => unsafeActionRepository.search(searchUnsafeAction);
}