import 'dart:convert';
import 'package:sipil_app/src/domain/models/UnsafeAction.dart';

UnsafeUniqueActionResponse unsafeActionResponseFromJson(String str) => UnsafeUniqueActionResponse.fromJson(json.decode(str));

String authResponseToJson(UnsafeUniqueActionResponse data) => json.encode(data.toJson());

class UnsafeUniqueActionResponse {
  bool? success;
  String? message;
  UnsafeAction? unsafeAction;

  UnsafeUniqueActionResponse({
    this.success,
    this.message,
    this.unsafeAction,
  });

  factory UnsafeUniqueActionResponse.fromJson(Map<String, dynamic> json) => UnsafeUniqueActionResponse(
    success: json["success"],
    message: json["message"],
    unsafeAction: UnsafeAction.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": unsafeAction?.toJson(),
  };
}