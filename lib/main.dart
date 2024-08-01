import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sipil_app/injection.dart';
import 'package:sipil_app/src/blocProviders.dart';
import 'package:sipil_app/src/presentation/page/auth/login/LoginPage.dart';
import 'package:sipil_app/src/presentation/page/home/dashboard/DashboardPage.dart';
import 'package:sipil_app/src/presentation/page/movieSecurity/MovieSecurityPage.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/dashboard/DashboardUnsafeActionPage.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/detailModify/DetailModifyUnsafeActionPage.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/detailShow/DetailShowUnsafeActionPage.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/modify/ModifyUnsafeActionPage.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/register/RegisterUnsafeActionPage.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/show/ShowUnsafeActionPage.dart';
import 'package:sipil_app/src/presentation/page/unsafeCondition/dashboard/DashboardUnsafeConditionPage.dart';
import 'package:sipil_app/src/presentation/page/unsafeCondition/modify/ModifyUnsafeConditionPage.dart';
import 'package:sipil_app/src/presentation/page/unsafeCondition/register/RegisterUnsafeConditionPage.dart';
import 'package:sipil_app/src/presentation/page/unsafeCondition/show/ShowUnsafeConditionPage.dart';
import 'package:sipil_app/src/utils/routesName.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: blocProviders,
      child: MaterialApp(
        builder: FToastBuilder(),
        debugShowCheckedModeBanner: false,
        title: 'Sipil App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: RoutesName.LOGIN,
        routes: {
          RoutesName.LOGIN: (BuildContext context) => LoginPage(),
          RoutesName.DASHBOARD: (BuildContext context) => DashboardPage(),
          RoutesName.VIEWMOVIE: (BuildContext context) => MovieSecurityPage(),
          RoutesName.DASHBOARDINSECUREACT: (BuildContext context) => DashboardUnsafeActionPage(),
          RoutesName.MODIFYINSECUREACT: (BuildContext context) => ModifyUnsafeActionPage(),
          RoutesName.REGISTERINSECUREACT: (BuildContext context) => RegisterUnsafeActionPage(),
          RoutesName.SHOWINSECUREACT: (BuildContext context) => ShowUnsafeActionPage(),
          RoutesName.DASHBOARDUNSAFEACT: (BuildContext context) => DashboardUnsafeConditionPage(),
          RoutesName.MODIFYUNSAFEACT: (BuildContext context) => ModifyUnsafeConditionPage(),
          RoutesName.REGISTERUNSAFEACT: (BuildContext context) => RegisterUnsafeConditionPage(),
          RoutesName.SHOWUNSAFEACT: (BuildContext context) => ShowUnsafeConditionPage(),
          RoutesName.DETAILMODIFYUNSAFEACTION: (BuildContext context) => DetailModifyUnsafeActionPage(),
          RoutesName.DETAILSHOWUNSAFEACTION: (BuildContext context) => DetailShowUnsafeActionPage(),

        },
      ),
    );
  }
}