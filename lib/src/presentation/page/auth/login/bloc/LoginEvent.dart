import 'package:equatable/equatable.dart';
import 'package:sipil_app/src/domain/models/response/AuthResponse.dart';
import 'package:sipil_app/src/presentation/utils/BlocFormItem.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class InitEvent extends LoginEvent {
  const InitEvent();
}

class LoginSaveUserSession extends LoginEvent {
  final AuthResponse authResponse;
  const LoginSaveUserSession({required this.authResponse});
  @override
  List<Object?> get props => [authResponse];
}

class UserNameChanged extends LoginEvent {
  final BlocFormItem username;
  const UserNameChanged({
    required this.username
  });
  @override
  List<Object?> get props => [username];
}

class PasswordChanged extends LoginEvent {
  final BlocFormItem password;
  const PasswordChanged({
    required this.password
  });
  @override
  List<Object?> get props => [password];
}

class LoginSubmit extends LoginEvent {
  const LoginSubmit();
}