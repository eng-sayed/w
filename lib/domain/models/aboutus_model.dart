class AboutUsModel {
  List<String>? aboutGallery;
  String? about;
  String? contactPhones;
  String? privacyPolicy;
  String? openTime;
  String? closeTime;
  String? location;
  String? blogGallery;
  String? facebookLink;
  String? instagramLink;
  String? youtubeLink;
  String? complaint_phone;
  // String? youtube_link;
  String? youtube_video_link;
  String? tiktokLink;

  AboutUsModel(
      {this.aboutGallery,
      this.about,
      this.contactPhones,
      // this.youtube_link,
      this.youtube_video_link,
      this.privacyPolicy,
      this.openTime,
      this.complaint_phone,
      this.closeTime,
      this.location,
      this.blogGallery,
      this.facebookLink,
      this.instagramLink,
      this.youtubeLink,
      this.tiktokLink});

  AboutUsModel.fromJson(Map<String, dynamic> json) {
    aboutGallery = json['about_gallery'].cast<String>();
    about = json['about'];
    // youtube_link = json['youtube_link'];
    youtube_video_link = json['youtube_video_link'];
    contactPhones = json['contact_phones'];
    privacyPolicy = json['privacy_policy'];
    openTime = json['open_time'];
    closeTime = json['close_time'];
    location = json['location'];
    complaint_phone = json['complaint_phone'];
    blogGallery = json['blog_gallery'];
    facebookLink = json['facebook_link'];
    instagramLink = json['instagram_link'];
    youtubeLink = json['youtube_link'];
    tiktokLink = json['tiktok_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['about_gallery'] = this.aboutGallery;
    // data['youtube_link'] = this.youtube_link;
    data['youtube_video_link'] = this.youtube_video_link;
    data['about'] = this.about;
    data['contact_phones'] = this.contactPhones;
    data['privacy_policy'] = this.privacyPolicy;
    data['open_time'] = this.openTime;
    data['close_time'] = this.closeTime;
    data['complaint_phone'] = this.complaint_phone;
    data['location'] = this.location;
    data['blog_gallery'] = this.blogGallery;
    data['facebook_link'] = this.facebookLink;
    data['instagram_link'] = this.instagramLink;
    data['youtube_link'] = this.youtubeLink;
    data['tiktok_link'] = this.tiktokLink;
    return data;
  }
}
