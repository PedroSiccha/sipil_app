import 'package:sipil_app/src/data/dataSource/remote/service/UnsafeConditionService.dart';
import 'package:sipil_app/src/domain/models/UnsafeAction.dart';
import 'package:sipil_app/src/domain/models/UnsafeCon.dart';
import 'package:sipil_app/src/domain/models/response/UnsafeActionResponse.dart';
import 'package:sipil_app/src/domain/repository/UnsafeConditionRepository.dart';
import 'package:sipil_app/src/domain/utils/Resource.dart';

class InsecureActRepositoryImpl implements UnsafeConditionRepository {
  UnsafeConditionService insecureActService = UnsafeConditionService();
  // @override
  // Future<Resource<UnsafeActionResponse>> create(UnsafeAction unsafeAction) {
  //   return insecureActService.register(unsafeAction);
  //
  // }
  //
  // @override
  // Future<Resource> edit(InsecureAct insecureAct) {
  //   // TODO: implement edit
  //   throw UnimplementedError();
  // }
  //
  // @override
  // Future<Resource> search(InsecureAct insecureAct) {
  //   // TODO: implement search
  //   throw UnimplementedError();
  // }

}