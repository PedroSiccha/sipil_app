import 'package:injectable/injectable.dart';
import 'package:sipil_app/src/data/dataSource/local/SharedPref.dart';
import 'package:sipil_app/src/data/dataSource/remote/repository/AuthRepositoryImpl.dart';
import 'package:sipil_app/src/data/dataSource/remote/repository/UnsafeActionRepositoryImpl.dart';
import 'package:sipil_app/src/data/dataSource/remote/service/AuthService.dart';
import 'package:sipil_app/src/data/dataSource/remote/service/UnsafeActionService.dart';
import 'package:sipil_app/src/domain/repository/AuthRepository.dart';
import 'package:sipil_app/src/domain/repository/UnsafeActionRepository.dart';
import 'package:sipil_app/src/domain/useCases/auth/AuthUseCase.dart';
import 'package:sipil_app/src/domain/useCases/auth/GetUserSessionUseCase.dart';
import 'package:sipil_app/src/domain/useCases/auth/LoginAuthUseCase.dart';
import 'package:sipil_app/src/domain/useCases/auth/SaveUserSessionUseCase.dart';
import 'package:sipil_app/src/domain/useCases/unsafeAction/CreateUnsafeActionUseCase.dart';
import 'package:sipil_app/src/domain/useCases/unsafeAction/SearchUnsafeActUseCase.dart';
import 'package:sipil_app/src/domain/useCases/unsafeAction/UnsafeActionUseCase.dart';
import 'package:sipil_app/src/domain/useCases/unsafeAction/UpdateUnsafeActionUseCase.dart';

@module
abstract class AppModule {

  @injectable
  AuthService get authService => AuthService();

  @injectable
  SharedPref get sharedPref => SharedPref();

  @injectable
  AuthRepository get authRepository => AuthRepositoryImpl(authService, sharedPref);

  @injectable
  AuthUseCase get authUseCase => AuthUseCase(
      login: LoginAuthUseCase(authRepository),
      saveUserSessionUseCase: SaveUserSessionUseCase(authRepository),
      getUserSessionUseCase: GetUserSessionUseCase(authRepository)
  );

  @injectable
  UnsafeActionService get unsafeActionService => UnsafeActionService();

  @injectable
  UnsafeActionRepository get unsafeActionRepository => UnsafeActionRepositoryImpl(unsafeActionService);

  @injectable
  UnsafeActionUseCase get unsafeActionUseCase => UnsafeActionUseCase(
      create: CreateUnsafeActionUseCase(unsafeActionRepository),
      update: UpdateUnsafeActionUseCase(unsafeActionRepository),
      search: SearchUnsafeActionUseCase(unsafeActionRepository)
  );

}