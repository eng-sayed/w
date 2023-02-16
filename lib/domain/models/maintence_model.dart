class MaintenanceModel {
  String? reservationDate;
  int? branchId;
  int? carId;
  num? lat;
  num? lng;
  String? address;
  String? phone;
  String? notes;
  String? promo_code;
  List<int>? subServices;

  MaintenanceModel(
      {this.reservationDate,
      this.branchId,
      this.carId,
      this.notes,
      this.lat,
      this.lng,
      this.address,
      this.phone,
      this.promo_code,
      this.subServices});

  MaintenanceModel.fromJson(Map<String, dynamic> json) {
    reservationDate = json['reservation_date'];
    branchId = json['branch_id'];
    carId = json['car_id'];
    notes = json['notes'];
    promo_code = json['promo_code'];
    lat = json['lat'];
    lng = json['lng'];
    address = json['address'];
    phone = json['phone'];
    subServices = json['sub_services'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reservation_date'] = this.reservationDate;
    data['branch_id'] = this.branchId;
    data['promo_code'] = this.promo_code;
    data['car_id'] = this.carId;
    data['notes'] = this.notes;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['sub_services'] = this.subServices;
    return data;
  }

  MaintenanceModel copyWith({
    String? reservationDate,
    int? branchId,
    int? carId,
    num? lat,
    num? lng,
    String? notes,
    String? promo_code,
    String? address,
    String? phone,
    List<int>? subServices,
  }) {
    return MaintenanceModel(
      reservationDate: reservationDate ?? this.reservationDate,
      branchId: branchId ?? this.branchId,
      promo_code: promo_code ?? this.promo_code,
      carId: carId ?? this.carId,
      notes: notes ?? this.notes,
      phone: phone ?? this.phone,
      lng: lng ?? this.lng,
      lat: lat ?? this.lat,
      address: address ?? this.address,
      subServices: subServices ?? this.subServices,
    );
  }
}
