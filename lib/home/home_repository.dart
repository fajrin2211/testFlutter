import 'dart:convert';

import "package:http/http.dart" as http;
import 'package:testflutterapp/api_url.dart';
import 'package:testflutterapp/home/now_playing_model.dart';
import 'package:testflutterapp/home/popular_model.dart';

class HomeRepository {
  //repository to create api call
  //call the now playing api
  Future<NowPlayingModel> getNowPlaying() async {
    return Future.delayed(Duration(seconds: 1), () async {
      final response = await http.get(
          Uri.parse(ApiUrl.NOW_PLAYING + "?language=en-US&page=1"),
          headers: {
            "Authorization": ApiUrl.auth
          }).timeout(Duration(seconds: 30));
      if (response.statusCode == 200) {
        final dataResponse = json.decode(response.body);

        return NowPlayingModel.fromJson(dataResponse);
      } else {
        throw Exception("error fetching post" + response.statusCode.toString());
      }
    });
  }

  //call the popular api
  Future<PopularModel> getPopular() async {
    return Future.delayed(Duration(seconds: 1), () async {
      final response = await http
          .get(Uri.parse(ApiUrl.POPULAR + "?language=en-US&page=1"), headers: {
        "Authorization": ApiUrl.auth
      }).timeout(Duration(seconds: 30));
      if (response.statusCode == 200) {
        final dataResponse = json.decode(response.body);

        return PopularModel.fromJson(dataResponse);
      } else {
        throw Exception("error fetching post" + response.statusCode.toString());
      }
    });
  }

  //call the add watchlist api
  Future<dynamic> postWatchlist(body) async {
    return Future.delayed(Duration(seconds: 1), () async {
      final response = await http.post(
          Uri.parse(ApiUrl.ADD_TO + ApiUrl.ACCOUNT_ID + "/watchlist"),
          body: body,
          headers: {
            "Authorization": ApiUrl.auth
          }).timeout(Duration(seconds: 30));
      if (response.statusCode == 201) {
        final dataResponse = json.decode(response.body);

        return dataResponse;
      } else {
        throw Exception("error fetching post" + response.statusCode.toString());
      }
    });
  }

  //call the favorite api
  Future<dynamic> postFavorite(body) async {
    return Future.delayed(Duration(seconds: 1), () async {
      final response = await http.post(
          Uri.parse(ApiUrl.ADD_TO + ApiUrl.ACCOUNT_ID + "/favorite"),
          body: body,
          headers: {
            "Authorization": ApiUrl.auth
          }).timeout(Duration(seconds: 30));
      if (response.statusCode == 201) {
        final dataResponse = json.decode(response.body);

        return dataResponse;
      } else {
        throw Exception("error fetching post" + response.statusCode.toString());
      }
    });
  }
}
