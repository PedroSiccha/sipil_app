import 'package:injectable/injectable.dart';
import 'package:sipil_app/src/data/dataSource/remote/repository/AuthRepositoryImpl.dart';
import 'package:sipil_app/src/domain/repository/AuthRepository.dart';

class LoginAuthUseCase {
  AuthRepository authRepository;
  LoginAuthUseCase(this.authRepository);
  run(String username, String password) => authRepository.login(username, password);
}