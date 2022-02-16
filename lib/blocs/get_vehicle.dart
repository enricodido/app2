import 'package:checklist/model/selectModel.dart';
import 'package:checklist/model/vehicle.dart';
import 'package:checklist/repositories/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../main.dart';

class GetVehicleBloc extends Bloc<GetVehicleBlocEvent, GetVehicleBlocState> {
  GetVehicleBloc(GetVehicleBlocState initialState) : super(GetVehicleBlocStateLoading());

  @override
  Stream<GetVehicleBlocState> mapEventToState(GetVehicleBlocEvent event) async* {
    if (event is GetVehicleBlocGetEvent) {
      List<Vehicle> vehicles = await getIt.get<Repository>().vehicleRepository!.get();
      Vehicle selectedVehicle = await getIt.get<Repository>().vehicleRepository!.getSingle(checklist_id: event.checklist_id);
      yield GetVehicleBlocStateLoaded(vehicles, selectedVehicle);
    } else {
      yield GetVehicleBlocStateLoading();
    }
  }
}

abstract class GetVehicleBlocEvent {}

class GetVehicleBlocGetEvent extends GetVehicleBlocEvent {
  GetVehicleBlocGetEvent({required this.checklist_id});
  final String checklist_id;
}

class GetVehicleBlocRefreshEvent extends GetVehicleBlocEvent {}

abstract class GetVehicleBlocState {}

class GetVehicleBlocStateLoading extends GetVehicleBlocState {}

class GetVehicleBlocStateLoaded extends GetVehicleBlocState {
  GetVehicleBlocStateLoaded(this.vehicles, this.selectedVehicle);
  final List<Vehicle> vehicles;
  final Vehicle selectedVehicle;
}
