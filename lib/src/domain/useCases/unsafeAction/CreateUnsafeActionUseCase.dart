import 'dart:io';

import 'package:sipil_app/src/domain/models/UnsafeAction.dart';
import 'package:sipil_app/src/domain/repository/UnsafeActionRepository.dart';

class CreateUnsafeActionUseCase {
  UnsafeActionRepository unsafeActionRepository;
  CreateUnsafeActionUseCase(this.unsafeActionRepository);
  run(UnsafeAction unsafeAction, File? file) => unsafeActionRepository.create(unsafeAction, file);
}