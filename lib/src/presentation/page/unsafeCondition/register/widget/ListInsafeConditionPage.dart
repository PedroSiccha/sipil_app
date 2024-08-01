import 'package:flutter/material.dart';
import 'package:sipil_app/src/utils/colors.dart';

class ListUnsafeConditionPage extends StatefulWidget {
  final Function(Map<String, bool> state) onChanged;
  final Map<String, bool>? initialState;
  ListUnsafeConditionPage(
      {super.key, required this.onChanged, this.initialState});

  @override
  State<ListUnsafeConditionPage> createState() =>
      _ListUnsafeConditionPageState();
}

class _ListUnsafeConditionPageState extends State<ListUnsafeConditionPage> {
  late Map<String, bool> _conditionUnsafe;
  @override
  void initState() {
    super.initState();
    _conditionUnsafe = widget.initialState ??
        {
          'Falta de orden y limpieza': false,
          'Guardas o barreras inadecuadas': false,
          'Pasamanos de las escaleras inadecuadas o mal estado': false,
          'Iluminacion deficiente/excesiva en el ambiente del trabajo': false,
          'Equipos de protección personal incorrectos o inadecuados': false,
          'Ruido excesivo en el área de trabajo': false,
          'Piso en mal estado': false,
          'Ascensores en mal estado': false,
          'Falta de señalización en área o equipo': false,
          'Presencia de polvos/gases en el área de trabajo': false,
          'Condiciones de trabajo peligrosas': false,
          'Herramientas y equipos defectuoso': false,
          'Materiales químicos peligrosos expuestos': false,
          'Otros (Describa lo que observó)': false,
        };
  }

  @override
  void didUpdateWidget(covariant ListUnsafeConditionPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialState != oldWidget.initialState) {
      setState(() {
        _conditionUnsafe = widget.initialState ?? _conditionUnsafe;
      });
    }
  }

  void _handleCheckboxChanged(String key, bool? value) {
    setState(() {
      _conditionUnsafe[key] = value!;
    });
    widget.onChanged(_conditionUnsafe);
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
              'Reporte de Condición Insegura',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Column(
          children: _conditionUnsafe.keys.map((String key) {
            return CheckboxListTile(
              title: Text(key),
              value: _conditionUnsafe[key],
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