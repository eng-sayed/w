// class BlogsModel {
//   int? id;
//   String? title;
//   String? content;
//   String? image;
//   String? createdAt;
//   List<String>? gallery;

//   BlogsModel(
//       {this.id,
//       this.title,
//       this.content,
//       this.image,
//       this.createdAt,
//       this.gallery});

//   BlogsModel.fromJson(Map<String, dynamic> json) {
//     gallery = json['gallery'].cast<String>();
//     id = json['id'];
//     title = json['title'];
//     content = json['content'];
//     image = json['image'];
//     createdAt = json['created_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['title'] = this.title;
//     data['content'] = this.content;
//     data['image'] = this.image;
//     data['created_at'] = this.createdAt;
//     data['gallery'] = this.gallery;
//     return data;
//   }

//   BlogsModel copyWith({
//     int? id,
//     String? title,
//     String? content,
//     String? image,
//     String? createdAt,
//   }) {
//     return BlogsModel(
//       id: id ?? this.id,
//       title: title ?? this.title,
//       content: content ?? this.content,
//       image: image ?? this.image,
//       createdAt: createdAt ?? this.createdAt,
//     );
//   }
// }
class AllDataBlogModel {
  List<Blogs>? blogs;
  List<String>? gallery;

  AllDataBlogModel({this.blogs, this.gallery});

  AllDataBlogModel.fromJson(Map<String, dynamic> json) {
    if (json['blogs'] != null) {
      blogs = <Blogs>[];
      json['blogs'].forEach((v) {
        blogs!.add(new Blogs.fromJson(v));
      });
    }
    gallery = json['gallery'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.blogs != null) {
      data['blogs'] = this.blogs!.map((v) => v.toJson()).toList();
    }
    data['gallery'] = this.gallery;
    return data;
  }
}

class Blogs {
  int? id;
  String? title;
  String? content;
  String? image;
  String? createdAt;

  Blogs({this.id, this.title, this.content, this.image, this.createdAt});

  Blogs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    image = json['image'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    return data;
  }
}
