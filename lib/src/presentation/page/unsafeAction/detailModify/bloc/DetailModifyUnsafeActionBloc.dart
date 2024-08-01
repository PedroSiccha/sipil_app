import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sipil_app/src/domain/models/response/AuthResponse.dart';
import 'package:sipil_app/src/domain/useCases/auth/AuthUseCase.dart';
import 'package:sipil_app/src/domain/useCases/unsafeAction/UnsafeActionUseCase.dart';
import 'package:sipil_app/src/domain/utils/Resource.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/detailModify/bloc/DetailModifyUnsafeActionEvent.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/detailModify/bloc/DetailModifyUnsafeActionState.dart';
import 'package:sipil_app/src/presentation/utils/BlocFormItem.dart';

class DetailModifyUnsafeActionBloc extends Bloc<DetailModifyUnsafeActionEvent, DetailModifyUnsafeActionState> {
  UnsafeActionUseCase unsafeActionUseCase;
  AuthUseCase authUseCase;
  DetailModifyUnsafeActionBloc(this.unsafeActionUseCase, this.authUseCase): super(DetailModifyUnsafeActionState()) {
    on<DetailModifyUnsafeActionInitEvent>(_onInitEvent);
    on<DateReportChange>(_onDateReportChange);
    on<TimeReportChange>(_onTimeReportChange);
    on<LocationReportChange>(_onLocationReportChange);
    on<ImmediateActionReportChange>(_onImmediateActionReportChange);
    on<SuggestionImprovementReportChange>(_onSuggestionImprovementReportChange);
    on<SaveSubmit>(_onSaveSubmit);
    on<ModifyFormReset>(_onModifyFormReset);
    on<ClearImageModifyEvent>(_onClearImageModify);
    on<ImgModifyChange>(_onImageModifyChange);
    on<InitUnsafeActions>(_onInitUnsafeActions);
    on<ActionInsegurosModifyListChange>(_onActionInsegurosModifyListChange);
  }

  final formKey = GlobalKey<FormState>();

  Future<void> _onInitEvent(DetailModifyUnsafeActionInitEvent event, Emitter<DetailModifyUnsafeActionState> emit) async {
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
            dateReport: BlocFormItem(
              value: '',
            ),
            timeReport: BlocFormItem(
                value: ''
            )
        )
    );
  }

  Future<void> _onInitUnsafeActions(InitUnsafeActions event, Emitter<DetailModifyUnsafeActionState> emit) async {
    // int userId = event.action.userId ?? 0;
    int id = event.action.id ?? 0;
    Map<String, bool> initialUnsafeActions = {
      'Mala postura corporal': event.action.repAct1 ?? false,
      'Trabajo con calzado inadecuado': event.action.repAct2 ?? false,
      'Ingerir bebidas calientes en el escritorio de trabajo': event.action.repAct3 ?? false,
      'Sobrecargar las instalaciones eléctricas': event.action.repAct4 ?? false,
      'Jugar/bromear durante el desarrollo de una actividad de riesgo': event.action.repAct5 ?? false,
      'Trabajar o permitir trabajar sin EPP’s': event.action.repAct6 ?? false,
      'Operar equipos sin autorización': event.action.repAct7 ?? false,
      'Usar equipos defectuosos': event.action.repAct8 ?? false,
      'Trabajar bajo los efectos del alcohol y/o drogas': event.action.repAct9 ?? false,
      'Desactivar dispositivos de seguridad': event.action.repAct10 ?? false,
      'Cargar o levantar incorrectamente': event.action.repAct11 ?? false,
      'Dar servicio a equipo en funcionamiento': event.action.repAct12 ?? false,
      'Uso indebido de equipos o materiales': event.action.repAct13 ?? false,
    };

    emit(state.copyWith(
      unsafeActions: initialUnsafeActions,
      dateReport: BlocFormItem(value: event.action.date.toString() ?? ''),
      timeReport: BlocFormItem(value: event.action.hour ?? ''),
      locationReport: BlocFormItem(value: event.action.location ?? ''),
      immediateAction: BlocFormItem(value: event.action.immediateAction ?? ''),
      suggestionImprovement: BlocFormItem(value: event.action.suggestionImprovement ?? ''),
      // userId: userId,
      id: id,
    ));
  }

  Future<void> _onClearImageModify(ClearImageModifyEvent event, Emitter<DetailModifyUnsafeActionState> emit) async {
    if (state.img != null) {
      emit(
        state.copyWith(
            img: null
        ),
      );
    }
  }

  Future<void> _onDateReportChange(DateReportChange event, Emitter<DetailModifyUnsafeActionState> emit) async {
    emit(
        state.copyWith(
            dateReport: BlocFormItem(
                value: event.dateReport.value,
                error: event.dateReport.value.isNotEmpty? null: 'Ingrese una fecha'
            ),
            formKey: formKey
        )
    );
  }

  Future<void> _onTimeReportChange(TimeReportChange event, Emitter<DetailModifyUnsafeActionState> emit) async {
    emit(
        state.copyWith(
            timeReport: BlocFormItem(
                value: event.timeReport.value,
                error: event.timeReport.value.isNotEmpty? null: 'Ingrese una hora'
            ),
            formKey: formKey
        )
    );
  }

  Future<void> _onLocationReportChange(LocationReportChange event, Emitter<DetailModifyUnsafeActionState> emit) async {
    emit(
        state.copyWith(
            locationReport: BlocFormItem(
                value: event.locationReport.value,
                error: event.locationReport.value.isNotEmpty? null: 'Ingrese un lugar de hallazgo'
            ),
            formKey: formKey
        )
    );
  }

  Future<void> _onImmediateActionReportChange(ImmediateActionReportChange event, Emitter<DetailModifyUnsafeActionState> emit) async {
    emit(
        state.copyWith(
            immediateAction: BlocFormItem(
                value: event.immediateAction.value,
                error: event.immediateAction.value.isNotEmpty? null: ''
            ),
            formKey: formKey
        )
    );
  }

  Future<void> _onSuggestionImprovementReportChange(SuggestionImprovementReportChange event, Emitter<DetailModifyUnsafeActionState> emit) async {
    emit(
        state.copyWith(
            suggestionImprovement: BlocFormItem(
                value: event.suggestionImprovement.value,
                error: event.suggestionImprovement.value.isNotEmpty? null: ''
            ),
            formKey: formKey
        )
    );
  }

  Future<void> _onActionInsegurosModifyListChange(ActionInsegurosModifyListChange event, Emitter<DetailModifyUnsafeActionState> emit) async {
    emit(
        state.copyWith(
          unsafeActions: event.unsafeActions, // Actualizar el estado con las acciones inseguras
        )
    );
  }

  Future<void> _onImageModifyChange(ImgModifyChange event, Emitter<DetailModifyUnsafeActionState> emit) async {
    emit(
        state.copyWith(
            img: File(
                event.image.path
            )
        )
    );
  }

  Future<void> _onSaveSubmit(SaveSubmit event, Emitter<DetailModifyUnsafeActionState> emit) async {
    try {
      emit(
          state.copyWith(
              response: Loading(),
              formKey: formKey
          )
      );
      Resource response = await unsafeActionUseCase.update.run(state.id, state.toUnsafeAction(), state.img);
      emit(
          state.copyWith(
              response: response,
              formKey: formKey
          )
      );
    } catch(e) {
      print("Error Bloc ${e}");
    }
  }

  Future<void> _onModifyFormReset(ModifyFormReset event, Emitter<DetailModifyUnsafeActionState> emit) async {
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
              img: File(image.path)
          )
      );
    }
  }
}