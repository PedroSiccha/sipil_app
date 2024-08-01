import 'package:injectable/injectable.dart';
import 'package:sipil_app/src/domain/useCases/auth/GetUserSessionUseCase.dart';
import 'package:sipil_app/src/domain/useCases/auth/LoginAuthUseCase.dart';
import 'package:sipil_app/src/domain/useCases/auth/SaveUserSessionUseCase.dart';

class AuthUseCase {
  LoginAuthUseCase login;
  GetUserSessionUseCase getUserSessionUseCase;
  SaveUserSessionUseCase saveUserSessionUseCase;
  AuthUseCase({
    required this.login,
    required this.getUserSessionUseCase,
    required this.saveUserSessionUseCase
  });
}