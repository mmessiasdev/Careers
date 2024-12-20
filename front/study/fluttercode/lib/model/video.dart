class OneCourseModel {
  int? id;
  String? title;
  String? desc;
  String? nivel;
  int? time;
  Null? enterprise;
  String? urlbanner;
  String? price;
  bool? private;
  String? publishedAt;
  String? createdAt;
  String? updatedAt;
  List<Videos>? videos;
  List<Categories>? categories;

  OneCourseModel(
      {this.id,
      this.title,
      this.desc,
      this.nivel,
      this.time,
      this.enterprise,
      this.urlbanner,
      this.price,
      this.private,
      this.publishedAt,
      this.createdAt,
      this.updatedAt,
      this.videos,
      this.categories});

  OneCourseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    desc = json['desc'];
    nivel = json['nivel'];
    time = json['time'];
    enterprise = json['enterprise'];
    urlbanner = json['urlbanner'];
    price = json['price'];
    private = json['private'];
    publishedAt = json['published_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['videos'] != null) {
      videos = <Videos>[];
      json['videos'].forEach((v) {
        videos!.add(new Videos.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['nivel'] = this.nivel;
    data['time'] = this.time;
    data['enterprise'] = this.enterprise;
    data['urlbanner'] = this.urlbanner;
    data['price'] = this.price;
    data['private'] = this.private;
    data['published_at'] = this.publishedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.videos != null) {
      data['videos'] = this.videos!.map((v) => v.toJson()).toList();
    }
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Videos {
  int? id;
  String? name;
  String? desc;
  String? url;
  double? time;
  bool? public;
  int? course;
  String? publishedAt;
  String? createdAt;
  String? updatedAt;

  Videos(
      {this.id,
      this.name,
      this.desc,
      this.url,
      this.time,
      this.public,
      this.course,
      this.publishedAt,
      this.createdAt,
      this.updatedAt});

  Videos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    desc = json['desc'];
    url = json['url'];
    time = json['time'];
    public = json['public'];
    course = json['course'];
    publishedAt = json['published_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['desc'] = this.desc;
    data['url'] = this.url;
    data['time'] = this.time;
    data['public'] = this.public;
    data['course'] = this.course;
    data['published_at'] = this.publishedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Categories {
  int? id;
  String? name;
  String? banner;
  String? publishedAt;
  String? createdAt;
  String? updatedAt;

  Categories(
      {this.id,
      this.name,
      this.banner,
      this.publishedAt,
      this.createdAt,
      this.updatedAt});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    banner = json['banner'];
    publishedAt = json['published_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['banner'] = this.banner;
    data['published_at'] = this.publishedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
