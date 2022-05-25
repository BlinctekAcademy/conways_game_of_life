import 'package:conways/cubits/tile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TileCubit extends Cubit<TileState> {
  TileCubit({bool alive = false}) : super(alive ? AliveTile() : DeadTile());

  void toggle() {
    emit(state is DeadTile ? AliveTile() : DeadTile());
  }

  void kill() {
    emit(DeadTile());
  }

  void reserect() {
    emit(AliveTile());
  }
}
