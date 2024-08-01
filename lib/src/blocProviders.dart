import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:sipil_app/injection.dart';
import 'package:sipil_app/src/domain/useCases/auth/AuthUseCase.dart';
import 'package:sipil_app/src/domain/useCases/unsafeAction/UnsafeActionUseCase.dart';
import 'package:sipil_app/src/presentation/page/auth/login/bloc/LoginEvent.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/detailModify/bloc/DetailModifyUnsafeActionBloc.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/detailModify/bloc/DetailModifyUnsafeActionEvent.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/detailShow/bloc/DetailShowUnsafeActionBloc.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/detailShow/bloc/DetailShowUnsafeActionEvent.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/modify/bloc/ModifyUnsafeActionBloc.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/modify/bloc/ModifyUnsafeActionEvent.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/register/bloc/RegisterUnsafeActionBloc.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/show/bloc/ShowUnsafeActionBloc.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/show/bloc/ShowUnsafeActionEvent.dart';
import 'package:sipil_app/src/presentation/page/unsafeCondition/modify/bloc/ModifyUnsafeConditionBloc.dart';
import 'package:sipil_app/src/presentation/page/unsafeCondition/register/bloc/RegisterUnsafeConditionBloc.dart';

import 'presentation/page/auth/login/bloc/LoginBloc.dart';
import 'presentation/page/unsafeAction/register/bloc/RegisterUnsafeActionEvent.dart';
import 'presentation/page/unsafeCondition/show/bloc/ShowUnsafeConditionBloc.dart';

List<BlocProvider> blocProviders = [
  BlocProvider<LoginBloc>(create: (context) => LoginBloc(locator<AuthUseCase>())),
  BlocProvider<RegisterUnsafeActionBloc>(create: (context) => RegisterUnsafeActionBloc(locator<UnsafeActionUseCase>(), locator<AuthUseCase>())),
  BlocProvider<ModifyUnsafeActionBloc>(create: (context) => ModifyUnsafeActionBloc(locator<UnsafeActionUseCase>(), locator<AuthUseCase>())),
  BlocProvider<ModifyUnsafeConditionBloc>(create: (context) => ModifyUnsafeConditionBloc(locator<UnsafeActionUseCase>(), locator<AuthUseCase>())),
  BlocProvider<ShowUnsafeActionBloc>(create: (context) => ShowUnsafeActionBloc(locator<UnsafeActionUseCase>(), locator<AuthUseCase>())),
  BlocProvider<ShowUnsafeConditionBloc>(create: (context) => ShowUnsafeConditionBloc(locator<UnsafeActionUseCase>(), locator<AuthUseCase>())),
  BlocProvider<DetailModifyUnsafeActionBloc>(create: (context) => DetailModifyUnsafeActionBloc(locator<UnsafeActionUseCase>(), locator<AuthUseCase>())),
  BlocProvider<DetailShowUnsafeActionBloc>(create: (context) => DetailShowUnsafeActionBloc(locator<UnsafeActionUseCase>(), locator<AuthUseCase>())),
  BlocProvider<RegisterUnsafeConditionBloc>(create: (context) => RegisterUnsafeConditionBloc(locator<UnsafeActionUseCase>(), locator<AuthUseCase>())),
];