import 'package:sipil_app/src/domain/models/response/AuthResponse.dart';
import 'package:sipil_app/src/domain/repository/AuthRepository.dart';

class SaveUserSessionUseCase {
  AuthRepository authRepository;
  SaveUserSessionUseCase(this.authRepository);
  run(AuthResponse saveUserSession) => authRepository.saveUserSession(saveUserSession);
}