import 'package:equatable/equatable.dart';
import 'package:testflutterapp/detail/detail_movie_model.dart';
import 'package:testflutterapp/detail/similiar_movie_model.dart';

abstract class DetailState extends Equatable {
  const DetailState();

  @override
  List<Object> get props => [];
}

class DetailInitial extends DetailState {}

class DetailLoading extends DetailState {
  @override
  String toString() => "Detail Loading...";
}

class DetailSuccess extends DetailState {
  final DetailMovieModel data;

  const DetailSuccess({required this.data});
}

class DetailFailed extends DetailState {
  final String msg;
  @override
  String toString() => "error $msg";
  const DetailFailed({required this.msg});
}

class SimiliarSuccess extends DetailState {
  final dynamic data;

  const SimiliarSuccess({required this.data});
}

class SimiliarFailed extends DetailState {
  final String msg;
  @override
  String toString() => "error $msg";
  const SimiliarFailed({required this.msg});
}
