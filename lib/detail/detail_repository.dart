import 'dart:convert';

import "package:http/http.dart" as http;
import 'package:testflutterapp/api_url.dart';
import 'package:testflutterapp/detail/detail_movie_model.dart';
import 'package:testflutterapp/detail/similiar_movie_model.dart';

class DetailRepository {
  //repository to create api call
  //call the detail api
  Future<DetailMovieModel> getDetail(id) async {
    return Future.delayed(Duration(seconds: 1), () async {
      print(id);
      final response = await http
          .get(Uri.parse(ApiUrl.DETAIL_MOVIE + id.toString()), headers: {
        "Authorization": ApiUrl.auth
      }).timeout(Duration(seconds: 30));
      if (response.statusCode == 200) {
        final dataResponse = json.decode(response.body);

        return DetailMovieModel.fromJson(dataResponse);
      } else {
        throw Exception("error fetching post" + response.statusCode.toString());
      }
    });
  }

  //call the similiar api
  Future<dynamic> getSimiliar(id) async {
    return Future.delayed(Duration(seconds: 1), () async {
      final response = await http.get(
          Uri.parse(ApiUrl.DETAIL_MOVIE + id.toString() + "/similar"),
          headers: {
            "Authorization": ApiUrl.auth
          }).timeout(Duration(seconds: 30));

      if (response.statusCode == 200) {
        final dataResponse = json.decode(response.body);
        return dataResponse;
      } else {
        throw Exception("error fetching post" + response.statusCode.toString());
      }
    });
  }
}
