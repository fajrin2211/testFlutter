import 'package:equatable/equatable.dart';

abstract class UserProfileState extends Equatable {
  const UserProfileState();

  @override
  List<Object> get props => [];
}

class UserProfileInitial extends UserProfileState {}

class UserProfileLoading extends UserProfileState {
  @override
  String toString() => "UserProfile Loading...";
}

class WatchListSuccess extends UserProfileState {
  final dynamic data;

  const WatchListSuccess({required this.data});
}

class WatchListFailed extends UserProfileState {
  final String msg;
  @override
  String toString() => "error $msg";
  const WatchListFailed({required this.msg});
}

class FavoriteSuccess extends UserProfileState {
  final dynamic data;

  const FavoriteSuccess({required this.data});
}

class FavoriteFailed extends UserProfileState {
  final String msg;
  @override
  String toString() => "error $msg";
  const FavoriteFailed({required this.msg});
}
