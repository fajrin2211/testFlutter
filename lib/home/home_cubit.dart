import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:testflutterapp/home/home_repository.dart';
import 'package:testflutterapp/home/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  //define repository
  final _homeRepository = HomeRepository();
  HomeCubit() : super(HomeInitial());

  //combine the api call now playing repository and state event
  Future<void> getNowPlaying() async {
    try {
      emit(HomeLoading());
      final res = await _homeRepository.getNowPlaying();

      if (res.totalPages != 0) {
        emit(NowPlayingSuccess(data: res));
      } else {
        emit(NowPlayingFailed(msg: "error"));
      }
    } catch (e) {
      emit(NowPlayingFailed(msg: e.toString()));
    }
  }

  //combine the api call popular repository and state event
  Future<void> getPopular() async {
    try {
      emit(HomeLoading());
      final res = await _homeRepository.getPopular();

      if (res.totalPages != 0) {
        emit(PopularSuccess(data: res));
      } else {
        emit(PopularFailed(msg: "error"));
      }
    } catch (e) {
      emit(PopularFailed(msg: e.toString()));
    }
  }

  //combine the api call add wathclist repository and state event
  Future<void> postWatchlist(body) async {
    try {
      emit(HomeLoading());
      final res = await _homeRepository.postWatchlist(body);

      if (res["success"]) {
        emit(AddWatchListSuccess(msg: res["status_message"]));
      } else {
        emit(AddWatchListFailed(msg: res["status_message"]));
      }
    } catch (e) {
      emit(AddWatchListFailed(msg: e.toString()));
    }
  }

  //combine the api call add favorite repository and state event
  Future<void> postFavorite(body) async {
    try {
      emit(HomeLoading());
      final res = await _homeRepository.postFavorite(body);

      if (res["success"]) {
        emit(AddFavoriteSuccess(msg: res["status_message"]));
      } else {
        emit(AddFavoriteFailed(msg: res["status_message"]));
      }
    } catch (e) {
      emit(AddFavoriteFailed(msg: e.toString()));
    }
  }
}
