import 'dart:convert';

class PartnerModel {
  String? company_name;
  String? email;
  String? phone;
  String? country;
  String? city;
  String? message;
  PartnerModel({
    this.company_name,
    this.email,
    this.phone,
    this.country,
    this.city,
    this.message,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (company_name != null) {
      result.addAll({'company_name': company_name});
    }
    if (email != null) {
      result.addAll({'email': email});
    }
    if (phone != null) {
      result.addAll({'phone': phone});
    }
    if (country != null) {
      result.addAll({'country': country});
    }
    if (city != null) {
      result.addAll({'city': city});
    }
    if (message != null) {
      result.addAll({'message': message});
    }

    return result;
  }

  factory PartnerModel.fromMap(Map<String, dynamic> map) {
    return PartnerModel(
      company_name: map['company_name'],
      email: map['email'],
      phone: map['phone'],
      country: map['country'],
      city: map['city'],
      message: map['message'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PartnerModel.fromJson(String source) =>
      PartnerModel.fromMap(json.decode(source));
}
