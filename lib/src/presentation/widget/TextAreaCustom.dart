import 'package:flutter/material.dart';

class TextAreaCustom extends StatelessWidget {

  String label;
  int? maxLine;
  TextEditingController? controller;
  final Function(String text) onChanged;
  final String? Function(String?)? validator;
  String? initialValue;
  final bool readOnly;

  TextAreaCustom({
    Key? key,
    required this.label,
    this.maxLine,
    this.controller,
    required this.onChanged,
    this.initialValue,
    this.validator,
    this.readOnly = false,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.normal
            ),
          ),
          TextFormField(
            controller: controller,
            maxLines: maxLine,
            initialValue: initialValue,
            readOnly: readOnly,
            validator: validator,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              filled: true,
              fillColor: (readOnly)
                  ? Colors.black.withOpacity(0.3)
                  : Colors.white.withOpacity(0.7),
            ),
            onChanged: (text) {
              onChanged(text);
            },
          ),
        ],
      ),
    );
  }
}
