class Vacancies {
  int? id;
  String? title;
  String? desc;
  String? local;
  String? vacanciesnumber;
  String? value;
  Enterprise? enterprise;
  String? publishedAt;
  String? createdAt;
  String? updatedAt;

  Vacancies(
      {this.id,
      this.title,
      this.desc,
      this.local,
      this.vacanciesnumber,
      this.value,
      this.enterprise,
      this.publishedAt,
      this.createdAt,
      this.updatedAt});

  Vacancies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    desc = json['desc'];
    local = json['local'];
    vacanciesnumber = json['vacanciesnumber'];
    value = json['value'];
    enterprise = json['enterprise'] != null
        ? new Enterprise.fromJson(json['enterprise'])
        : null;
    publishedAt = json['published_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['local'] = this.local;
    data['vacanciesnumber'] = this.vacanciesnumber;
    data['value'] = this.value;
    if (this.enterprise != null) {
      data['enterprise'] = this.enterprise!.toJson();
    }
    data['published_at'] = this.publishedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Enterprise {
  int? id;
  String? desc;
  int? profile;
  String? publishedAt;
  String? createdAt;
  String? updatedAt;

  Enterprise(
      {this.id,
      this.desc,
      this.profile,
      this.publishedAt,
      this.createdAt,
      this.updatedAt});

  Enterprise.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    desc = json['desc'];
    profile = json['profile'];
    publishedAt = json['published_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['desc'] = this.desc;
    data['profile'] = this.profile;
    data['published_at'] = this.publishedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
