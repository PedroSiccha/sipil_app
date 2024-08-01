import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sipil_app/src/domain/models/UnsafeAction.dart';
import 'package:sipil_app/src/domain/utils/Resource.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/detailShow/DetailShowUnsafeActionContent.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/detailShow/bloc/DetailShowUnsafeActionBloc.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/detailShow/bloc/DetailShowUnsafeActionEvent.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/detailShow/bloc/DetailShowUnsafeActionState.dart';
import 'package:sipil_app/src/utils/colors.dart';
import 'package:sipil_app/src/utils/routesName.dart';

class DetailShowUnsafeActionPage extends StatefulWidget {
  const DetailShowUnsafeActionPage({super.key});

  @override
  State<DetailShowUnsafeActionPage> createState() => _DetailShowUnsafeActionPageState();
}

class _DetailShowUnsafeActionPageState extends State<DetailShowUnsafeActionPage> {
  UnsafeAction? unsafeAction;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is UnsafeAction) {
      setState(() {
        unsafeAction = args;
      });
      var bloc = BlocProvider.of<DetailShowUnsafeActionBloc>(context);
      bloc.add(InitShowUnsafeActions(action: unsafeAction!));
    } else {
      print('Argumentos no válidos recibidos: $args');
    }
  }

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<DetailShowUnsafeActionBloc>(context);
    print('unsafeAction en build: $unsafeAction');
    return Scaffold(
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.only(left: 32.0, right: 32.0, top: 64),
        child: BlocListener<DetailShowUnsafeActionBloc, DetailShowUnsafeActionState>(
          listener: (context, state) {
            final responseState = state.response;
            if (responseState is Error) {
              Fluttertoast.showToast(
                  msg: responseState.message,
                  toastLength: Toast.LENGTH_LONG
              );
            } else if (responseState is Success) {
              Fluttertoast.showToast(
                  msg: 'Registro Exitoso',
                  toastLength: Toast.LENGTH_LONG
              );
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pop(context);
              });
            }
          },
          child: BlocBuilder<DetailShowUnsafeActionBloc, DetailShowUnsafeActionState>(
            builder: (context, state) {
              if (unsafeAction == null || state == null) {
                return Center(child: CircularProgressIndicator());
              }
              final responseState = state.response;
              if (responseState is Loading) {
                return Stack(
                  children: [
                    DetailShowUnsafeActionContent(bloc, state, unsafeAction!),
                    Center(
                      child: CircularProgressIndicator(
                        color: AppColors.ColorPrincipal,
                      ),
                    )
                  ],
                );
              }
              return Stack(
                children: [
                  DetailShowUnsafeActionContent(bloc, state, unsafeAction!),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}



