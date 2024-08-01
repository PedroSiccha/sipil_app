import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sipil_app/src/domain/utils/Resource.dart';
import 'package:sipil_app/src/presentation/page/unsafeCondition/show/ShowUnsafeConditionContent.dart';
import 'package:sipil_app/src/presentation/page/unsafeCondition/show/bloc/ShowUnsafeConditionBloc.dart';
import 'package:sipil_app/src/presentation/page/unsafeCondition/show/bloc/ShowUnsafeConditionEvent.dart';
import 'package:sipil_app/src/presentation/page/unsafeCondition/show/bloc/ShowUnsafeConditionState.dart';
import 'package:sipil_app/src/utils/colors.dart';

class ShowUnsafeConditionPage extends StatefulWidget {
  const ShowUnsafeConditionPage({Key? key}) : super(key: key);

  @override
  State<ShowUnsafeConditionPage> createState() => _ShowUnsafeConditionPageState();
}

class _ShowUnsafeConditionPageState extends State<ShowUnsafeConditionPage> {
  late final ShowUnsafeConditionBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<ShowUnsafeConditionBloc>(context);
    _bloc.add(ShowUnsafeConditionInitEvent());
  }

  @override
  void dispose() {
    _bloc.add(ShowUnsafeConditionResetEvent());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.only(left: 32.0, right: 32.0, top: 64),
        child: BlocListener<ShowUnsafeConditionBloc, ShowUnsafeConditionState>(
          listener: (context, state) {
            final responseState = state.response;
            if (responseState is Error) {
              Fluttertoast.showToast(
                msg: responseState.message,
                toastLength: Toast.LENGTH_LONG,
              );
            } else if (responseState is Success) {
              _bloc.add(ShowUnsafeConditionFormReset());
            }
          },
          child: BlocBuilder<ShowUnsafeConditionBloc, ShowUnsafeConditionState>(
            builder: (context, state) {
              final responseState = state.response;
              if (responseState is Loading) {
                return Stack(
                  children: [
                    ShowUnsafeConditionContent(bloc: _bloc, state: state),
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
                  ShowUnsafeConditionContent(bloc: _bloc, state: state),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}