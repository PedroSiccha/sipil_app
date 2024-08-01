import 'dart:io';

import 'package:sipil_app/src/data/dataSource/remote/service/UnsafeActionService.dart';
import 'package:sipil_app/src/domain/models/SearchUnsafeAction.dart';
import 'package:sipil_app/src/domain/models/UnsafeAction.dart';
import 'package:sipil_app/src/domain/models/response/UnsafeActionResponse.dart';
import 'package:sipil_app/src/domain/models/response/UnsafeUniqueActionResponse.dart';
import 'package:sipil_app/src/domain/repository/UnsafeActionRepository.dart';
import 'package:sipil_app/src/domain/utils/Resource.dart';

class UnsafeActionRepositoryImpl implements UnsafeActionRepository {
  UnsafeActionService unsafeActService;
  UnsafeActionRepositoryImpl(this.unsafeActService);
  @override
  Future<Resource<UnsafeUniqueActionResponse>> create(UnsafeAction unsafeAction, File? image) {

    if (image == null) {
      return unsafeActService.register(unsafeAction);
    } else {
      return unsafeActService.registerImage(unsafeAction, image);
    }

  }

  @override
  Future<Resource<UnsafeUniqueActionResponse>> update(int id, UnsafeAction unsafeAction, File? image) {
    if (image == null) {
      return unsafeActService.updateUnsafeAct(id, unsafeAction);
    } else {
      return unsafeActService.updateUnsafeActWithImage(id, unsafeAction, image);
    }
  }

  @override
  Future<Resource<UnsafeActionResponse>> search(SearchUnsafeAction searchUnsafeAction) {
    return unsafeActService.search(searchUnsafeAction);
  }
  
}