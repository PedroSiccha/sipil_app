class Company {
  int? id;
  String? name;
  String? address;
  String? phone;

  Company({
    this.id,
    this.name,
    this.address,
    this.phone,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
    id: json["id"],
    name: json["name"],
    address: json["address"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "address": address,
    "phone": phone,
  };
}