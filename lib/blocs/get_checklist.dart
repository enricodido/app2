import 'package:checklist/model/checklist.dart';
import 'package:checklist/model/selectModel.dart';
import 'package:checklist/repositories/checklistModel.dart';
import 'package:checklist/repositories/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../main.dart';

class GetChecklistBloc extends Bloc<GetChecklistBlocEvent, GetChecklistBlocState> {
  GetChecklistBloc(GetChecklistBlocState initialState) : super(GetChecklistBlocStateLoading());

  @override
  Stream<GetChecklistBlocState> mapEventToState(GetChecklistBlocEvent event) async* {
    if (event is GetChecklistBlocGetEvent) {
      List<ChecklistModel> checklists = await getIt.get<Repository>().checklistModelRepository!.get(description: event.description);

      yield GetChecklistBlocStateLoaded(checklists);
    } else {
      yield GetChecklistBlocStateLoading();
    }
  }
}

abstract class GetChecklistBlocEvent {}

class GetChecklistBlocGetEvent extends GetChecklistBlocEvent {
  GetChecklistBlocGetEvent({required this.description});
  final String description;
}

class GetChecklistBlocRefreshEvent extends GetChecklistBlocEvent {}

abstract class GetChecklistBlocState {}

class GetChecklistBlocStateLoading extends GetChecklistBlocState {}

class GetChecklistBlocStateLoaded extends GetChecklistBlocState {
  GetChecklistBlocStateLoaded(this.checklists);
  final List<ChecklistModel> checklists;
}
