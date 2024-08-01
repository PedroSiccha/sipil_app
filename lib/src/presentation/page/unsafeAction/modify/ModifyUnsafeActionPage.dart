import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sipil_app/src/domain/models/response/UnsafeActionResponse.dart';
import 'package:sipil_app/src/domain/utils/Resource.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/modify/ModifyUnsafeActionContent.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/modify/bloc/ModifyUnsafeActionBloc.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/modify/bloc/ModifyUnsafeActionEvent.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/modify/bloc/ModifyUnsafeActionState.dart';
import 'package:sipil_app/src/utils/colors.dart';

class ModifyUnsafeActionPage extends StatefulWidget {
  const ModifyUnsafeActionPage({super.key});

  @override
  State<ModifyUnsafeActionPage> createState() => _ModifyUnsafeActionPageState();
}

class _ModifyUnsafeActionPageState extends State<ModifyUnsafeActionPage> {
  late ModifyUnsafeActionBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<ModifyUnsafeActionBloc>(context);
    _bloc.add(ModifyUnsafeActionInitEvent());
  }

  @override
  void dispose() {
    _bloc.add(ModifyUnsafeActionResetEvent());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.only(left: 32.0, right: 32.0, top: 64),
        child: BlocListener<ModifyUnsafeActionBloc, ModifyUnsafeActionState>(
          listener: (context, state) {
            final responseState = state.response;
            if (responseState is Error) {
              Fluttertoast.showToast(
                  msg: responseState.message,
                  toastLength: Toast.LENGTH_LONG
              );
            } else if (responseState is Success) {
              _bloc.add(ModifyUnsafeActionFormReset());
              print('RESPONSE PAGE ${(responseState.data as UnsafeActionResponse).unsafeAction?.length}');
            }
          },
          child: BlocBuilder<ModifyUnsafeActionBloc, ModifyUnsafeActionState>(
            builder: (context, state) {
              final responseState = state.response;
              if (responseState is Loading) {
                return Stack(
                  children: [
                    ModifyUnsafeActionContent(_bloc, state),
                    Center(
                      child: CircularProgressIndicator(
                        color: AppColors.ColorPrincipal,
                      ),
                    ),
                  ],
                );
              }
              return Stack(
                children: [
                  ModifyUnsafeActionContent(_bloc, state)
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}