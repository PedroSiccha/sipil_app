import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sipil_app/src/domain/utils/Resource.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/register/RegisterUnsafeActionContent.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/register/bloc/RegisterUnsafeActionBloc.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/register/bloc/RegisterUnsafeActionEvent.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/register/bloc/RegisterUnsafeActionState.dart';
import 'package:sipil_app/src/utils/colors.dart';

class RegisterUnsafeActionPage extends StatefulWidget {
  const RegisterUnsafeActionPage({super.key});

  @override
  State<RegisterUnsafeActionPage> createState() => _RegisterUnsafeActionPageState();
}

class _RegisterUnsafeActionPageState extends State<RegisterUnsafeActionPage> {
  late final RegisterUnsafeActionBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<RegisterUnsafeActionBloc>(context);
    _bloc.add(RegisterUnsafeActionInitEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.only(left: 32.0, right: 32.0, top: 64),
        child: BlocListener<RegisterUnsafeActionBloc, RegisterUnsafeActionState>(
          listener: (context, state) {
            final responseState = state.response;
            if (responseState is Error) {
              Fluttertoast.showToast(
                  msg: "Error: ${responseState.message}",
                  toastLength: Toast.LENGTH_LONG
              );
            } else if (responseState is Success) {
              _bloc.add(RegisterFormReset());
              Fluttertoast.showToast(
                  msg: 'Registro Exitoso',
                  toastLength: Toast.LENGTH_LONG
              );
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pop(context);
              });
            }
          },
          child: BlocBuilder<RegisterUnsafeActionBloc, RegisterUnsafeActionState>(
            builder: (context, state) {
              print("BlocBuilder rebuild triggered, state.img: ${state.img}");
              return Stack(
                children: [
                  RegisterUnsafeActionContent(_bloc, state),
                  if (state.response is Loading)
                    Center(
                      child: CircularProgressIndicator(
                        color: AppColors.ColorPrincipal,
                      ),
                    )
                ],
              );
            },
          ),
        )
      ),
    );
  }
}