import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sipil_app/src/domain/models/response/AuthResponse.dart';
import 'package:sipil_app/src/domain/useCases/auth/AuthUseCase.dart';
import 'package:sipil_app/src/domain/useCases/unsafeAction/UnsafeActionUseCase.dart';
import 'package:sipil_app/src/domain/utils/Resource.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/register/bloc/RegisterUnsafeActionEvent.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/register/bloc/RegisterUnsafeActionState.dart';
import 'package:sipil_app/src/presentation/utils/BlocFormItem.dart';

class RegisterUnsafeActionBloc extends Bloc<RegisterUnsafeActionEvent, RegisterUnsafeActionState> {
  final UnsafeActionUseCase unsafeActionUseCase;
  final AuthUseCase authUseCase;
  RegisterUnsafeActionBloc(
      this.unsafeActionUseCase, this.authUseCase
  ): super(RegisterUnsafeActionState()) {
    on<RegisterUnsafeActionInitEvent>(_onInitEvent);
    on<DateReportChange>(_onDateReportChange);
    on<TimeReportChange>(_onTimeReportChange);
    on<LocationReportChange>(_onLocationReportChange);
    on<ImmediateActionReportChange>(_onImmediateActionReportChange);
    on<SuggestionImprovementReportChange>(_onSuggestionImprovementReportChange);
    on<ActionInsegurosListChange>(_onActionInsegurosListChange);
    on<SaveSubmit>(_onSaveSubmit);
    on<RegisterFormReset>(_onRegisterFormReset);
    on<ClearImageEvent>(_onClearImage);
    on<ImgChange>(_onImageChange);
    on<SaveUnsafeActions>(_onSaveUnsafeActions);
  }

  final formKey = GlobalKey<FormState>();

  Future<void> _onInitEvent(RegisterUnsafeActionInitEvent event, Emitter<RegisterUnsafeActionState> emit) async {
    AuthResponse? authResponse = await authUseCase.getUserSessionUseCase.run();
    print('AUTH ACTION ${authResponse}');
    emit(
      state.copyWith(
        formKey: formKey,
        nameCompany: BlocFormItem(value: authResponse?.user?.company?.name ?? ''),
        nameUser: BlocFormItem(value: authResponse?.user?.name ?? ''),
        lastnameUser: BlocFormItem(value: authResponse?.user?.lastname ?? ''),
        dniUser: BlocFormItem(value: authResponse?.user?.dni ?? ''),
        areaProject: BlocFormItem(value: authResponse?.user?.project ?? ''),
        responsableProject: BlocFormItem(value: authResponse?.user?.projectManager ?? ''),
        img: null,
        dateReport: BlocFormItem(value: ''),
        timeReport: BlocFormItem(value: ''),
      ),
    );
  }

  Future<void> _onClearImage(ClearImageEvent event, Emitter<RegisterUnsafeActionState> emit) async {
    print("Clear image event triggered");
    emit(state.copyWith(img: null));
    print("Image cleared, state updated: ${state.img}");
  }

  Future<void> _onDateReportChange(DateReportChange event, Emitter<RegisterUnsafeActionState> emit) async {
    print("DateReportChange event triggered");
    emit(
        state.copyWith(
            dateReport: BlocFormItem(
                value: event.dateReport.value,
                error: event.dateReport.value.isNotEmpty ? null: 'Ingrese una fecha'
            ),
        )
    );
    print("Date report updated: ${state.dateReport.value}, img: ${state.img}");
  }

  Future<void> _onTimeReportChange(TimeReportChange event, Emitter<RegisterUnsafeActionState> emit) async {
    print("TimeReportChange event triggered");
    emit(
        state.copyWith(
            timeReport: BlocFormItem(
                value: event.timeReport.value,
                error: event.timeReport.value.isNotEmpty? null: 'Ingrese una hora'
            ),
        )
    );
    print("Time report updated: ${state.timeReport.value}, img: ${state.img}");
  }

  Future<void> _onLocationReportChange(LocationReportChange event, Emitter<RegisterUnsafeActionState> emit) async {
    print("LocationReportChange event triggered");
    emit(
        state.copyWith(
            locationReport: BlocFormItem(
                value: event.locationReport.value,
                error: event.locationReport.value.isNotEmpty? null: 'Ingrese un lugar de hallazgo'
            )
        )
    );
    print("Location report updated: ${state.locationReport.value}, img: ${state.img}");
  }

  Future<void> _onImmediateActionReportChange(ImmediateActionReportChange event, Emitter<RegisterUnsafeActionState> emit) async {
    print("ImmediateActionReportChange event triggered");
    emit(
        state.copyWith(
            immediateAction: BlocFormItem(
                value: event.immediateAction.value,
                error: event.immediateAction.value.isNotEmpty? null: ''
            ),
        )
    );
    print("Immediate action updated: ${state.immediateAction.value}, img: ${state.img}");
  }

  Future<void> _onSuggestionImprovementReportChange(SuggestionImprovementReportChange event, Emitter<RegisterUnsafeActionState> emit) async {
    print("SuggestionImprovementReportChange event triggered");
    emit(
        state.copyWith(
            suggestionImprovement: BlocFormItem(
                value: event.suggestionImprovement.value,
                error: event.suggestionImprovement.value.isNotEmpty? null: ''
            ),
        )
    );
    print("Suggestion improvement updated: ${state.suggestionImprovement.value}, img: ${state.img}");
  }

  Future<void> _onActionInsegurosListChange(ActionInsegurosListChange event, Emitter<RegisterUnsafeActionState> emit) async {
    emit(
        state.copyWith(
            unsafeActions: event.actionInseguro,
        )
    );
  }

  Future<void> _onImageChange(ImgChange event, Emitter<RegisterUnsafeActionState> emit) async {
    emit(
      state.copyWith(
        img: File(event.image.path),
      ),
    );
  }

  Future<void> _onSaveSubmit(SaveSubmit event, Emitter<RegisterUnsafeActionState> emit) async {
    try {
      emit(
          state.copyWith(
              response: Loading(),
              unsafeActions: event.unsafeActions
          )
      );
      Resource response = await unsafeActionUseCase.create.run(state.toUnsafeAction(), state.img);
      emit(
          state.copyWith(
              response: response,
          )
      );
    } catch(e) {
      print("Error Bloc ${e}");
    }
  }

  Future<void> _onRegisterFormReset(RegisterFormReset event, Emitter<RegisterUnsafeActionState> emit) async {
    emit(state.copyWith(
      dateReport: BlocFormItem(value: ''),
      timeReport: BlocFormItem(value: ''),
      locationReport: BlocFormItem(value: ''),
      img: null,
      immediateAction: BlocFormItem(value: ''),
      suggestionImprovement: BlocFormItem(value: ''),
      response: Initial(),
      formKey: GlobalKey<FormState>(),
    ));
    state.formKey?.currentState?.reset();
  }

  Future<void> _onSaveUnsafeActions(SaveUnsafeActions event, Emitter<RegisterUnsafeActionState> emit) async {
    emit(state.copyWith(
      unsafeActions: event.unsafeActions
    ));
  }

  void onTakePhoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      emit(
          state.copyWith(
            img: File(image.path)
          )
      );
    }
  }

  void onTakeImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      emit(
          state.copyWith(
              img: File(image.path),
          )
      );
    }
  }
}