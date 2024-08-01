import 'package:flutter/material.dart';
import 'package:sipil_app/src/utils/colors.dart';

class DefaultButtom extends StatelessWidget {

  String text;
  Function() onPressed;
  Color? color;
  bool isEnable;

  DefaultButtom({
    required this.text,
    required this.onPressed,
    this.color = AppColors.ColorPrincipal,
    required this.isEnable
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          onPressed();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnable ? color: AppColors.ColorDisable,
          padding: EdgeInsets.fromLTRB(16.0, 12.0, 24.0, 12.0),
          textStyle: TextStyle(fontSize: 14.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
          elevation: 0
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                color: Colors.white
              ),
            )
          ],
        )
    );
  }
}
