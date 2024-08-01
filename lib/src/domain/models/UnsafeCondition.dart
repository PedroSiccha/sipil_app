class UnsafeCondition {
  DateTime? date;
  String? hour;
  String? location;
  bool? repCon1;
  bool? repCon2;
  bool? repCon3;
  bool? repCon4;
  bool? repCon5;
  bool? repCon6;
  bool? repCon7;
  bool? repCon8;
  bool? repCon9;
  bool? repCon10;
  bool? repCon11;
  bool? repCon12;
  bool? repCon13;
  String? img;
  String? immediateAction;
  String? suggestionImprovement;
  String? status;
  String? answer;
  int? userId;
  int? id;
  String? condition;

  UnsafeCondition({
    this.date,
    this.hour,
    this.location,
    this.repCon1,
    this.repCon2,
    this.repCon3,
    this.repCon4,
    this.repCon5,
    this.repCon6,
    this.repCon7,
    this.repCon8,
    this.repCon9,
    this.repCon10,
    this.repCon11,
    this.repCon12,
    this.repCon13,
    this.img,
    this.immediateAction,
    this.suggestionImprovement,
    this.status,
    this.answer,
    this.userId,
    this.id,
    this.condition
  });

  factory UnsafeCondition.fromJson(Map<String, dynamic> json) => UnsafeCondition(
      date: json["date"] != null ? DateTime.parse(json["date"]) : null,
      hour: json["hour"],
      location: json["location"],
      repCon1: json["repCon1"] == 'true' || json["repCon1"] == true,
      repCon2: json["repCon2"] == 'true' || json["repCon2"] == true,
      repCon3: json["repCon3"] == 'true' || json["repCon3"] == true,
      repCon4: json["repCon4"] == 'true' || json["repCon4"] == true,
      repCon5: json["repCon5"] == 'true' || json["repCon5"] == true,
      repCon6: json["repCon6"] == 'true' || json["repCon6"] == true,
      repCon7: json["repCon7"] == 'true' || json["repCon7"] == true,
      repCon8: json["repCon8"] == 'true' || json["repCon8"] == true,
      repCon9: json["repCon9"] == 'true' || json["repCon9"] == true,
      repCon10: json["repCon10"] == 'true' || json["repCon10"] == true,
      repCon11: json["repCon11"] == 'true' || json["repCon11"] == true,
      repCon12: json["repCon12"] == 'true' || json["repCon12"] == true,
      repCon13: json["repCon13"] == 'true' || json["repCon13"] == true,
      img: json["img"],
      immediateAction: json["immediate_action"],
      suggestionImprovement: json["suggestion_improvement"],
      status: json["status"],
      answer: json["answer"],
      userId: json["userId"],
      id: json["id"],
      condition: json['condition']
  );

  Map<String, dynamic> toJson() => {
    "date": date?.toIso8601String() ?? "",
    "hour": hour ?? "",
    "location": location ?? "",
    "repCon1": repCon1 ?? false,
    "repCon2": repCon2 ?? false,
    "repCon3": repCon3 ?? false,
    "repCon4": repCon4 ?? false,
    "repCon5": repCon5 ?? false,
    "repCon6": repCon6 ?? false,
    "repCon7": repCon7 ?? false,
    "repCon8": repCon8 ?? false,
    "repCon9": repCon9 ?? false,
    "repCon10": repCon10 ?? false,
    "repCon11": repCon11 ?? false,
    "repCon12": repCon12 ?? false,
    "repCon13": repCon13 ?? false,
    "img": img ?? "",
    "immediate_action": immediateAction ?? "",
    "suggestion_improvement": suggestionImprovement ?? "",
    "status": status ?? "",
    "answer": answer ?? "",
    "userId": userId ?? 0,
    "id": id ?? 0,
    "condition": condition
  };

}