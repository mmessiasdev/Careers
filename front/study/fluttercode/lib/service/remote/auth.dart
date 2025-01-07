import 'dart:convert';
import 'package:Consult/model/balancelocalstores.dart';
import 'package:Consult/model/categories.dart';
import 'package:Consult/model/courses.dart';
import 'package:Consult/model/localstoriesverifiquedbuy.dart';
import 'package:Consult/model/plans.dart';
import 'package:Consult/model/localstores.dart';

import 'package:Consult/model/postsnauth.dart';
import 'package:Consult/model/profiles.dart';
import 'package:Consult/model/stores.dart';
import 'package:Consult/model/vacancies.dart';
import 'package:Consult/model/verfiquedexitbalances.dart';
import 'package:Consult/model/video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:Consult/model/postFiles.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

// const url = String.fromEnvironment('BASEURL', defaultValue: '');

class RemoteAuthService {
  var client = http.Client();
  final storage = FlutterSecureStorage();
  final url = dotenv.env["BASEURL"];

  Future<dynamic> signUp(
      {required String email,
      required String password,
      required String username}) async {
    var body = {"username": username, "email": email, "password": password};
    var response = await client.post(
      Uri.parse('${url.toString()}/auth/local/register'),
      headers: {
        "Content-Type": "application/json",
        "ngrok-skip-browser-warning": "true"
      },
      body: jsonEncode(body),
    );
    return response;
  }

  Future<dynamic> signIn({
    required String email,
    required String password,
  }) async {
    var body = {"identifier": email, "password": password};
    var response = await client.post(
      Uri.parse('${url.toString()}/auth/local'),
      headers: {
        "Content-Type": "application/json",
        'ngrok-skip-browser-warning': "true"
      },
      body: jsonEncode(body),
    );
    return response;
  }

  Future<dynamic> createProfile({
    required String fullname,
    required String token,
  }) async {
    var body = {
      "fullname": fullname,
    };
    var response = await client.post(
      Uri.parse('${url.toString()}/profile/me'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        'ngrok-skip-browser-warning': "true"
      },
      body: jsonEncode(body),
    );
    return response;
  }

  Future<http.Response> getProfile({
    required String token,
  }) async {
    // Faz a chamada GET e retorna o objeto Response diretamente
    return await client.get(
      Uri.parse('${url.toString()}/profiles/me'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        'ngrok-skip-browser-warning': "true",
      },
    );
  }

  Future<Map> getProfileDetails({
    required String? token,
  }) async {
    var response = await client.get(
      Uri.parse('${url.toString()}/profiles/me'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        'ngrok-skip-browser-warning': "true"
      },
    );
    var itens = json.decode(response.body);
    return itens;
  }

  Future<dynamic> putProfileCurriculumDesc({
    required String token,
    required String id,
    required String curriculumdesc,
  }) async {
    var body = {
      "curriculumdesc": curriculumdesc,
    };
    var response = await client.put(
      Uri.parse('${url.toString()}/profiles/$id'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        'ngrok-skip-browser-warning': "true"
      },
      body: jsonEncode(body),
    );
    return response;
  }

  Future<List<CoursesModel>> getCourses({
    required String? token,
    required String interpriseId,
  }) async {
    List<CoursesModel> listItens = [];
    var response = await client.get(
      Uri.parse('${url.toString()}/courses'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        'ngrok-skip-browser-warning': "true"
      },
    );
    var body = jsonDecode(response.body);
    var itemCount = body;
    for (var i = 0; i < itemCount.length; i++) {
      listItens.add(CoursesModel.fromJson(itemCount[i]));
    }
    return listItens;
  }

  Future<List<CoursesModel>> getCoursesSearch({
    required String token,
    required String query,
  }) async {
    List<CoursesModel> listItens = [];
    var response = await client.get(
      Uri.parse(
          "${url.toString()}/courses?private=false&title_contains=$query"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        'ngrok-skip-browser-warning': "true"
      },
    );
    var body = jsonDecode(response.body);
    var itemCount = body;
    for (var i = 0; i < itemCount.length; i++) {
      listItens.add(CoursesModel.fromJson(itemCount[i]));
    }
    return listItens;
  }

  Future<Map> getOneCourse({
    required String id,
    required String? token,
  }) async {
    var response = await client.get(
      Uri.parse('${url.toString()}/courses/$id'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        'ngrok-skip-browser-warning': "true"
      },
    );
    var itens = json.decode(response.body);
    return itens;
  }

  Future<dynamic> putFavoriteCourse({
    required String fullname,
    required String token,
    required String id,
    required String profileId,
  }) async {
    var body = {
      "profilespinned": [profileId],
    };
    var response = await client.put(
      Uri.parse('${url.toString()}/courses/$id'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        'ngrok-skip-browser-warning': "true"
      },
      body: jsonEncode(body),
    );
    return response;
  }

  Future<List<CoursesModel>> getFavoriteCourses(
      {required String? token, required String profileId}) async {
    List<CoursesModel> listItens = [];
    var response = await client.get(
      Uri.parse('${url.toString()}/courses?profilespinned.id_eq=$profileId'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        'ngrok-skip-browser-warning': "true"
      },
    );
    var body = jsonDecode(response.body);
    var itemCount = body;
    for (var i = 0; i < itemCount.length; i++) {
      listItens.add(CoursesModel.fromJson(itemCount[i]));
    }
    return listItens;
  }

