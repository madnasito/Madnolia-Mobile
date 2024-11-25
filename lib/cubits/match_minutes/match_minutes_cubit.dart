import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'match_minutes_state.dart';

class MatchMinutesCubit extends Cubit<MatchMinutesState> {
  MatchMinutesCubit({int minutes = 30}) : super(MatchMinutesState(minutes: minutes));

  void updateMinutes(int minutes){
    emit(MatchMinutesState(minutes: minutes));
  }

  void restoreMinutes(){
    emit(const MatchMinutesState(minutes: 30));
  }
}
