import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:sipil_app/src/domain/models/UnsafeAction.dart';
import 'package:sipil_app/src/domain/utils/Resource.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/detailModify/DetailModifyUnsafeActionContent.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/detailModify/bloc/DetailModifyUnsafeActionBloc.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/detailModify/bloc/DetailModifyUnsafeActionEvent.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/detailModify/bloc/DetailModifyUnsafeActionState.dart';
import 'package:sipil_app/src/utils/colors.dart';

class DetailModifyUnsafeActionPage extends StatefulWidget {
  const DetailModifyUnsafeActionPage({super.key});

  @override
  State<DetailModifyUnsafeActionPage> createState() => _DetailModifyUnsafeActionPageState();
}

class _DetailModifyUnsafeActionPageState extends State<DetailModifyUnsafeActionPage> {
  UnsafeAction? unsafeAction;
  late final DetailModifyUnsafeActionBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<DetailModifyUnsafeActionBloc>(context);
    _bloc.add(DetailModifyUnsafeActionInitEvent());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is UnsafeAction && unsafeAction == null) {
      unsafeAction = args;
      _bloc.add(InitUnsafeActions(action: unsafeAction!));
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.only(left: 32.0, right: 32.0, top: 64),
        child: BlocListener<DetailModifyUnsafeActionBloc, DetailModifyUnsafeActionState>(
          listener: (context, state) {
            Fluttertoast.showToast(msg: 'Actualizacion Exitosa', toastLength: Toast.LENGTH_LONG);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pop(context);
            });
            // final errorMessage = (state.response as Error).message;
            // Fluttertoast.showToast(msg: errorMessage, toastLength: Toast.LENGTH_LONG);
            // if (state.response is Error) {
            //   final errorMessage = (state.response as Error).message;
            //   Fluttertoast.showToast(msg: errorMessage, toastLength: Toast.LENGTH_LONG);
            // } else if (state.response is Success) {
            //   Fluttertoast.showToast(msg: 'Registro Exitoso', toastLength: Toast.LENGTH_LONG);
            //   WidgetsBinding.instance.addPostFrameCallback((_) {
            //     Navigator.pop(context);
            //   });
            // }
          },
          child: BlocBuilder<DetailModifyUnsafeActionBloc, DetailModifyUnsafeActionState>(
            builder: (context, state) {
              if (state.response is Loading) {
                return Stack(
                  children: [
                    if (unsafeAction != null) DetailModifyUnsafeActionContent(_bloc, state, unsafeAction!),
                    const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.ColorPrincipal,
                      ),
                    ),
                  ],
                );
              }
              return unsafeAction != null ? DetailModifyUnsafeActionContent(_bloc, state, unsafeAction!) : const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