  Future<List<CoursesModel>> getCerfiticatesCourses(
      {required String? token, required String profileId}) async {
    List<CoursesModel> listItens = [];
    var response = await client.get(
      Uri.parse(
          '${url.toString()}/courses?profilescerfiticates.id_eq=$profileId'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        'ngrok-skip-browser-warning': "true"
      },
    );
    var body = jsonDecode(response.body);
    var itemCount = body;
    for (var i = 0; i < itemCount.length; i++) {
      listItens.add(CoursesModel.fromJson(itemCount[i]));
    }
    return listItens;
  }

  Future<dynamic> putAddCerfiticates({
    required String fullname,
    required String token,
    required String id,
    required String profileId,
  }) async {
    var body = {
      "profilescerfiticates": [profileId],
    };
    var response = await client.put(
      Uri.parse('${url.toString()}/courses/$id'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        'ngrok-skip-browser-warning': "true"
      },
      body: jsonEncode(body),
    );
    return response;
  }

  Future<List<Videos>> getOneCourseVideos({
    required String? token,
    required String? id,
  }) async {
    List<Videos> listItens = [];
    var response = await client.get(
      Uri.parse('${url.toString()}/courses/$id'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        "ngrok-skip-browser-warning": "true"
      },
    );
    var body = jsonDecode(response.body);
    var itemCount = body['videos'];
    for (var i = 0; i < itemCount.length; i++) {
      listItens.add(Videos.fromJson(itemCount[i]));
    }
    return listItens;
  }

  Future<Map> getOneVideo({
    required String id,
    required String? token,
  }) async {
    var response = await client.get(
      Uri.parse('${url.toString()}/videos/$id'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        'ngrok-skip-browser-warning': "true"
      },
    );
    var itens = json.decode(response.body);
    return itens;
  }

  Future<List<ProfilesModel>> getEnterpriseProfiles({
    required String? token,
    required String? id,
  }) async {
    List<ProfilesModel> listItens = [];
    var response = await client.get(
      Uri.parse('${url.toString()}/profiles?enterprise.id_eq=$id'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    var body = jsonDecode(response.body);
    var itemCount = body;
    for (var i = 0; i < itemCount.length; i++) {
      listItens.add(ProfilesModel.fromJson(itemCount[i]));
    }
    return listItens;
  }

  Future<Map> getOneCategory({
    required String id,
    required String? token,
  }) async {
    var response = await client.get(
      Uri.parse('${url.toString()}/categories/$id'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        'ngrok-skip-browser-warning': "true"
      },
    );
    var itens = json.decode(response.body);
    return itens;
  }

  Future<List<CategoryModel>> getCategories({
    required String? token,
  }) async {
    List<CategoryModel> listItens = [];
    var response = await client.get(
      Uri.parse('${url.toString()}/categories'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        'ngrok-skip-browser-warning': "true"
      },
    );
    var body = jsonDecode(response.body);
    var itemCount = body;
    for (var i = 0; i < itemCount.length; i++) {
      listItens.add(CategoryModel.fromJson(itemCount[i]));
    }
    return listItens;
  }

  Future<List<CoursesModel>> getOneCategoryCourse({
    required String? token,
    required String? id,
  }) async {
    List<CoursesModel> listItens = [];
    var response = await client.get(
      Uri.parse('${url.toString()}/categories/$id'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        "ngrok-skip-browser-warning": "true"
      },
    );
    var body = jsonDecode(response.body);
    var itemCount = body['courses'];
    for (var i = 0; i < itemCount.length; i++) {
      listItens.add(CoursesModel.fromJson(itemCount[i]));
    }
    return listItens;
  }

  Future<Map> getQrCodeLocalStore({
    required String id,
    required String? token,
  }) async {
    var response = await client.get(
      Uri.parse('${url.toString()}/local-stores/$id/qrcode'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        'ngrok-skip-browser-warning': "true"
      },
    );
    var itens = json.decode(response.body);
    return itens;
  }

  //${url.toString()}/posts?title_contains=$query&chunk.id_eq=$chunkId

  Future<List<ProfilesModel>> getProfiles({required String? token}) async {
    List<ProfilesModel> listItens = [];
    var response = await client.get(
      Uri.parse('${url.toString()}/profiles'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        'ngrok-skip-browser-warning': "true"
      },
    );
    var body = jsonDecode(response.body);
    var itemCount = body;
    for (var i = 0; i < itemCount.length; i++) {
      listItens.add(ProfilesModel.fromJson(itemCount[i]));
    }
    return listItens;
  }

  Future<List<Vacancies>> getVacancies({
    required String? token,
  }) async {
    List<Vacancies> listItens = [];
    var response = await client.get(
      Uri.parse('${url.toString()}/vacancies'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        "ngrok-skip-browser-warning": "true"
      },
    );
    var body = jsonDecode(response.body);
    var itemCount = body;
    for (var i = 0; i < itemCount.length; i++) {
      listItens.add(Vacancies.fromJson(itemCount[i]));
    }
    return listItens;
  }

  Future<Map> getOnevacancie({
    required String id,
    required String? token,
  }) async {
    var response = await client.get(
      Uri.parse('${url.toString()}/vacancies/$id'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        'ngrok-skip-browser-warning': "true"
      },
    );
    var itens = json.decode(response.body);
    return itens;
  }

  Future<dynamic> putCadidateVacancie({
    required String token,
    required String id,
    required String profileId,
  }) async {
    var body = {
      "candidate": [profileId],
    };
    var response = await client.put(
      Uri.parse('${url.toString()}/vacancies/$id'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        'ngrok-skip-browser-warning': "true"
      },
      body: jsonEncode(body),
    );
    return response;
  }
}
