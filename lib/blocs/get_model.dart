import 'package:checklist/model/selectModel.dart';
import 'package:checklist/repositories/repository.dart';
import 'package:checklist/repositories/selectModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../main.dart';

class GetModelBloc extends Bloc<GetModelBlocEvent, GetModelBlocState> {
  GetModelBloc(GetModelBlocState initialState) : super(GetModelBlocStateLoading());

  @override
  Stream<GetModelBlocState> mapEventToState(GetModelBlocEvent event) async* {
    if (event is GetModelBlocGetEvent) {
      List<SelectModel> models = await getIt.get<Repository>().selectModelRepository!.get(status: event.status);

      yield GetModelBlocStateLoaded(models);
    } else {
      yield GetModelBlocStateLoading();
    }
  }
}

abstract class GetModelBlocEvent {}

class GetModelBlocGetEvent extends GetModelBlocEvent {
  GetModelBlocGetEvent({required this.status});
  final String status;
}

class GetModelBlocRefreshEvent extends GetModelBlocEvent {}

abstract class GetModelBlocState {}

class GetModelBlocStateLoading extends GetModelBlocState {}

class GetModelBlocStateLoaded extends GetModelBlocState {
  GetModelBlocStateLoaded(this.models);
  final List<SelectModel> models;
}
