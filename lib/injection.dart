import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:sipil_app/injection.config.dart';

final locator = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async => await locator.init();