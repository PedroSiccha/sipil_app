class UnsafeAction {
  DateTime? date;
  String? hour;
  String? location;
  bool? repAct1;
  bool? repAct2;
  bool? repAct3;
  bool? repAct4;
  bool? repAct5;
  bool? repAct6;
  bool? repAct7;
  bool? repAct8;
  bool? repAct9;
  bool? repAct10;
  bool? repAct11;
  bool? repAct12;
  bool? repAct13;
  String? img;
  String? immediateAction;
  String? suggestionImprovement;
  String? status;
  String? answer;
  int? userId;
  int? id;
  String? action;

  UnsafeAction({
    this.date,
    this.hour,
    this.location,
    this.repAct1,
    this.repAct2,
    this.repAct3,
    this.repAct4,
    this.repAct5,
    this.repAct6,
    this.repAct7,
    this.repAct8,
    this.repAct9,
    this.repAct10,
    this.repAct11,
    this.repAct12,
    this.repAct13,
    this.img,
    this.immediateAction,
    this.suggestionImprovement,
    this.status,
    this.answer,
    this.userId,
    this.id,
    this.action
  });

  factory UnsafeAction.fromJson(Map<String, dynamic> json) => UnsafeAction(
    date: json["date"] != null ? DateTime.parse(json["date"]) : null,
    hour: json["hour"],
    location: json["location"],
    repAct1: json["repAct1"] == 'true' || json["repAct1"] == true,
    repAct2: json["repAct2"] == 'true' || json["repAct2"] == true,
    repAct3: json["repAct3"] == 'true' || json["repAct3"] == true,
    repAct4: json["repAct4"] == 'true' || json["repAct4"] == true,
    repAct5: json["repAct5"] == 'true' || json["repAct5"] == true,
    repAct6: json["repAct6"] == 'true' || json["repAct6"] == true,
    repAct7: json["repAct7"] == 'true' || json["repAct7"] == true,
    repAct8: json["repAct8"] == 'true' || json["repAct8"] == true,
    repAct9: json["repAct9"] == 'true' || json["repAct9"] == true,
    repAct10: json["repAct10"] == 'true' || json["repAct10"] == true,
    repAct11: json["repAct11"] == 'true' || json["repAct11"] == true,
    repAct12: json["repAct12"] == 'true' || json["repAct12"] == true,
    repAct13: json["repAct13"] == 'true' || json["repAct13"] == true,
    img: json["img"],
    immediateAction: json["immediate_action"],
    suggestionImprovement: json["suggestion_improvement"],
    status: json["status"],
    answer: json["answer"],
    userId: json["userId"],
    id: json["id"],
    action: json['action']
  );

  Map<String, dynamic> toJson() => {
    "date": date?.toIso8601String() ?? "",
    "hour": hour ?? "",
    "location": location ?? "",
    "repAct1": repAct1 ?? false,
    "repAct2": repAct2 ?? false,
    "repAct3": repAct3 ?? false,
    "repAct4": repAct4 ?? false,
    "repAct5": repAct5 ?? false,
    "repAct6": repAct6 ?? false,
    "repAct7": repAct7 ?? false,
    "repAct8": repAct8 ?? false,
    "repAct9": repAct9 ?? false,
    "repAct10": repAct10 ?? false,
    "repAct11": repAct11 ?? false,
    "repAct12": repAct12 ?? false,
    "repAct13": repAct13 ?? false,
    "img": img ?? "",
    "immediate_action": immediateAction ?? "",
    "suggestion_improvement": suggestionImprovement ?? "",
    "status": status ?? "",
    "answer": answer ?? "",
    "userId": userId ?? 0,
    "id": id ?? 0,
    "action": action
  };
}
