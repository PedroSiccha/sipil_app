import 'dart:io';

import 'package:sipil_app/src/domain/models/UnsafeAction.dart';
import 'package:sipil_app/src/domain/repository/UnsafeActionRepository.dart';

class UpdateUnsafeActionUseCase {
  UnsafeActionRepository unsafeActionRepository;
  UpdateUnsafeActionUseCase(this.unsafeActionRepository);
  run(int id, UnsafeAction unsafeAction, File? file) => unsafeActionRepository.update(id, unsafeAction, file);
}