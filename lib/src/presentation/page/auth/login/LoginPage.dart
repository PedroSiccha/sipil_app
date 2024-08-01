import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sipil_app/src/domain/models/response/AuthResponse.dart';
import 'package:sipil_app/src/domain/utils/Resource.dart';
import 'package:sipil_app/src/presentation/page/auth/login/LoginContent.dart';
import 'package:sipil_app/src/presentation/page/auth/login/LoginResponse.dart';
import 'package:sipil_app/src/presentation/page/auth/login/bloc/LoginBloc.dart';
import 'package:sipil_app/src/presentation/page/auth/login/bloc/LoginEvent.dart';
import 'package:sipil_app/src/presentation/page/auth/login/bloc/LoginState.dart';
import 'package:sipil_app/src/presentation/page/home/dashboard/DashboardPage.dart';
import 'package:sipil_app/src/utils/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc? _bloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<LoginBloc>(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Stack(
          children: [
            Image.asset(
              'assets/img/fondo.png',
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
              color: Colors.black54,
              colorBlendMode: BlendMode.darken,
            ),
            Container(
                margin: EdgeInsets.only(left: 32.0, right: 32.0, top: 200),
                child: BlocListener<LoginBloc, LoginState>(
                  listener: (context, state) {
                    final responseState = state.response;
                    if (responseState is Error) {
                      Fluttertoast.showToast(
                          msg: responseState.message,
                          toastLength: Toast.LENGTH_LONG);
                    } else if (responseState is Success) {
                      final authResponse = responseState.data as AuthResponse;
                      _bloc?.add(LoginSaveUserSession(authResponse: authResponse));
                      Fluttertoast.showToast(
                          msg: 'Bienvenido', toastLength: Toast.LENGTH_LONG);
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DashboardPage()),
                        );

                      });
                    }
                  },
                  child: BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return LoginContent(_bloc, state);
                    },
                  ),
                ) //LoginContent(_bloc)
                )
          ],
        ),
      ),
    );
  }
}
