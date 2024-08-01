import 'dart:convert';

SearchUnsafeAction searchUnsafeActionFromJson(String str) => SearchUnsafeAction.fromJson(json.decode(str));

String searchUnsafeActionToJson(SearchUnsafeAction data) => json.encode(data.toJson());


class SearchUnsafeAction {
  String? companyName;
  String? username;
  String? dni;
  String? area;
  String? fromDate;
  String? toDate;

  SearchUnsafeAction({
    this.companyName,
    this.username,
    this.dni,
    this.area,
    this.fromDate,
    this.toDate,
  });

  factory SearchUnsafeAction.fromJson(Map<String, dynamic> json) => SearchUnsafeAction(
    companyName: json["companyName"],
    username: json["username"],
    dni: json["dni"],
    area: json["area"],
    fromDate: json["fromDate"],
    toDate: json["toDate"],
  );

  Map<String, dynamic> toJson() => {
    "companyName": companyName,
    "username": username,
    "dni": dni,
    "area": area,
    "fromDate": fromDate,
    "toDate": toDate,
  };
}