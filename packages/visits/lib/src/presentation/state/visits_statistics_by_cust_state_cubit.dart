import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../visits.dart';

abstract class VisitStatisticsByCustomerState {}

class VisitStatisticsByCustomerInitial extends VisitStatisticsByCustomerState {}

class VisitStatisticsByCustomerLoading extends VisitStatisticsByCustomerState {}

class VisitStatisticsByCustomerSuccess extends VisitStatisticsByCustomerState {}

class VisitStatisticsByCustomerError extends VisitStatisticsByCustomerState {
  final String message;
  VisitStatisticsByCustomerError({required this.message});
}


class VisitStatisticsByCustomerCubit extends Cubit<VisitStatisticsByCustomerState> {
  final  GetVisitStatisticsByCustomerUseCase getVisitStatisticsByCustomerUseCase;

  VisitStatisticsByCustomerCubit({
    required this.getVisitStatisticsByCustomerUseCase,
  }) : super(VisitStatisticsByCustomerInitial());

  Future<void> getVisitStatisticsByCustomer(int customerId) async {
    emit(VisitStatisticsByCustomerLoading());
    try {
      await getVisitStatisticsByCustomerUseCase.call(customerId);
      emit(VisitStatisticsByCustomerSuccess());
    } catch (e) {
      emit(VisitStatisticsByCustomerError(message: e.toString()));
    }
  }
}