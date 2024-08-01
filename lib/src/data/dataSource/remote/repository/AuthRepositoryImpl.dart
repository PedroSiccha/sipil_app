import 'package:injectable/injectable.dart';
import 'package:sipil_app/src/data/dataSource/local/SharedPref.dart';
import 'package:sipil_app/src/data/dataSource/remote/service/AuthService.dart';
import 'package:sipil_app/src/domain/models/response/AuthResponse.dart';
import 'package:sipil_app/src/domain/repository/AuthRepository.dart';
import 'package:sipil_app/src/domain/utils/Resource.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthService authService;
  SharedPref sharedPref;
  AuthRepositoryImpl(this.authService, this.sharedPref);
  @override
  Future<Resource<AuthResponse>> login(String username, String password) {
    return authService.login(username, password);
  }

  @override
  Future<AuthResponse?> getUserSession() async {
    final data = await sharedPref.read('user');
    if (data != null) {
      AuthResponse authResponse = AuthResponse.fromJson(data);
      return authResponse;
    }

    return null;
  }

  @override
  Future<void> saveUserSession(AuthResponse authResponse) async {
    sharedPref.save('user', authResponse.toJson());
  }

}