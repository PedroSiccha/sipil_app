import 'dart:convert';
import 'package:sipil_app/src/domain/models/UnsafeAction.dart';

UnsafeActionResponse unsafeActionResponseFromJson(String str) => UnsafeActionResponse.fromJson(json.decode(str));

String authResponseToJson(UnsafeActionResponse data) => json.encode(data.toJson());

class UnsafeActionResponse {
  bool? success;
  String? message;
  List<UnsafeAction>? unsafeAction;

  UnsafeActionResponse({
    this.success,
    this.message,
    this.unsafeAction,
  });

  factory UnsafeActionResponse.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List;
    List<UnsafeAction> actions = dataList.map((item) => UnsafeAction.fromJson(item)).toList();
    return UnsafeActionResponse(
      success: json["success"],
      message: json["message"],
      unsafeAction: actions,
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": unsafeAction?.map((x) => x.toJson()).toList(),
  };
}