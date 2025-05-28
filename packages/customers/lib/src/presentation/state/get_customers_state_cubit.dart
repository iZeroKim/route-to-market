import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../customers.dart';

abstract class CustomersState extends Equatable {

  @override
  List<Object> get props => [];
}

class CustomersInitial extends CustomersState {}

class CustomersLoading extends CustomersState {}

class CustomersLoaded extends CustomersState {
  final List<Customer> customers;

  CustomersLoaded({required this.customers});

  @override
  List<Object> get props => [customers];
}

class CustomersError extends CustomersState {
  final String message;

  CustomersError({required this.message});

  @override
  List<Object> get props => [message];
}


class CustomersCubit extends Cubit<CustomersState>{
  final GetCustomersUseCase getCustomersUseCase;

  CustomersCubit({required  this.getCustomersUseCase}) : super(CustomersInitial());

  void fetchCustomers() async {
    emit(CustomersLoading());
    try {
      final customers = await getCustomersUseCase.call();
      emit(CustomersLoaded(customers: customers));
    } catch (e) {
      emit(CustomersError(message: e.toString()));
    }
  }

}