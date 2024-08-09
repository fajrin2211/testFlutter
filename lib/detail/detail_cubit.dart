import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testflutterapp/detail/detail_state.dart';

import 'package:testflutterapp/detail/detail_repository.dart';

class DetailCubit extends Cubit<DetailState> {
  final _detailRepository = DetailRepository();
  DetailCubit() : super(DetailInitial());

  Future<void> getDetail(id) async {
    try {
      emit(DetailLoading());
      final res = await _detailRepository.getDetail(id);

      if (res.id != null) {
        emit(DetailSuccess(data: res));
      } else {
        emit(DetailFailed(msg: "error"));
      }
    } catch (e) {
      emit(DetailFailed(msg: e.toString()));
    }
  }

  Future<void> getSimiliar(id) async {
    try {
      emit(DetailLoading());
      final res = await _detailRepository.getSimiliar(id);

      if (res["page"] != null) {
        emit(SimiliarSuccess(data: res["results"]));
      } else {
        emit(SimiliarFailed(msg: "error"));
      }
    } catch (e) {
      emit(SimiliarFailed(msg: e.toString()));
    }
  }
}
