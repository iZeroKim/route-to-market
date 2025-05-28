import '../entities/customer.dart';

abstract class CustomerRepository {
  Future<List<Customer>> getCustomers();
}