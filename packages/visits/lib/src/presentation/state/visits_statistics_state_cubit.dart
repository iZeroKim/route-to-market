import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../visits.dart';

abstract class VisitStatisticsState {}

class VisitStatisticsInitial extends VisitStatisticsState {}

class VisitStatisticsLoading extends VisitStatisticsState {}

class VisitStatisticsSuccess extends VisitStatisticsState {}

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
      await getVisitStatisticsUseCase.call();
      emit(VisitStatisticsSuccess());
    } catch (e) {
      emit(VisitStatisticsError(message: e.toString()));
    }
  }
}