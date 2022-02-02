import 'package:checklist/model/text.dart';
import 'package:checklist/repositories/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:checklist/repositories/text.dart';
import '../main.dart';

class GetTextBloc extends Bloc<GetTextBlocEvent, GetTextBlocState> {
  GetTextBloc(GetTextBlocState initialState) : super(GetTextBlocStateLoading());

  @override
  Stream<GetTextBlocState> mapEventToState(GetTextBlocEvent event) async* {
    if (event is GetTextBlocGetEvent) {
      List<Text> lists = await getIt.get<Repository>().textRepository!.get(item_id: event.item_id);

      yield GetTextBlocStateLoaded(lists);
    } else {
      yield GetTextBlocStateLoading();
    }
  }
}

abstract class GetTextBlocEvent {}

class GetTextBlocGetEvent extends GetTextBlocEvent {
  GetTextBlocGetEvent({required this.item_id});
  final String item_id;
}

class GetTextBlocRefreshEvent extends GetTextBlocEvent {}

abstract class GetTextBlocState {}

class GetTextBlocStateLoading extends GetTextBlocState {}

class GetTextBlocStateLoaded extends GetTextBlocState {
  GetTextBlocStateLoaded(this.texts);
  final List<Text> texts;
}
