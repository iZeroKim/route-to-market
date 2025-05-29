import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../visits.dart';

abstract class AddVisitState {}

class AddVisitInitial extends AddVisitState {}

class AddVisitLoading extends AddVisitState {}

class AddVisitSuccess extends AddVisitState {}

class AddVisitError extends AddVisitState {
  final String message;
  AddVisitError({required this.message});
}


class AddVisitCubit extends Cubit<AddVisitState> {
  final AddVisitUseCase addVisitUseCase;

  AddVisitCubit({
    required this.addVisitUseCase,
  }) : super(AddVisitInitial());

  Future<void> addVisit(Visit visit) async {
    emit(AddVisitLoading());
    try {
      await addVisitUseCase.call(visit);
      emit(AddVisitSuccess());
    } catch (e) {
      emit(AddVisitError(message: e.toString()));
    }
  }
}