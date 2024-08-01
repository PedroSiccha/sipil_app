import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sipil_app/src/domain/models/response/AuthResponse.dart';
import 'package:sipil_app/src/domain/models/response/UnsafeActionResponse.dart';
import 'package:sipil_app/src/domain/useCases/auth/AuthUseCase.dart';
import 'package:sipil_app/src/domain/useCases/unsafeAction/UnsafeActionUseCase.dart';
import 'package:sipil_app/src/domain/utils/Resource.dart';
import 'package:sipil_app/src/presentation/page/unsafeCondition/show/bloc/ShowUnsafeConditionEvent.dart';
import 'package:sipil_app/src/presentation/page/unsafeCondition/show/bloc/ShowUnsafeConditionState.dart';
import 'package:sipil_app/src/presentation/utils/BlocFormItem.dart';

class ShowUnsafeConditionBloc extends Bloc<ShowUnsafeConditionEvent, ShowUnsafeConditionState> {
  UnsafeActionUseCase unsafeActionUseCase;
  AuthUseCase authUseCase;
  ShowUnsafeConditionBloc(
      this.unsafeActionUseCase,
      this.authUseCase
      ): super(ShowUnsafeConditionState()) {
    on<ShowUnsafeConditionInitEvent>(_onInitConditionEvent);
    on<ShowInitDateConditionChange>(_onInitDateConditionChange);
    on<ShowEndDateConditionChange>(_onEndDateConditionChange);
    on<ShowSearchConditionSubmit>(_onSearchConditionSubmit);
    on<ShowUnsafeConditionFormReset>(_onShowUnsafeConditionFormReset);
    on<ShowUnsafeConditionResetEvent>(_onResetConditionEvent);
  }
  final formKey = GlobalKey<FormState>();

  Future<void> _onInitConditionEvent(ShowUnsafeConditionInitEvent event, Emitter<ShowUnsafeConditionState> emit) async {
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
            showInitDate: BlocFormItem(value: '', error: 'Ingrese una fecha de inicio'),
            showEndDate: BlocFormItem(value: '', error: 'Ingrese una fecha fin'),
            unsafeActions: []
        )
    );
  }

  Future<void> _onResetConditionEvent(ShowUnsafeConditionResetEvent event, Emitter<ShowUnsafeConditionState> emit) async {
    emit(ShowUnsafeConditionState());
  }

  Future<void> _onInitDateConditionChange(ShowInitDateConditionChange event, Emitter<ShowUnsafeConditionState> emit) async {
    emit(
        state.copyWith(
            showInitDate: BlocFormItem(
                value: event.showInitDate.value,
                error: event.showInitDate.value.isNotEmpty? null: 'Ingrese una fecha de inicio'
            )
        )
    );
  }

  Future<void> _onEndDateConditionChange(ShowEndDateConditionChange event, Emitter<ShowUnsafeConditionState> emit) async {
    emit(
        state.copyWith(
            showEndDate: BlocFormItem(
                value: event.showEndDate.value,
                error: event.showEndDate.value.isNotEmpty? null: 'Ingrese una fecha fin'
            )
        )
    );
  }

  Future<void> _onSearchConditionSubmit(ShowSearchConditionSubmit event, Emitter<ShowUnsafeConditionState> emit) async {
    if (state.showInitDate.value.isEmpty) {
      emit(state.copyWith(
          showInitDate: BlocFormItem(
              value: state.showInitDate.value,
              error: 'Ingrese una fecha de inicio'
          )
      ));
    }
    if (state.showEndDate.value.isEmpty) {
      emit(state.copyWith(
          showEndDate: BlocFormItem(
            value: state.showEndDate.value,
            error: 'Ingrese una fecha fin',
          )
      ));
    }
    if (state.showInitDate.error == null && state.showEndDate.error == null) {
      try {
        emit(
            state.copyWith(
                response: Loading()
            )
        );
        Resource resource = await unsafeActionUseCase.search.run(state.toUnsafeCondition());

        if (resource is Success) {

          if (resource.data is UnsafeActionResponse) {

            emit(state.copyWith(
                response: resource,
                unsafeActions: (resource.data as UnsafeActionResponse).unsafeAction
            ));

          }
        } else {
          emit(state.copyWith(response: resource));
        }
      } catch (e) {
        // emit(state.copyWith(response: Error(message: 'Error al buscar condiciones inseguras')));
      }
    }
  }

  Future<void> _onShowUnsafeConditionFormReset(ShowUnsafeConditionFormReset event, Emitter<ShowUnsafeConditionState> emit) async {
    state.formKey?.currentState?.reset();
  }
}