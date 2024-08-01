import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sipil_app/src/domain/models/response/AuthResponse.dart';
import 'package:sipil_app/src/domain/models/response/UnsafeActionResponse.dart';
import 'package:sipil_app/src/domain/useCases/auth/AuthUseCase.dart';
import 'package:sipil_app/src/domain/useCases/unsafeAction/UnsafeActionUseCase.dart';
import 'package:sipil_app/src/domain/utils/Resource.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/show/bloc/ShowUnsafeActionEvent.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/show/bloc/ShowUnsafeActionState.dart';
import 'package:sipil_app/src/presentation/utils/BlocFormItem.dart';

class ShowUnsafeActionBloc extends Bloc<ShowUnsafeActionEvent, ShowUnsafeActionState> {
  UnsafeActionUseCase unsafeActionUseCase;
  AuthUseCase authUseCase;
  ShowUnsafeActionBloc(
      this.unsafeActionUseCase,
      this.authUseCase
  ): super(ShowUnsafeActionState()) {
    on<ShowUnsafeActionInitEvent>(_onInitEvent);
    on<ShowInitDateChange>(_onInitDateChange);
    on<ShowEndDateChange>(_onEndDateChange);
    on<ShowSearchSubmit>(_onSearchSubmit);
    on<ShowUnsafeActionFormReset>(_onShowUnsafeActionFormReset);
    on<ShowUnsafeActionResetEvent>(_onResetEvent);
  }
  final formKey = GlobalKey<FormState>();

  Future<void> _onInitEvent(ShowUnsafeActionInitEvent event, Emitter<ShowUnsafeActionState> emit) async {
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
          showInitDate: BlocFormItem(value: '', error: 'Ingrese una fecha de inicio'), // Limpia las fechas
          showEndDate: BlocFormItem(value: '', error: 'Ingrese una fecha fin'),  // Limpia las fechas
          unsafeActions: [], // Limpia los resultados
        )
    );
  }

  Future<void> _onResetEvent(ShowUnsafeActionResetEvent event, Emitter<ShowUnsafeActionState> emit) async {
    emit(ShowUnsafeActionState());
  }

  Future<void> _onInitDateChange(ShowInitDateChange event, Emitter<ShowUnsafeActionState> emit) async {
    emit(
        state.copyWith(
            showInitDate: BlocFormItem(
                value: event.showInitDate.value,
                error: event.showInitDate.value.isNotEmpty? null: 'Ingrese una fecha de inicio'
            ),
            formKey: formKey
        )
    );
  }

  Future<void> _onEndDateChange(ShowEndDateChange event, Emitter<ShowUnsafeActionState> emit) async {
    emit(
        state.copyWith(
            showEndDate: BlocFormItem(
                value: event.showEndDate.value,
                error: event.showEndDate.value.isNotEmpty? null: 'Ingrese una fecha fin'
            ),
            formKey: formKey
        )
    );
  }

  // Future<void> _onSearchSubmit(ShowSearchSubmit event, Emitter<ShowUnsafeActionState> emit) async {
  //   try {
  //     emit(
  //         state.copyWith(
  //             response: Loading(),
  //             formKey: formKey
  //         )
  //     );
  //     Resource resource = await unsafeActionUseCase.search.run(state.toUnsafeAction());
  //     if (resource is Success) {
  //       if (resource.data is UnsafeActionResponse) {
  //         emit(state.copyWith(
  //           response: resource,
  //           unsafeActions: (resource.data as UnsafeActionResponse).unsafeAction,
  //           //formKey: formKey,
  //         ));
  //       }
  //     } else {
  //       emit(state.copyWith(response: resource, formKey: formKey));
  //     }
  //   } catch(e) {
  //     print('Error Modify $e');
  //   }
  // }

  Future<void> _onSearchSubmit(ShowSearchSubmit event, Emitter<ShowUnsafeActionState> emit) async{
    if(state.showInitDate.value.isEmpty) {
      emit(state.copyWith(
        showInitDate: BlocFormItem(
          value: state.showInitDate.value,
          error: 'Ingrese una fecha de inicio',
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
                response: Loading(),
                formKey: formKey
            )
        );
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
      } catch(e) {
        print('Error Show $e');
      }
    }
  }

  Future<void> _onShowUnsafeActionFormReset(ShowUnsafeActionFormReset event, Emitter<ShowUnsafeActionState> emit) async {
    state.formKey?.currentState?.reset();
  }

}