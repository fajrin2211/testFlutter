import 'dart:convert';

import "package:http/http.dart" as http;
import 'package:testflutterapp/api_url.dart';

class UserProfileRepository {
  //repository to create api call
  //call the watchlist api
  Future<dynamic> getWatchlist() async {
    return Future.delayed(Duration(seconds: 1), () async {
      final response = await http.get(
          Uri.parse(ApiUrl.ADD_TO + ApiUrl.ACCOUNT_ID + "/watchlist/movies"),
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

  //call the favorite api
  Future<dynamic> getFavorite() async {
    return Future.delayed(Duration(seconds: 1), () async {
      final response = await http.get(
          Uri.parse(ApiUrl.ADD_TO + ApiUrl.ACCOUNT_ID + "/favorite/movies"),
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
