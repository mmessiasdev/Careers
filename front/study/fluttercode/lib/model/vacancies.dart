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
  List<Null>? categoriesVacancies;
  List<Candidate>? candidate;
  String? urlLogo;

  Vacancies(
      {this.id,
      this.title,
      this.desc,
      this.urlLogo,
      this.local,
      this.vacanciesnumber,
      this.value,
      this.enterprise,
      this.publishedAt,
      this.createdAt,
      this.updatedAt,
      this.categoriesVacancies,
      this.candidate});

  Vacancies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    desc = json['desc'];
    local = json['local'];
    vacanciesnumber = json['vacanciesnumber'];
    value = json['value'];
    urlLogo = json["enterprise"]["urllogo"];
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
    data["enterprise"]["urllogo"] = this.urlLogo;
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
  String? name;
  String? urllogo;
  String? publishedAt;
  String? createdAt;
  String? updatedAt;

  Enterprise(
      {this.id,
      this.desc,
      this.profile,
      this.name,
      this.urllogo,
      this.publishedAt,
      this.createdAt,
      this.updatedAt});

  Enterprise.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    desc = json['desc'];
    profile = json['profile'];
    name = json['name'];
    urllogo = json['urllogo'];
    publishedAt = json['published_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['desc'] = this.desc;
    data['profile'] = this.profile;
    data['name'] = this.name;
    data['urllogo'] = this.urllogo;
    data['published_at'] = this.publishedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Candidate {
  int? id;
  String? email;
  int? user;
  String? fullname;
  int? enterprise;
  Null? student;
  String? curriculumdesc;
  String? birth;
  String? publishedAt;
  String? createdAt;
  String? updatedAt;

  Candidate(
      {this.id,
      this.email,
      this.user,
      this.fullname,
      this.enterprise,
      this.student,
      this.curriculumdesc,
      this.birth,
      this.publishedAt,
      this.createdAt,
      this.updatedAt});

  Candidate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    user = json['user'];
    fullname = json['fullname'];
    enterprise = json['enterprise'];
    student = json['student'];
    curriculumdesc = json['curriculumdesc'];
    birth = json['birth'];
    publishedAt = json['published_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['user'] = this.user;
    data['fullname'] = this.fullname;
    data['enterprise'] = this.enterprise;
    data['student'] = this.student;
    data['curriculumdesc'] = this.curriculumdesc;
    data['birth'] = this.birth;
    data['published_at'] = this.publishedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
