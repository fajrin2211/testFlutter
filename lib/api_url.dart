class ApiUrl {
  //BASE
  static const String baseUrl = "https://api.themoviedb.org/3/";

  //BASE IMAGE
  static const String baseImg = "https://image.tmdb.org/t/p/original";

  //auth
  static const String auth =
      "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5NTViYTgyZTQ1OGFiNjAxOGUzNDIxNmRhMDVhYWEzNSIsIm5iZiI6MTcyMjg2NzcwNC4yODkzNjcsInN1YiI6IjY2YjBkZTIwZDJmMzlkOTI1NjA5YjA2YyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.stlKn2F6xz0rmgmZjcALu2qrxDQ16ZJhnXKORQi8Xos";
  static const String api_key = "955ba82e458ab6018e34216da05aaa35";
  static const String ACCOUNT_ID = "21424674";
  //home
  static const String NOW_PLAYING = baseUrl + "movie/now_playing";
  static const String POPULAR = baseUrl + "movie/popular";
  static const String DETAIL_MOVIE = baseUrl + "movie/";
  static const String ADD_TO = baseUrl + "account/";
}
