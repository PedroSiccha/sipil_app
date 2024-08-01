import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sipil_app/src/domain/models/response/AuthResponse.dart';
import 'package:sipil_app/src/domain/models/response/UnsafeActionResponse.dart';
import 'package:sipil_app/src/domain/useCases/auth/AuthUseCase.dart';
import 'package:sipil_app/src/domain/useCases/unsafeAction/UnsafeActionUseCase.dart';
import 'package:sipil_app/src/domain/utils/Resource.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/modify/bloc/ModifyUnsafeActionEvent.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/modify/bloc/ModifyUnsafeActionState.dart';
import 'package:sipil_app/src/presentation/utils/BlocFormItem.dart';

class ModifyUnsafeActionBloc extends Bloc<ModifyUnsafeActionEvent, ModifyUnsafeActionState> {
  UnsafeActionUseCase unsafeActionUseCase;
  AuthUseCase authUseCase;
  ModifyUnsafeActionBloc(
      this.unsafeActionUseCase,
      this.authUseCase
  ): super(ModifyUnsafeActionState()) {
    on<ModifyUnsafeActionInitEvent>(_onInitEvent);
    on<InitDateChange>(_onInitDateChange);
    on<EndDateChange>(_onEndDateChange);
    on<SearchSubmit>(_onSearchSubmit);
    on<ModifyUnsafeActionFormReset>(_onModifyUnsafeActionFormReset);
    on<ModifyUnsafeActionResetEvent>(_onResetEvent);
  }
  final formKey = GlobalKey<FormState>();

  Future<void> _onInitEvent(ModifyUnsafeActionInitEvent event, Emitter<ModifyUnsafeActionState> emit) async {
    AuthResponse? authResponse = await authUseCase.getUserSessionUseCase.run();
    emit(
        state.copyWith(
          formKey: formKey,
          nameCompany: BlocFormItem(
              value: authResponse!.user!.company!.name!
          ),
          nameUser: BlocFormItem(
              value: authResponse.user!.name!
          ),
          lastnameUser: BlocFormItem(
              value: authResponse.user!.lastname!
          ),
          dniUser: BlocFormItem(
              value: authResponse.user!.dni!
          ),
          areaProject: BlocFormItem(
              value: authResponse.user!.project!
          ),
          responsableProject: BlocFormItem(
              value: authResponse.user!.projectManager!
          ),
          initDate: BlocFormItem(value: '', error: 'Ingrese una fecha de inicio'),
          endDate: BlocFormItem(value: '', error: 'Ingrese una fecha fin'),
          unsafeActions: [],
        )
    );
  }

  Future<void> _onResetEvent(ModifyUnsafeActionResetEvent event, Emitter<ModifyUnsafeActionState> emit) async {
    emit(ModifyUnsafeActionState());
  }

  Future<void> _onInitDateChange(InitDateChange event, Emitter<ModifyUnsafeActionState> emit) async {
    emit(
      state.copyWith(
        initDate: BlocFormItem(
          value: event.initDate.value,
          error: event.initDate.value.isNotEmpty ? null : 'Ingrese una fecha de inicio',
        ),
        formKey: formKey
      )
    );
  }

  Future<void> _onEndDateChange(EndDateChange event, Emitter<ModifyUnsafeActionState> emit) async {
    emit(
      state.copyWith(
        endDate: BlocFormItem(
          value: event.endDate.value,
          error: event.endDate.value.isNotEmpty ? null : 'Ingrese una fecha fin',
        ),
        formKey: formKey
      )
    );
  }

  // Future<void> _onSearchSubmit(SearchSubmit event, Emitter<ModifyUnsafeActionState> emit) async {
  //   try {
  //     emit(state.copyWith(response: Loading(), formKey: formKey));
  //     Resource resource = await unsafeActionUseCase.search.run(state.toUnsafeAction());
  //     if (resource is Success) {
  //       if (resource.data is UnsafeActionResponse) {
  //         emit(state.copyWith(
  //           response: resource,
  //             //formKey: formKey,
  //           unsafeActions: (resource.data as UnsafeActionResponse).unsafeAction,
  //         ));
  //       }
  //     } else {
  //       emit(state.copyWith(response: resource, formKey: formKey));
  //     }
  //   } catch(e) {
  //     print('Error Modify $e');
  //   }
  // }

  Future<void> _onSearchSubmit(SearchSubmit event, Emitter<ModifyUnsafeActionState> emit) async {
    if (state.initDate.value.isEmpty) {
      emit(state.copyWith(
        initDate: BlocFormItem(
          value: state.initDate.value,
          error: 'Ingrese una fecha de inicio',
        ),
      ));
    }
    if (state.endDate.value.isEmpty) {
      emit(state.copyWith(
        endDate: BlocFormItem(
          value: state.endDate.value,
          error: 'Ingrese una fecha fin',
        ),
      ));
    }

    if (state.initDate.error == null && state.endDate.error == null) {
      try {
        emit(state.copyWith(response: Loading(), formKey: formKey));
        Resource resource = await unsafeActionUseCase.search.run(state.toUnsafeAction());
        if (resource is Success) {
          if (resource.data is UnsafeActionResponse) {
            emit(state.copyWith(
              response: resource,
              unsafeActions: (resource.data as UnsafeActionResponse).unsafeAction,
            ));
          }
        } else {
          emit(state.copyWith(response: resource, formKey: formKey));
        }
      } catch (e) {
        print('Error Modify $e');
      }
    }
  }


  Future<void> _onModifyUnsafeActionFormReset(ModifyUnsafeActionFormReset event, Emitter<ModifyUnsafeActionState> emit) async {
    state.formKey?.currentState?.reset();
  }

}