import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/register/bloc/RegisterUnsafeActionBloc.dart';
import 'package:sipil_app/src/presentation/page/unsafeAction/register/bloc/RegisterUnsafeActionEvent.dart';
import 'package:sipil_app/src/utils/colors.dart';

class ListUnsafeActionPage extends StatefulWidget {
  final Function(Map<String, bool> state) onChanged;
  final Map<String, bool>? initialState;
  const ListUnsafeActionPage({
    super.key,
    required this.onChanged,
    this.initialState,
  });

  @override
  State<ListUnsafeActionPage> createState() => _ListUnsafeActionPageState();
}

class _ListUnsafeActionPageState extends State<ListUnsafeActionPage> {
  late Map<String, bool> _actosInseguros;

  @override
  void initState() {
    super.initState();
    _actosInseguros = widget.initialState ?? {
      'Mala postura corporal': false,
      'Trabajo con calzado inadecuado': false,
      'Ingerir bebidas calientes en el escritorio de trabajo': false,
      'Sobrecargar las instalaciones eléctricas': false,
      'Jugar/bromear durante el desarrollo de una actividad de riesgo': false,
      'Trabajar o permitir trabajar sin EPP’s': false,
      'Operar equipos sin autorización': false,
      'Usar equipos defectuosos': false,
      'Trabajar bajo los efectos del alcohol y/o drogas': false,
      'Desactivar dispositivos de seguridad': false,
      'Cargar o levantar incorrectamente': false,
      'Dar servicio a equipo en funcionamiento': false,
      'Uso indebido de equipos o materiales': false,
    };
  }

  @override
  void didUpdateWidget(ListUnsafeActionPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialState != oldWidget.initialState) {
      setState(() {
        _actosInseguros = widget.initialState ?? _actosInseguros;
      });
    }
  }

  void _handleCheckboxChanged(String key, bool? value) {
    setState(() {
      _actosInseguros[key] = value!;
    });
    widget.onChanged(_actosInseguros);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            color: AppColors.ColorPrincipal,
            padding: const EdgeInsets.symmetric(vertical: 3.0),
            width: double.infinity,
            child: Text(
              'Reporte de Acto Inseguro',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Column(
          children: _actosInseguros.keys.map((String key) {
            return CheckboxListTile(
              title: Text(key),
              value: _actosInseguros[key],
              onChanged: (bool? value) {
                _handleCheckboxChanged(key, value);
              },
              contentPadding: EdgeInsets.only(top: 0),
            );
          }).toList(),
        ),
      ],
    );
  }
}