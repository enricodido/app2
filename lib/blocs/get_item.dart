import 'package:checklist/model/item.dart';
import 'package:checklist/repositories/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../main.dart';

class GetItemBloc extends Bloc<GetItemBlocEvent, GetItemBlocState> {
  GetItemBloc(GetItemBlocState initialState) : super(GetItemBlocStateLoading());

  @override
  Stream<GetItemBlocState> mapEventToState(GetItemBlocEvent event) async* {
    if (event is GetItemBlocGetEvent) {
      List<Item> items = await getIt.get<Repository>().itemRepository!.get(section_id: event.section_id);

      yield GetItemBlocStateLoaded(items);
    } else {
      yield GetItemBlocStateLoading();
    }
  }
}

abstract class GetItemBlocEvent {}

class GetItemBlocGetEvent extends GetItemBlocEvent {
  GetItemBlocGetEvent({required this.section_id});
  final String section_id;
}

class GetItemBlocRefreshEvent extends GetItemBlocEvent {}

abstract class GetItemBlocState {}

class GetItemBlocStateLoading extends GetItemBlocState {}

class GetItemBlocStateLoaded extends GetItemBlocState {
  GetItemBlocStateLoaded(this.items);
  final List<Item> items;
}
