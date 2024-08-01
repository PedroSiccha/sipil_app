import 'package:sipil_app/src/domain/models/response/AuthResponse.dart';
import 'package:sipil_app/src/domain/utils/Resource.dart';

abstract class AuthRepository {
  Future<AuthResponse?> getUserSession();
  Future<void> saveUserSession(AuthResponse authResponse);
  Future<Resource<AuthResponse>> login(String username, String password);
}