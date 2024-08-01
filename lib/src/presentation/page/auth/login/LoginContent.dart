import 'package:flutter/material.dart';
import 'package:sipil_app/src/presentation/page/auth/login/bloc/LoginBloc.dart';
import 'package:sipil_app/src/presentation/page/auth/login/bloc/LoginEvent.dart';
import 'package:sipil_app/src/presentation/page/auth/login/bloc/LoginState.dart';
import 'package:sipil_app/src/presentation/utils/BlocFormItem.dart';
import 'package:sipil_app/src/presentation/widget/DefaultButtom.dart';
import 'package:sipil_app/src/presentation/widget/LabelTextField.dart';

class LoginContent extends StatelessWidget {
  LoginBloc? bloc;
  LoginState state;

  LoginContent(this.bloc, this.state);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Form(
      key: state.formKey,
      child: Column(
        children: [
          Image.asset(
            'assets/img/logoblanco.png',
          ),
          LabelTextField(
            label: 'Usuario',
            hint: 'Usuario',
            validator: (value) {
              return state.username.error;
            },
            obscureText: false,
            icon: Icons.account_circle_outlined,
            onChanged: (text) {
              bloc?.add(UserNameChanged(username: BlocFormItem(value: text)));
            },
          ),
          LabelTextField(
              label: 'Ingrese su contraseña',
              hint: 'Ingrese su contraseña',
              validator: (value) {
                return state.password.error;
              },
              onChanged: (text) {
                bloc?.add(PasswordChanged(password: BlocFormItem(value: text)));
              },
              obscureText: true),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Olvidó su contraseña',
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                )
              ],
            ),
          ),
          DefaultButtom(
            text: 'Acceso',
            onPressed: () {
              if (state.formKey!.currentState!.validate()) {
                bloc?.add(LoginSubmit());
              }
            },
            isEnable: true,
            // isEnable: snapshot.hasData ? true: false,
          )
        ],
      ),
    ));
  }
}
