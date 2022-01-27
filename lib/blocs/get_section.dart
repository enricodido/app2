import 'package:checklist/model/section.dart';
import 'package:checklist/model/selectModel.dart';
import 'package:checklist/repositories/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../main.dart';

class GetSectionBloc extends Bloc<GetSectionBlocEvent, GetSectionBlocState> {
  GetSectionBloc(GetSectionBlocState initialState) : super(GetSectionBlocStateLoading());

  @override
  Stream<GetSectionBlocState> mapEventToState(GetSectionBlocEvent event) async* {
    if (event is GetSectionBlocGetEvent) {
      List<Section> sections = await getIt.get<Repository>().sectionRepository!.get(checklist_id: event.checklist_id);

      yield GetSectionBlocStateLoaded(sections);
    } else {
      yield GetSectionBlocStateLoading();
    }
  }
}

abstract class GetSectionBlocEvent {}

class GetSectionBlocGetEvent extends GetSectionBlocEvent {
  GetSectionBlocGetEvent({required this.checklist_id});
  final String checklist_id;
}

class GetSectionBlocRefreshEvent extends GetSectionBlocEvent {}

abstract class GetSectionBlocState {}

class GetSectionBlocStateLoading extends GetSectionBlocState {}

class GetSectionBlocStateLoaded extends GetSectionBlocState {
  GetSectionBlocStateLoaded(this.sections);
  final List<Section> sections;
}
