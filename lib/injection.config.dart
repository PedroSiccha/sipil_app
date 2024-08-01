// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:sipil_app/src/data/dataSource/local/SharedPref.dart' as _i4;
import 'package:sipil_app/src/data/dataSource/remote/service/AuthService.dart'
    as _i3;
import 'package:sipil_app/src/data/dataSource/remote/service/UnsafeActionService.dart'
    as _i7;
import 'package:sipil_app/src/di/AppModule.dart' as _i10;
import 'package:sipil_app/src/domain/repository/AuthRepository.dart' as _i5;
import 'package:sipil_app/src/domain/repository/UnsafeActionRepository.dart'
    as _i8;
import 'package:sipil_app/src/domain/useCases/auth/AuthUseCase.dart' as _i6;
import 'package:sipil_app/src/domain/useCases/unsafeAction/UnsafeActionUseCase.dart'
    as _i9;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    gh.factory<_i3.AuthService>(() => appModule.authService);
    gh.factory<_i4.SharedPref>(() => appModule.sharedPref);
    gh.factory<_i5.AuthRepository>(() => appModule.authRepository);
    gh.factory<_i6.AuthUseCase>(() => appModule.authUseCase);
    gh.factory<_i7.UnsafeActionService>(() => appModule.unsafeActionService);
    gh.factory<_i8.UnsafeActionRepository>(
        () => appModule.unsafeActionRepository);
    gh.factory<_i9.UnsafeActionUseCase>(() => appModule.unsafeActionUseCase);
    return this;
  }
}

class _$AppModule extends _i10.AppModule {}
