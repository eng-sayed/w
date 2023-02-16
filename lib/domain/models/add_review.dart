import 'dart:io';

import 'package:dio/dio.dart';

class AddReviewModel {
  String? comment;
  List<File>? images;
  File? videos;
  double? score;

  AddReviewModel({
    this.images,
    this.comment,
    this.score,
    this.videos,
  });

  AddReviewModel.fromJson(Map<String, dynamic> json) {
    comment = json['comment'];
    images = json['images'];
    videos = json['videos'];
    score = json['score'];
  }

  Future<Map<String, dynamic>> toJson() async {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['comment'] = this.comment;
    data['score'] = this.score;

    if (this.images != null) {
      print("323232" + images!.length.toString());
      data['images[]'] = [
        for (int i = 0; i < (this.images ?? []).length; i++)
          await MultipartFile.fromFile((this.images ?? [])[i].path)
      ];
    }
    if (videos != null) {
      data['videos[]'] = await MultipartFile.fromFile(videos?.path ?? "");
    }
    // if (this.videos != null) {
    //   print("323232" + videos!.length.toString());
    //   data['videos[]'] = [
    //     for (int i = 0; i < (this.videos ?? []).length; i++)
    //       await MultipartFile.fromFile((this.videos ?? [])[i].path)
    //   ];
    // }
    print(data);
    return data;
  }
}
