import 'package:equatable/equatable.dart';
import 'package:testflutterapp/home/now_playing_model.dart';
import 'package:testflutterapp/home/popular_model.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {
  @override
  String toString() => "Home Loading...";
}

class NowPlayingSuccess extends HomeState {
  final NowPlayingModel data;

  const NowPlayingSuccess({required this.data});
}

class NowPlayingFailed extends HomeState {
  final String msg;
  @override
  String toString() => "error $msg";
  const NowPlayingFailed({required this.msg});
}

class AddWatchListSuccess extends HomeState {
  final String msg;

  const AddWatchListSuccess({required this.msg});
}

class AddWatchListFailed extends HomeState {
  final String msg;
  @override
  String toString() => "error $msg";
  const AddWatchListFailed({required this.msg});
}

class AddFavoriteSuccess extends HomeState {
  final String msg;

  const AddFavoriteSuccess({required this.msg});
}

class AddFavoriteFailed extends HomeState {
  final String msg;
  @override
  String toString() => "error $msg";
  const AddFavoriteFailed({required this.msg});
}

class PopularSuccess extends HomeState {
  final PopularModel data;

  const PopularSuccess({required this.data});
}

class PopularFailed extends HomeState {
  final String msg;
  @override
  String toString() => "error $msg";
  const PopularFailed({required this.msg});
}
