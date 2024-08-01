import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sipil_app/src/domain/utils/Resource.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/show/ShowUnsafeActionContent.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/show/bloc/ShowUnsafeActionBloc.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/show/bloc/ShowUnsafeActionEvent.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/show/bloc/ShowUnsafeActionState.dart';
import 'package:sipil_app/src/utils/colors.dart';

class ShowUnsafeActionPage extends StatefulWidget {
  const ShowUnsafeActionPage({super.key});

  @override
  State<ShowUnsafeActionPage> createState() => _ShowUnsafeActionPageState();
}

class _ShowUnsafeActionPageState extends State<ShowUnsafeActionPage> {
  late ShowUnsafeActionBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<ShowUnsafeActionBloc>(context);
    _bloc.add(ShowUnsafeActionInitEvent());
  }

  @override
  void dispose() {
    _bloc.add(ShowUnsafeActionResetEvent());
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    // _bloc = BlocProvider.of<ShowUnsafeActionBloc>(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.only(left: 32.0, right: 32.0, top: 64),
        child: BlocListener<ShowUnsafeActionBloc, ShowUnsafeActionState>(
          listener: (context, state) {
            final responseState = state.response;
            if (responseState is Error) {
              Fluttertoast.showToast(
                  msg: responseState.message,
                  toastLength: Toast.LENGTH_LONG
              );
            } else if (responseState is Success) {
              _bloc.add(ShowUnsafeActionFormReset());
            }
          },
          child: BlocBuilder<ShowUnsafeActionBloc, ShowUnsafeActionState>(
            builder: (context, state) {
              final responseState = state.response;
              if (responseState is Loading) {
                return Stack(
                  children: [
                    ShowUnsafeActionContent(_bloc, state),
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
                  ShowUnsafeActionContent(_bloc, state)
                ],
              );
            },
          ),
        )
      ),
    );
  }
}
