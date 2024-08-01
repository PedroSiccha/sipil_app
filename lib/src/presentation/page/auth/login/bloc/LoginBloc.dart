import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sipil_app/src/domain/models/response/AuthResponse.dart';
import 'package:sipil_app/src/domain/useCases/auth/AuthUseCase.dart';
import 'package:sipil_app/src/domain/utils/Resource.dart';
import 'package:sipil_app/src/presentation/page/auth/login/bloc/LoginEvent.dart';
import 'package:sipil_app/src/presentation/page/auth/login/bloc/LoginState.dart';
import 'package:sipil_app/src/presentation/utils/BlocFormItem.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  AuthUseCase authUseCase;

  LoginBloc(this.authUseCase): super(LoginState()) {
   on<InitEvent>(_onInitEvent);
   on<UserNameChanged>(_onUsernameChanged);
   on<PasswordChanged>(_onPasswordChanged);
   on<LoginSubmit>(_onLoginSubmit);
   on<LoginSaveUserSession>(_onLoginSaveUserSession);
  }

  final _responseController = BehaviorSubject<Resource>();
  final _userNameController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Stream<Resource> get responseStream => _responseController.stream;
  Stream<String> get userNameStream => _userNameController.stream;
  Stream<String> get passwordStream => _passwordController.stream;

  final formKey = GlobalKey<FormState>();

  Future<void> _onLoginSaveUserSession(LoginSaveUserSession event, Emitter<LoginState> emit) async {
    await authUseCase.saveUserSessionUseCase.run(event.authResponse);

  }

  Future<void> _onInitEvent(InitEvent event, Emitter<LoginState> emit) async {
    AuthResponse? authResponse = await authUseCase.getUserSessionUseCase.run();
    print('Usuario de Sesion: ${authResponse?.toJson()}');
    emit(
      state.copyWith(
        formKey: formKey
      )
    );
  }

  Future<void> _onUsernameChanged(UserNameChanged event, Emitter<LoginState> emit) async {
    emit(
      state.copyWith(
        username: BlocFormItem(
          value: event.username.value,
          error: event.username.value.isNotEmpty? null: 'Usuario no valido'
        ),
        formKey: formKey
      )
    );
  }

  Future<void> _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) async {
    emit(
        state.copyWith(
            password: BlocFormItem(
                value: event.password.value,
                error: event.password.value.isNotEmpty? null: 'Contraseña no valida'
            ),
            formKey: formKey
        )
    );
  }

  Future<void> _onLoginSubmit(LoginSubmit event, Emitter<LoginState> emit) async {
    try {
      emit(
        state.copyWith(
          response: Loading(),
          formKey: formKey
        )
      );
      Resource<AuthResponse> response = await authUseCase.login.run(state.username.value, state.password.value);
      emit(
        state.copyWith(
          response: response,
          formKey: formKey
        )
      );
    } catch(e) {
      print("Error Bloc ${e}");
    }
  }

  void changeUserName(String userName) {
    if (userName.isNotEmpty && userName.length < 4) {
      _userNameController.sink.addError('Usuario no valido');
    } else {
      _userNameController.sink.add(userName);
    }
  }

  void changePassword(String password) {
    if (password.isNotEmpty && password.length < 6) {
      _passwordController.sink.addError('Contraseña incorrecta');
    } else {
      _passwordController.sink.add(password);
    }
  }
  
  Stream<bool> get validateForm => Rx.combineLatest2(userNameStream, passwordStream, (a, b) => true);

  void dispose() {
    changeUserName('');
    changePassword('');
  }
  
  void login() async {
    try {
      _responseController.add(Loading());
      Resource response = await authUseCase.login.run(_userNameController.value, _passwordController.value);
      print('RESPONSE $response');
      _responseController.add(response);
      Future.delayed(Duration(seconds: 1), () {
        _responseController.add(Initial());
      });
    } catch(e) {
      print("Error Bloc ${e}");
    }
  }
}