import 'package:sipil_app/src/domain/models/response/AuthResponse.dart';
import 'package:sipil_app/src/domain/repository/AuthRepository.dart';

class GetUserSessionUseCase {
  AuthRepository authRepository;
  GetUserSessionUseCase(this.authRepository);
  run() => authRepository.getUserSession();
}