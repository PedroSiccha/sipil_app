import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:sipil_app/src/domain/models/response/AuthResponse.dart';
import 'package:sipil_app/src/domain/utils/Resource.dart';
import 'package:sipil_app/src/presentation/utils/BlocFormItem.dart';

class LoginState extends Equatable {
  final BlocFormItem username;
  final BlocFormItem password;
  final Resource? response;
  final GlobalKey<FormState>? formKey;

  const LoginState({
    this.username = const BlocFormItem(error: 'Usuario no valido'),
    this.password = const BlocFormItem(error: 'Contraseña no valida'),
    this.formKey,
    this.response
  });

  LoginState copyWith({
    BlocFormItem? username,
    BlocFormItem? password,
    Resource? response,
    GlobalKey<FormState>? formKey
  }) {
      return LoginState(
        username: username ?? this.username,
        password: password ?? this.password,
        formKey: formKey,
        response: response
      );
  }

  @override
  List<Object?> get props => [username, password, response];

}