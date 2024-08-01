import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sipil_app/src/domain/models/response/AuthResponse.dart';
import 'package:sipil_app/src/domain/models/response/UnsafeActionResponse.dart';
import 'package:sipil_app/src/domain/useCases/auth/AuthUseCase.dart';
import 'package:sipil_app/src/domain/useCases/unsafeAction/UnsafeActionUseCase.dart';
import 'package:sipil_app/src/domain/utils/Resource.dart';
import 'package:sipil_app/src/presentation/page/unsafeCondition/modify/bloc/ModifyUnsafeConditionEvent.dart';
import 'package:sipil_app/src/presentation/page/unsafeCondition/modify/bloc/ModifyUnsafeConditionState.dart';
import 'package:sipil_app/src/presentation/utils/BlocFormItem.dart';

class ModifyUnsafeConditionBloc extends Bloc<ModifyUnsafeConditionEvent, ModifyUnsafeConditionState> {
  final UnsafeActionUseCase unsafeActionUseCase;
  final AuthUseCase authUseCase;

  ModifyUnsafeConditionBloc(this.unsafeActionUseCase, this.authUseCase)
      : super(ModifyUnsafeConditionState()) {
    on<ModifyUnsafeConditionInitEvent>(_onInitConditionEvent);
    on<InitDateConditionChange>(_onInitDateConditionChange);
    on<EndDateConditionChange>(_onEndDateConditionChange);
    on<SearchConditionSubmit>(_onSearchConditionSubmit);
    on<ModifyUnsafeConditionFormReset>(_onModifyUnsafeConditionFormReset);
    on<ModifyUnsafeConditionResetEvent>(_onConditionResetEvent);
  }
  final formKey = GlobalKey<FormState>();

  Future<void> _onInitConditionEvent(
      ModifyUnsafeConditionInitEvent event, Emitter<ModifyUnsafeConditionState> emit) async {
    try {
      AuthResponse? authResponse = await authUseCase.getUserSessionUseCase.run();
      emit(state.copyWith(
        formKey: formKey,
        nameCompany: BlocFormItem(value: authResponse?.user?.company?.name ?? ''),
        nameUser: BlocFormItem(value: authResponse?.user?.name ?? ''),
        lastnameUser: BlocFormItem(value: authResponse?.user?.lastname ?? ''),
        dniUser: BlocFormItem(value: authResponse?.user?.dni ?? ''),
        areaProject: BlocFormItem(value: authResponse?.user?.project ?? ''),
        responsableProject: BlocFormItem(value: authResponse?.user?.projectManager ?? ''),
        initDate: BlocFormItem(value: '', error: 'Ingrese una fecha de inicio'),
        endDate: BlocFormItem(value: '', error: 'Ingrese una fecha de fin'),
        unsafeActions: [],
      ));
    } catch (e) {
      // emit(state.copyWith(response: Error(message: 'Error al obtener la sesión de usuario')));
    }
  }

  Future<void> _onConditionResetEvent(
      ModifyUnsafeConditionResetEvent event, Emitter<ModifyUnsafeConditionState> emit) async {
    emit(ModifyUnsafeConditionState());
  }

  Future<void> _onInitDateConditionChange(
      InitDateConditionChange event, Emitter<ModifyUnsafeConditionState> emit) async {
    emit(state.copyWith(
      initDate: BlocFormItem(
        value: event.initDate.value,
        error: event.initDate.value.isNotEmpty ? null : 'Ingrese una fecha de inicio',
      ),
      formKey: formKey
    ));
  }

  Future<void> _onEndDateConditionChange(
      EndDateConditionChange event, Emitter<ModifyUnsafeConditionState> emit) async {
    emit(state.copyWith(
      endDate: BlocFormItem(
        value: event.endDate.value,
        error: event.endDate.value.isNotEmpty ? null : 'Ingrese una fecha fin',
      ),
      formKey: formKey
    ));
  }

  Future<void> _onSearchConditionSubmit(
      SearchConditionSubmit event, Emitter<ModifyUnsafeConditionState> emit) async {
    if (state.initDate.value.isEmpty) {
      emit(state.copyWith(
        initDate: BlocFormItem(value: state.initDate.value, error: 'Ingrese una fecha de inicio'),
      ));
    }
    if (state.endDate.value.isEmpty) {
      emit(state.copyWith(
        endDate: BlocFormItem(value: state.endDate.value, error: 'Ingrese una fecha fin'),
      ));
    }
    if (state.initDate.error == null && state.endDate.error == null) {
      try {
        emit(state.copyWith(response: Loading(), formKey: state.formKey));
        Resource resource = await unsafeActionUseCase.search.run(state.toUnsafeCondition());
        print('Back resource');
        if (resource is Success) {
          print('Resource Success');
          if (resource.data is UnsafeActionResponse) {
            print('Is Data: ${(resource.data as UnsafeActionResponse).unsafeAction}');
            emit(state.copyWith(
              response: resource,
              unsafeActions: (resource.data as UnsafeActionResponse).unsafeAction,
            ));
            print('DATAAA: ${state.unsafeActions}');
          }
        } else {
          emit(state.copyWith(response: resource, formKey: formKey));
        }
      } catch (e) {
        // emit(state.copyWith(response: Error(message: 'Error al buscar condiciones inseguras')));
      }
    }
  }

  Future<void> _onModifyUnsafeConditionFormReset(
      ModifyUnsafeConditionFormReset event, Emitter<ModifyUnsafeConditionState> emit) async {
    state.formKey?.currentState?.reset();
    // emit(state.copyWith(
    //   // initDate: const BlocFormItem(value: '', error: 'Ingrese una fecha de inicio'),
    //   // endDate: const BlocFormItem(value: '', error: 'Ingrese una fecha fin'),
    //   // unsafeActions: [],
    //   // response: null,
    // ));
  }
}