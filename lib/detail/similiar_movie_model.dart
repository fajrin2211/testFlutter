// To parse this JSON data, do
//
//     final SimiliarMovieModel = SimiliarMovieModelFromJson(jsonString);

import 'dart:convert';

SimiliarMovieModel similiarMovieModelFromJson(String str) =>
    SimiliarMovieModel.fromJson(json.decode(str));

String similiarMovieModelToJson(SimiliarMovieModel data) =>
    json.encode(data.toJson());

class SimiliarMovieModel {
  int page;
  List<DataSimiliar> results;
  int totalPages;
  int totalResults;

  SimiliarMovieModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory SimiliarMovieModel.fromJson(Map<String, dynamic> json) =>
      SimiliarMovieModel(
        page: json["page"],
        results: List<DataSimiliar>.from(
            json["results"].map((x) => DataSimiliar.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

class DataSimiliar {
  bool adult;
  String? backdropPath;
  List<int> genreIds;
  int id;
  OriginalLanguage originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String? posterPath;
  DateTime releaseDate;
  String title;
  bool video;
  double voteAverage;
  int voteCount;

  DataSimiliar({
    required this.adult,
    this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory DataSimiliar.fromJson(Map<String, dynamic> json) => DataSimiliar(
        adult: json["adult"],
        backdropPath: json["backdrop_path"] != null
            ? json["backdrop_path"]
            : "https://placehold.co/600x400",
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalLanguage:
            originalLanguageValues.map[json["original_language"]]!,
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"] != null
            ? json["poster_path"]
            : "https://placehold.co/600x400",
        releaseDate: DateTime.parse(json["release_date"]),
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "original_language": originalLanguageValues.reverse[originalLanguage],
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "release_date":
            "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };
}

enum OriginalLanguage { EN, JA }

final originalLanguageValues =
    EnumValues({"en": OriginalLanguage.EN, "ja": OriginalLanguage.JA});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
