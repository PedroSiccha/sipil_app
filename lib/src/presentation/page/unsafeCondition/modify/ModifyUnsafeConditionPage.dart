import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sipil_app/src/domain/utils/Resource.dart';
import 'package:sipil_app/src/presentation/page/unsafeCondition/modify/ModifyUnsafeConditionContent.dart';
import 'package:sipil_app/src/presentation/page/unsafeCondition/modify/bloc/ModifyUnsafeConditionBloc.dart';
import 'package:sipil_app/src/presentation/page/unsafeCondition/modify/bloc/ModifyUnsafeConditionEvent.dart';
import 'package:sipil_app/src/presentation/page/unsafeCondition/modify/bloc/ModifyUnsafeConditionState.dart';
import 'package:sipil_app/src/utils/colors.dart';

class ModifyUnsafeConditionPage extends StatefulWidget {
  const ModifyUnsafeConditionPage({Key? key}) : super(key: key);

  @override
  State<ModifyUnsafeConditionPage> createState() => _ModifyUnsafeConditionPageState();
}

class _ModifyUnsafeConditionPageState extends State<ModifyUnsafeConditionPage> {
  late final ModifyUnsafeConditionBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<ModifyUnsafeConditionBloc>(context);
    _bloc.add(ModifyUnsafeConditionInitEvent());
  }

  @override
  void dispose() {
    _bloc.add(ModifyUnsafeConditionResetEvent());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.only(left: 32.0, right: 32.0, top: 64),
        child: BlocListener<ModifyUnsafeConditionBloc, ModifyUnsafeConditionState>(
          listener: (context, state) {
            final responseState = state.response;
            if (responseState is Error) {
              Fluttertoast.showToast(
                msg: responseState.message,
                toastLength: Toast.LENGTH_LONG,
              );
            } else if (responseState is Success) {
              _bloc.add(ModifyUnsafeConditionFormReset());
            }
          },
          child: BlocBuilder<ModifyUnsafeConditionBloc, ModifyUnsafeConditionState>(
            builder: (context, state) {
              final responseState = state.response;
              if (responseState is Loading) {
                return Stack(
                  children: [
                    ModifyUnsafeConditionContent(bloc: _bloc, state: state),
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
                  ModifyUnsafeConditionContent(bloc: _bloc, state: state),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}