import 'package:checklist/model/selectModel.dart';
import 'package:checklist/repositories/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../main.dart';

class GetModelBloc extends Bloc<GetModelBlocEvent, GetModelBlocState> {
  GetModelBloc(GetModelBlocState initialState) : super(GetModelBlocStateLoading());

  @override
  Stream<GetModelBlocState> mapEventToState(GetModelBlocEvent event) async* {
    if (event is GetModelBlocGetEvent) {
      List<selectModel> checklists = await getIt.get<Repository>().selectModelRepository!.get(description: event.description);

      yield GetModelBlocStateLoaded(checklists);
    } else {
      yield GetModelBlocStateLoading();
    }
  }
}

abstract class GetModelBlocEvent {}

class GetModelBlocGetEvent extends GetModelBlocEvent {
  GetModelBlocGetEvent({required this.description});
  final String description;
}

class GetModelBlocRefreshEvent extends GetModelBlocEvent {}

abstract class GetModelBlocState {}

class GetModelBlocStateLoading extends GetModelBlocState {}

class GetModelBlocStateLoaded extends GetModelBlocState {
  GetModelBlocStateLoaded(this.models);
  final List<selectModel> models;
}
