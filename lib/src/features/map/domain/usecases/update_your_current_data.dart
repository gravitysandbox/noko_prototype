import 'package:dartz/dartz.dart';
import 'package:noko_prototype/core/models/failure.dart';
import 'package:noko_prototype/core/models/usecase.dart';
import 'package:noko_prototype/core/utils/logger.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_bloc.dart';
import 'package:noko_prototype/src/features/map/domain/bloc/geo_events.dart';
import 'package:noko_prototype/src/features/map/domain/models/vehicle_route_data.dart';

class UpdateYourCurrentData
    implements UseCase<Either<Failure, void>, VehicleRouteData> {
  final GeoBloc bloc;

  const UpdateYourCurrentData({
    required this.bloc,
  });

  @override
  Future<Either<Failure, bool>> call(VehicleRouteData routeData) async {
    logPrint('UpdateYourCurrentData -> call(${routeData.nextBusStopID})');

    bloc.add(GeoUpdateYourCurrentData(
      yourData: routeData,
    ));

    return const Right(true);
  }
}
