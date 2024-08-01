import 'package:sipil_app/src/domain/models/Company.dart';
import 'package:sipil_app/src/domain/models/Role.dart';

class User {
  int? id;
  String? username;
  String? name;
  String? lastname;
  String? email;
  String? ruc;
  String? dni;
  String? project;
  String? projectManager;
  dynamic notificationToken;
  List<Role>? roles;
  Company? company;

  User({
    this.id,
    this.username,
    this.name,
    this.lastname,
    this.email,
    this.ruc,
    this.dni,
    this.project,
    this.projectManager,
    this.notificationToken,
    this.roles,
    this.company,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    username: json["username"],
    name: json["name"],
    lastname: json["lastname"],
    email: json["email"],
    ruc: json["ruc"],
    dni: json["dni"],
    project: json["project"],
    projectManager: json["project_manager"],
    notificationToken: json["notification_token"],
    roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
    company: Company.fromJson(json["company"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "name": name,
    "lastname": lastname,
    "email": email,
    "ruc": ruc,
    "dni": dni,
    "project": project,
    "project_manager": projectManager,
    "notification_token": notificationToken,
    "roles": List<dynamic>.from(roles!.map((x) => x.toJson())),
    "company": company?.toJson(),
  };
}