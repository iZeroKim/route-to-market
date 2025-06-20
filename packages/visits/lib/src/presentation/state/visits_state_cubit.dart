import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:visits/visits.dart';

abstract class VisitsState extends Equatable {
  @override
  List<Object> get props => [];
}

class VisitsInitial extends VisitsState {}

class VisitsLoading extends VisitsState {}

class VisitsLoaded extends VisitsState {
  final List<Visit> visits;
  VisitsLoaded({required this.visits});

  @override
  List<Object> get props => [visits];
}

class VisitsError extends VisitsState {
  final String message;
  VisitsError({required this.message});

  @override
  List<Object> get props => [message];
}


class VisitsCubit extends Cubit<VisitsState> {
  final GetVisitsUseCase getVisitsUseCase;


  VisitsCubit({required this.getVisitsUseCase}) : super(VisitsInitial());

  void fetchVisits({
    String? searchQuery,
    VisitStatus? statusFilter,
    DateTime? startDate,
    DateTime? endDate
}) async {
    emit(VisitsLoading());
    try {
      final visits = await getVisitsUseCase(
        searchQuery: searchQuery,
        statusFilter: statusFilter,
        startDate: startDate,
        endDate: endDate
      );
      emit(VisitsLoaded(visits: visits));
    } catch (e) {
      print('Error fetching visits: $e');
      emit(VisitsError(message: e.toString()));
    }
  }


}