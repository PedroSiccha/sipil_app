import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sipil_app/src/utils/colors.dart';

class LabelTextField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData? icon;
  final Function(String text) onChanged;
  final Function()? onTap;
  final bool obscureText;
  final String? Function(String?)? validator;
  final String? errorText;
  final TextInputType? textType;
  final bool readOnly;
  final TextEditingController? controller;
  final Color? colorLabel;
  final VoidCallback? onIconTap;
  String? initialValue;

  LabelTextField({
    Key? key,
    required this.label,
    this.errorText,
    required this.hint,
    this.icon,
    required this.onChanged,
    this.onTap,
    this.validator,
    required this.obscureText,
    this.textType = TextInputType.text,
    this.readOnly = false,
    this.controller,
    this.colorLabel = Colors.white,
    this.onIconTap,
    this.initialValue
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 32.0),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
              color: colorLabel,
            ),
          ),
        ),
        SizedBox(
          height: 8.0,
        ),
        GestureDetector(
          onTap: onTap,
          child: TextFormField(
            controller: controller,
            readOnly: readOnly,
            keyboardType: textType,
            obscureText: obscureText,
            initialValue: initialValue,
            onChanged: (text) {
              onChanged(text);
            },
            validator: validator,
            cursorColor: AppColors.ColorPrincipal,
            decoration: InputDecoration(
              prefixIcon: icon != null
                  ? GestureDetector(
                onTap: onIconTap ?? null, // Use the provided function or the default
                child: Icon(icon),
              )
                  : null,
              hintText: hint,
              errorText: errorText,
              contentPadding: EdgeInsets.symmetric(horizontal: 24.0),
              filled: true,
              fillColor: (readOnly)
                  ? Colors.black.withOpacity(0.3)
                  : Colors.white.withOpacity(0.7),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(color: Colors.red, width: 2.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(color: AppColors.ColorPrincipal, width: 2.0),
              ),
            ),
            style: TextStyle(
              color: AppColors.ColorPrincipal,
            ),
          ),
        ),
      ],
    );
  }
}
