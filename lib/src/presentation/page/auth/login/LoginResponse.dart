import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sipil_app/src/domain/utils/Resource.dart';
import 'package:sipil_app/src/presentation/page/auth/login/bloc/LoginBloc.dart';
import 'package:sipil_app/src/presentation/page/auth/login/bloc/LoginState.dart';
import 'package:sipil_app/src/utils/colors.dart';
import 'package:sipil_app/src/utils/routesName.dart';

class LoginResponse extends StatelessWidget {
  LoginBloc? bloc;
  LoginState state;

  LoginResponse(this.bloc, this.state);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          final responseState = state.response;
          if (responseState is Loading) {
            return Center(child: CircularProgressIndicator(color: AppColors.ColorPrincipal,),);
          } else if (responseState is Error) {
            Fluttertoast.showToast(
                msg: responseState.message,
                toastLength: Toast.LENGTH_LONG
            );
          } else if (responseState is Success) {
            Fluttertoast.showToast(
                msg: 'Bievenido',
                toastLength: Toast.LENGTH_LONG
            );
          }
          return Container();
        }
    );
  }
}