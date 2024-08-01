import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sipil_app/src/domain/utils/Resource.dart';
import 'package:sipil_app/src/presentation/page/unsafeCondition/register/RegisterUnsafeConditionContent.dart';
import 'package:sipil_app/src/presentation/page/unsafeCondition/register/bloc/RegisterUnsafeConditionBloc.dart';
import 'package:sipil_app/src/presentation/page/unsafeCondition/register/bloc/RegisterUnsafeConditionEvent.dart';
import 'package:sipil_app/src/presentation/page/unsafeCondition/register/bloc/RegisterUnsafeConditionState.dart';
import 'package:sipil_app/src/utils/colors.dart';

class RegisterUnsafeConditionPage extends StatefulWidget {
  const RegisterUnsafeConditionPage({Key? key}) : super(key: key);

  @override
  State<RegisterUnsafeConditionPage> createState() => _RegisterUnsafeConditionPageState();
}

class _RegisterUnsafeConditionPageState extends State<RegisterUnsafeConditionPage> {
  late final RegisterUnsafeConditionBloc _bloc;

  @override
  void initState() {
    super.initState();
    // Obtén el Bloc del contexto
    _bloc = BlocProvider.of<RegisterUnsafeConditionBloc>(context);
    // Desencadena el evento de inicialización del Bloc
    _bloc.add(RegisterUnsafeConditionInitEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(left: 32.0, right: 32.0, top: 64),
        child: BlocListener<RegisterUnsafeConditionBloc, RegisterUnsafeConditionState>(
          listener: (context, state) {
            final responseState = state.response;
            if (responseState is Error) {
              Fluttertoast.showToast(
                  msg: "Error CONDITION: ${responseState.message}",
                  toastLength: Toast.LENGTH_LONG);
            } else if (responseState is Success) {
              Fluttertoast.showToast(msg: 'Registro Exitoso', toastLength: Toast.LENGTH_LONG);
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                _bloc.add(RegisterConditionFormReset()); // Reset the state after successful save
                Navigator.pop(context);
              });
            }
          },
          child: BlocBuilder<RegisterUnsafeConditionBloc, RegisterUnsafeConditionState>(
            builder: (context, state) {
              final responseState = state.response;
              if (responseState is Loading) {
                return Stack(
                  children: [
                    RegisterUnsafeConditionContent(bloc: _bloc, state: state),
                    Center(
                      child: CircularProgressIndicator(
                        color: AppColors.ColorPrincipal,
                      ),
                    ),
                  ],
                );
              }
              return RegisterUnsafeConditionContent(bloc: _bloc, state: state);
            },
          ),
        ),
      ),
    );
  }
}