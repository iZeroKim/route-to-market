import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/activity.dart';
import '../../domain/usecases/get_activities_use_case.dart';

abstract class ActivitiesState extends Equatable {
  const ActivitiesState();

  @override
  List<Object?> get props => [];
}

class ActivitiesInitial extends ActivitiesState {}

class ActivitiesLoading extends ActivitiesState {}

class ActivitiesLoaded extends ActivitiesState {
  final List<Activity> activities;

  const ActivitiesLoaded({required this.activities});

  @override
  List<Object?> get props => [activities];
}

class ActivitiesError extends ActivitiesState {
  final String message;

  const ActivitiesError({required this.message});

  @override
  List<Object?> get props => [message];
}


class ActivitiesCubit extends Cubit<ActivitiesState>{
  GetActivitiesUseCase getActivitiesUseCase;

  ActivitiesCubit(this.getActivitiesUseCase) : super(ActivitiesInitial());

  Future<void> fetchActivities() async {
    emit(ActivitiesLoading());
    try {
      final activities = await getActivitiesUseCase.call();
      emit(ActivitiesLoaded(activities: activities));
    } catch (e) {
      emit(ActivitiesError(message: e.toString()));
    }
  }

}