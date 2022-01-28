import 'package:checklist/model/checklist.dart';
import 'package:checklist/repositories/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../main.dart';

class GetChecklistBloc extends Bloc<GetChecklistBlocEvent, GetChecklistBlocState> {
  GetChecklistBloc(GetChecklistBlocState initialState) : super(GetChecklistBlocStateLoading());

  @override
  Stream<GetChecklistBlocState> mapEventToState(GetChecklistBlocEvent event) async* {
    if (event is GetChecklistBlocGetEvent) {
      List<ChecklistModel> checklists = await getIt.get<Repository>().checklistModelRepository!.get(user_id: event.user_id);

      yield GetChecklistBlocStateLoaded(checklists);
    } else {
      yield GetChecklistBlocStateLoading();
    }
  }
}

abstract class GetChecklistBlocEvent {}

class GetChecklistBlocGetEvent extends GetChecklistBlocEvent {
  GetChecklistBlocGetEvent({required this.user_id});
  final String user_id;
}

class GetChecklistBlocRefreshEvent extends GetChecklistBlocEvent {}

abstract class GetChecklistBlocState {}

class GetChecklistBlocStateLoading extends GetChecklistBlocState {}

class GetChecklistBlocStateLoaded extends GetChecklistBlocState {
  GetChecklistBlocStateLoaded(this.checklists);
  final List<ChecklistModel> checklists;
}
