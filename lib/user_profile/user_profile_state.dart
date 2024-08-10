import 'package:equatable/equatable.dart';

abstract class UserProfileState extends Equatable {
  const UserProfileState();

  @override
  List<Object> get props => [];
}

//state initial
class UserProfileInitial extends UserProfileState {}

// state when loading
class UserProfileLoading extends UserProfileState {
  @override
  String toString() => "UserProfile Loading...";
}

//state when the watchlist api is done and success
class WatchListSuccess extends UserProfileState {
  final dynamic data;

  const WatchListSuccess({required this.data});
}

//state when the watchlist api is done and fail
class WatchListFailed extends UserProfileState {
  final String msg;
  @override
  String toString() => "error $msg";
  const WatchListFailed({required this.msg});
}

//state when the favorite api is done and success
class FavoriteSuccess extends UserProfileState {
  final dynamic data;

  const FavoriteSuccess({required this.data});
}

//state when the favorite api is done and fail
class FavoriteFailed extends UserProfileState {
  final String msg;
  @override
  String toString() => "error $msg";
  const FavoriteFailed({required this.msg});
}
