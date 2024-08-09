import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:testflutterapp/user_profile/user_profile_repository.dart';
import 'package:testflutterapp/user_profile/user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  final _userProfileRepository = UserProfileRepository();
  UserProfileCubit() : super(UserProfileInitial());

  Future<void> getWatchlist() async {
    try {
      emit(UserProfileLoading());
      final res = await _userProfileRepository.getWatchlist();

      if (res["page"] != null) {
        emit(WatchListSuccess(data: res));
      } else {
        emit(WatchListFailed(msg: "error"));
      }
    } catch (e) {
      emit(WatchListFailed(msg: e.toString()));
    }
  }

  Future<void> getFavorite() async {
    try {
      emit(UserProfileLoading());
      final res = await _userProfileRepository.getFavorite();

      if (res["page"] != null) {
        emit(FavoriteSuccess(data: res));
      } else {
        emit(FavoriteFailed(msg: "error"));
      }
    } catch (e) {
      emit(FavoriteFailed(msg: e.toString()));
    }
  }
}
