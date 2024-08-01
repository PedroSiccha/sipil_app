import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sipil_app/src/presentation/widget/DefaultButtom.dart';
import 'package:sipil_app/src/utils/colors.dart';

SelectedOptionImageDialog(BuildContext context, Function() pickImage, Function() takePhoto) {
  return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Seleccione una opción'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: DefaultButtom(
                    text: 'Galería',
                    color: AppColors.ColorPrincipal,
                    onPressed: () {
                      Navigator.pop(context);
                      pickImage();
                    },
                    isEnable: true,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DefaultButtom(
                    text: 'Cámara',
                    color: AppColors.ColorDisable,
                    onPressed: () {
                      Navigator.pop(context);
                      takePhoto();
                    },
                    isEnable: true,
                  ),
                )
              ],
            ),
          )
        ],
      )
  );
}