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

      yield GetVehicleBlocStateLoaded(vehicles);
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
  GetVehicleBlocStateLoaded(this.vehicles);
  final List<Vehicle> vehicles;

}
