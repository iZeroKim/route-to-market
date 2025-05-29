import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../visits.dart';

abstract class VisitStatisticsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class VisitStatisticsInitial extends VisitStatisticsState {}

class VisitStatisticsLoading extends VisitStatisticsState {}

class VisitStatisticsSuccess extends VisitStatisticsState {
  final Map<VisitStatus, int> visits;
  VisitStatisticsSuccess({required this.visits});

  @override
  List<Object?> get props => [visits];
}


class VisitStatisticsError extends VisitStatisticsState {
  final String message;
  VisitStatisticsError({required this.message});
}


class VisitStatisticsCubit extends Cubit<VisitStatisticsState> {
  final  GetVisitStatisticsUseCase getVisitStatisticsUseCase;

  VisitStatisticsCubit({
    required this.getVisitStatisticsUseCase,
  }) : super(VisitStatisticsInitial());

  Future<void> getVisitStatistics() async {
    emit(VisitStatisticsLoading());
    try {
      final visits = await getVisitStatisticsUseCase.call();
      emit(VisitStatisticsSuccess(
        visits: visits
      ));
    } catch (e) {
      emit(VisitStatisticsError(message: e.toString()));
    }
  }
}