class ReviewModel {
  int? id;
  Service? service;
  User? user;
  int? score;
  String? comment;
  String? user_name;
  List<String>? images;
  List<String>? videos;
  ReviewModel(
      {this.id,
      this.service,
      this.user,
      this.score,
      this.videos,
      this.comment,
      this.images});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    service =
        json['service'] != null ? new Service.fromJson(json['service']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    score = json['score'];
    comment = json['comment'];
    user_name = json['user_name'];
    images = json['images'].cast<String>();
    videos = json['videos'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;

    data['images'] = this.images;
    data['videos'] = this.videos;
    if (this.service != null) {
      data['service'] = this.service!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['score'] = this.score;
    data['user_name'] = this.user_name;
    data['comment'] = this.comment;
    return data;
  }
}

class Service {
  int? id;
  String? name;
  String? image;
  String? description;
  String? shortDescription;
  // List<Null>? subServices;

  Service({
    this.id,
    this.name,
    this.image,
    this.description,
    this.shortDescription,
    // this.subServices
  });

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    shortDescription = json['short_description'];
    // if (json['sub_services'] != null) {
    //   subServices = <Null>[];
    //   json['sub_services'].forEach((v) {
    //     subServices!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['description'] = this.description;
    data['short_description'] = this.shortDescription;
    // if (this.subServices != null) {
    //   data['sub_services'] = this.subServices!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? avatar;

  User({this.id, this.name, this.email, this.phone, this.avatar});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['avatar'] = this.avatar;
    return data;
  }
}
