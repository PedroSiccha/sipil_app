import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sipil_app/src/domain/models/response/AuthResponse.dart';
import 'package:sipil_app/src/domain/useCases/auth/AuthUseCase.dart';
import 'package:sipil_app/src/domain/useCases/unsafeAction/UnsafeActionUseCase.dart';
import 'package:sipil_app/src/domain/utils/Resource.dart';
import 'package:sipil_app/src/presentation/page/unsafeCondition/register/bloc/RegisterUnsafeConditionEvent.dart';
import 'package:sipil_app/src/presentation/page/unsafeCondition/register/bloc/RegisterUnsafeConditionState.dart';
import 'package:sipil_app/src/presentation/utils/BlocFormItem.dart';

class RegisterUnsafeConditionBloc extends Bloc<RegisterUnsafeConditionEvent, RegisterUnsafeConditionState> {
  final UnsafeActionUseCase unsafeActionUseCase;
  final AuthUseCase authUseCase;

  RegisterUnsafeConditionBloc(this.unsafeActionUseCase, this.authUseCase) : super(RegisterUnsafeConditionState()) {
    on<RegisterUnsafeConditionInitEvent>(_onInitConditionEvent);
    on<DateConditionReportChange>(_onDateReportConditionChange);
    on<TimeConditionReportChange>(_onTimeConditionReportChange);
    on<LocationConditionReportChange>(_onLocationConditionReportChange);
    on<ImmediateActionConditionReportChange>(_onImmediateActionConditionReportChange);
    on<SuggestionImprovementConditionReportChange>(_onSuggestionImprovementConditionReportChange);
    on<ConditionUnsafeListChange>(_onConditionUnsafeListChange);
    on<ActionUnsafeListChange>(_onActionUnsafeListChange);
    on<SaveConditionSubmit>(_onSaveConditionSubmit);
    on<RegisterConditionFormReset>(_onRegisterConditionFormReset);
    on<ClearImageConditionEvent>(_onClearImageCondition);
    on<ImgConditionChange>(_onImageConditionChange);
    on<SaveUnsafeConditions>(_onSaveUnsafeConditions);
  }

  final formKey = GlobalKey<FormState>();

  /// Initializes the form with user data from the auth use case
  Future<void> _onInitConditionEvent(RegisterUnsafeConditionInitEvent event, Emitter<RegisterUnsafeConditionState> emit) async {
    try {
      AuthResponse? authResponse = await authUseCase.getUserSessionUseCase.run();
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
    } catch (e) {
      // Handle error (optional)
    }
  }

  /// Clears the image field in the state
  Future<void> _onClearImageCondition(ClearImageConditionEvent event, Emitter<RegisterUnsafeConditionState> emit) async {
    print('Init Clear IMG');
    if (state.img != null && await state.img!.exists()) {
      await state.img!.delete();
    }
    emit(state.copyWith(img: File('')));
    print('END Clear IMG ${state.img}');
  }

  /// Handles date report change event
  Future<void> _onDateReportConditionChange(DateConditionReportChange event, Emitter<RegisterUnsafeConditionState> emit) async {
    emit(
      state.copyWith(
        dateReport: BlocFormItem(
          value: event.dateReport.value,
          error: event.dateReport.value.isNotEmpty ? null : 'Ingrese una fecha',
        ),
      ),
    );
  }

  /// Handles time report change event
  Future<void> _onTimeConditionReportChange(TimeConditionReportChange event, Emitter<RegisterUnsafeConditionState> emit) async {
    emit(
      state.copyWith(
        timeReport: BlocFormItem(
          value: event.timeReport.value,
          error: event.timeReport.value.isNotEmpty ? null : 'Ingrese una hora',
        ),
      ),
    );
  }

  /// Handles location report change event
  Future<void> _onLocationConditionReportChange(LocationConditionReportChange event, Emitter<RegisterUnsafeConditionState> emit) async {
    emit(
      state.copyWith(
        locationReport: BlocFormItem(
          value: event.locationReport.value,
          error: event.locationReport.value.isNotEmpty ? null : 'Ingrese un lugar de hallazgo',
        ),
      ),
    );
  }

  /// Handles immediate action change event
  Future<void> _onImmediateActionConditionReportChange(ImmediateActionConditionReportChange event, Emitter<RegisterUnsafeConditionState> emit) async {
    emit(
      state.copyWith(
        immediateAction: BlocFormItem(
          value: event.immediateAction.value,
          error: event.immediateAction.value.isNotEmpty ? null : '',
        ),
      ),
    );
  }

  /// Handles suggestion improvement change event
  Future<void> _onSuggestionImprovementConditionReportChange(SuggestionImprovementConditionReportChange event, Emitter<RegisterUnsafeConditionState> emit) async {
    emit(
      state.copyWith(
        suggestionImprovement: BlocFormItem(
          value: event.suggestionImprovement.value,
          error: event.suggestionImprovement.value.isNotEmpty ? null : '',
        ),
      ),
    );
  }

  /// Handles unsafe condition list change event
  Future<void> _onConditionUnsafeListChange(ConditionUnsafeListChange event, Emitter<RegisterUnsafeConditionState> emit) async {
    emit(state.copyWith(unsafeConditions: event.conditionUnsafe));
  }

  /// Handles unsafe action list change event
  Future<void> _onActionUnsafeListChange(ActionUnsafeListChange event, Emitter<RegisterUnsafeConditionState> emit) async {
    emit(state.copyWith(unsafeActions: event.actionUnsafe));
  }

  /// Handles image change event
  Future<void> _onImageConditionChange(ImgConditionChange event, Emitter<RegisterUnsafeConditionState> emit) async {
    emit(state.copyWith(img: File(event.image.path)));
  }

  /// Handles save condition submit event
  Future<void> _onSaveConditionSubmit(SaveConditionSubmit event, Emitter<RegisterUnsafeConditionState> emit) async {
    try {
      emit(state.copyWith(response: Loading()));
      Resource response = await unsafeActionUseCase.create.run(state.toUnsafeAction(), state.img);
      emit(state.copyWith(response: response));
    } catch (e) {
      // Log the error and emit a failure state if needed
      // emit(state.copyWith(response: Failure(error: e.toString())));
    }
  }

  /// Resets the form to its initial state
  Future<void> _onRegisterConditionFormReset(RegisterConditionFormReset event, Emitter<RegisterUnsafeConditionState> emit) async {
    emit(
      state.copyWith(
        dateReport: BlocFormItem(value: ''),
        timeReport: BlocFormItem(value: ''),
        locationReport: BlocFormItem(value: ''),
        img: null,
        immediateAction: BlocFormItem(value: ''),
        suggestionImprovement: BlocFormItem(value: ''),
        response: Initial(),
        formKey: GlobalKey<FormState>(),
      ),
    );
    state.formKey?.currentState?.reset();
  }

  /// Handles save unsafe conditions event
  Future<void> _onSaveUnsafeConditions(SaveUnsafeConditions event, Emitter<RegisterUnsafeConditionState> emit) async {
    emit(state.copyWith(unsafeConditions: event.unsafeConditions));
  }

  /// Takes a photo using the camera and updates the state with the image
  void onTakePhoto() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      emit(state.copyWith(img: File(image.path)));
    }
  }

  /// Selects an image from the gallery and updates the state with the image
  void onTakeImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      emit(state.copyWith(img: File(image.path)));
    }
  }
}
