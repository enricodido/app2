import 'package:checklist/model/time.dart';
import 'package:checklist/repositories/repository.dart';
import 'package:checklist/repositories/time.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../main.dart';

class TimeSlotBloc extends Bloc<TimeSlotBlocEvent, TimeSlotBlocState> {
  TimeSlotBloc(TimeSlotBlocState initialState) : super(TimeSlotBlocStateLoading());

  @override
  Stream<TimeSlotBlocState> mapEventToState(TimeSlotBlocEvent event) async* {
    if (event is TimeSlotBlocGetEvent) {
      List<TimeModel> slots = await getIt.get<Repository>().timeRepository!.get(date: event.date);
      yield TimeSlotBlocStateLoaded(slots);
    } else {
      yield TimeSlotBlocStateLoading();
    }
  }
}

abstract class TimeSlotBlocEvent {}

class TimeSlotBlocGetEvent extends TimeSlotBlocEvent {
    TimeSlotBlocGetEvent({required this.date});
    final String date;
}

class TimeSlotBlocRefreshEvent extends TimeSlotBlocEvent {}

abstract class TimeSlotBlocState {}

class TimeSlotBlocStateLoading extends TimeSlotBlocState {}

class TimeSlotBlocStateLoaded extends TimeSlotBlocState {
  TimeSlotBlocStateLoaded(this.slots);
  final List<TimeModel> slots;
}
