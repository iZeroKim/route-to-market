import 'package:customers/src/domain/repositories/customer_repository.dart';
import 'package:route_to_market_main/route_to_market_main.dart';

class GetCustomersUseCase{
  final CustomerRepository _repository;
  GetCustomersUseCase({required CustomerRepository repository}) : _repository = repository;

  Future<List<Customer>> call() => _repository.getCustomers();
}