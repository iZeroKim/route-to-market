import 'dart:convert';
import 'package:route_to_market_main/route_to_market_main.dart';


import '../../domain/repositories/customer_repository.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  final ApiClient _apiClient;

  CustomerRepositoryImpl({required ApiClient apiClient} ): _apiClient = apiClient;

  @override
  Future<List<Customer>> getCustomers()  async {
    var response = await _apiClient.get('/customers');
    final List<dynamic> body = json.decode(response.body);
    return body.map((dynamic item) => CustomerModel.fromJson(item).toEntity()).toList();
  }




}