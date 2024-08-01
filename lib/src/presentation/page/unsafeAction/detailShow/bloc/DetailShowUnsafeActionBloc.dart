import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/subjects.dart';
import 'package:sipil_app/src/domain/models/response/AuthResponse.dart';
import 'package:sipil_app/src/domain/useCases/auth/AuthUseCase.dart';
import 'package:sipil_app/src/domain/useCases/unsafeAction/UnsafeActionUseCase.dart';
import 'package:sipil_app/src/domain/utils/Resource.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/detailShow/bloc/DetailShowUnsafeActionEvent.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/detailShow/bloc/DetailShowUnsafeActionState.dart';
import 'package:sipil_app/src/presentation/utils/BlocFormItem.dart';

class DetailShowUnsafeActionBloc extends Bloc<DetailShowUnsafeActionEvent, DetailShowUnsafeActionState> {
  UnsafeActionUseCase unsafeActionUseCase;
  AuthUseCase authUseCase;
  DetailShowUnsafeActionBloc(this.unsafeActionUseCase, this.authUseCase): super(DetailShowUnsafeActionState()) {
    on<DetailShowUnsafeActionInitEvent>(_onInitEvent);
    on<DateReportChange>(_onDateReportChange);
    on<TimeReportChange>(_onTimeReportChange);
    on<LocationReportChange>(_onLocationReportChange);
    on<ImmediateActionReportChange>(_onImmediateActionReportChange);
    on<SuggestionImprovementReportChange>(_onSuggestionImprovementReportChange);
    on<SaveSubmit>(_onSaveSubmit);
    on<InitShowUnsafeActions>(_onInitShowUnsafeActions);
    on<ActionInsegurosShowListChange>(_onActionInsegurosShowListChange);
  }

  final _timeController = BehaviorSubject<String>();
  Stream<String> get timeStream => _timeController.stream;
  final formKey = GlobalKey<FormState>();

  Future<void> _onInitEvent(DetailShowUnsafeActionInitEvent event, Emitter<DetailShowUnsafeActionState> emit) async {
    AuthResponse? authResponse = await authUseCase.getUserSessionUseCase.run();
    print('AUTHRESPÖNSE $authResponse');
    emit(state.copyWith(
      nameCompany: BlocFormItem(value: authResponse?.user?.company?.name ?? ''),
      nameUser: BlocFormItem(value: authResponse?.user?.name ?? ''),
      lastnameUser: BlocFormItem(value: authResponse?.user?.lastname ?? ''),
      dniUser: BlocFormItem(value: authResponse?.user?.dni ?? ''),
      areaProject: BlocFormItem(value: authResponse?.user?.project ?? ''),
      responsableProject: BlocFormItem(value: authResponse?.user?.projectManager ?? ''),
    ));
  }

  Future<void> _onInitShowUnsafeActions(InitShowUnsafeActions event, Emitter<DetailShowUnsafeActionState> emit) async {
    AuthResponse? authResponse = await authUseCase.getUserSessionUseCase.run();
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
      dateReport: BlocFormItem(value: event.action.date.toString()),
      timeReport: BlocFormItem(value: event.action.hour ?? ''),
      locationReport: BlocFormItem(value: event.action.location ?? ''),
      immediateAction: BlocFormItem(value: event.action.immediateAction ?? ''),
      suggestionImprovement: BlocFormItem(value: event.action.suggestionImprovement ?? ''),
      nameCompany: BlocFormItem(value: authResponse?.user?.company?.name ?? ''),
      nameUser: BlocFormItem(value: authResponse?.user?.name ?? ''),
      lastnameUser: BlocFormItem(value: authResponse?.user?.lastname ?? ''),
      dniUser: BlocFormItem(value: authResponse?.user?.dni ?? ''),
      areaProject: BlocFormItem(value: authResponse?.user?.project ?? ''),
      responsableProject: BlocFormItem(value: authResponse?.user?.projectManager ?? ''),
    ));
  }

  Future<void> _onActionInsegurosShowListChange(ActionInsegurosShowListChange event, Emitter<DetailShowUnsafeActionState> emit) async {
    emit(
        state.copyWith(
          unsafeActions: event.unsafeActions,
        )
    );
  }

  Future<void> _onDateReportChange(DateReportChange event, Emitter<DetailShowUnsafeActionState> emit) async {
    emit(
        state.copyWith(
            dateReport: BlocFormItem(
                value: event.dateReport.value,
                error: event.dateReport.value.isNotEmpty? null: ''
            ),
            formKey: formKey
        )
    );
  }

  Future<void> _onTimeReportChange(TimeReportChange event, Emitter<DetailShowUnsafeActionState> emit) async {
    emit(
        state.copyWith(
            timeReport: BlocFormItem(
                value: event.timeReport.value,
                error: event.timeReport.value.isNotEmpty? null: ''
            ),
            formKey: formKey
        )
    );
  }

  Future<void> _onLocationReportChange(LocationReportChange event, Emitter<DetailShowUnsafeActionState> emit) async {
    emit(
        state.copyWith(
            locationReport: BlocFormItem(
                value: event.locationReport.value,
                error: event.locationReport.value.isNotEmpty? null: ''
            ),
            formKey: formKey
        )
    );
  }

  Future<void> _onImmediateActionReportChange(ImmediateActionReportChange event, Emitter<DetailShowUnsafeActionState> emit) async {
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

  Future<void> _onSuggestionImprovementReportChange(SuggestionImprovementReportChange event, Emitter<DetailShowUnsafeActionState> emit) async {
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

  Future<void> _onSaveSubmit(SaveSubmit event, Emitter<DetailShowUnsafeActionState> emit) async {
    try {
      emit(
          state.copyWith(
              response: Loading(),
              formKey: formKey
          )
      );
      // Resource response = await unsafeActionUseCase.create.run(state.toUnsafeAction());
      // emit(
      //     state.copyWith(
      //         response: response,
      //         formKey: formKey
      //     )
      // );
    } catch(e) {
      print("Error Bloc ${e}");
    }
  }

  void changeTime(String time) {
    _timeController.sink.add(time);
  }

  void onTakePhoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
  }

  void onTakeImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  }

}