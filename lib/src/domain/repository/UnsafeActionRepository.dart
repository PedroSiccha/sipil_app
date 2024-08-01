import 'dart:io';

import 'package:sipil_app/src/domain/models/SearchUnsafeAction.dart';
import 'package:sipil_app/src/domain/models/UnsafeAction.dart';
import 'package:sipil_app/src/domain/models/response/UnsafeActionResponse.dart';
import 'package:sipil_app/src/domain/models/response/UnsafeUniqueActionResponse.dart';
import 'package:sipil_app/src/domain/utils/Resource.dart';

abstract class UnsafeActionRepository {
  Future<Resource<UnsafeUniqueActionResponse>> create(UnsafeAction unsafeAction, File? file);
  Future<Resource<UnsafeUniqueActionResponse>> update(int id, UnsafeAction unsafeAction, File? file);
  Future<Resource<UnsafeActionResponse>> search(SearchUnsafeAction searchUnsafeAction);
}