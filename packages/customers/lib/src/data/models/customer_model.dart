
import '../../domain/entities/customer.dart';

class CustomerModel extends Customer {
  CustomerModel({required super.id, required super.name, required super.createdAt});

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'],
      name: json['name'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'created_at': createdAt.toIso8601String(),
    };
  }

  Customer toEntity() {
    return Customer(
      id: id,
      name: name,
      createdAt: createdAt,
    );
  }

  factory CustomerModel.fromEntity(Customer customer) {
    return CustomerModel(
      id: customer.id,
      name: customer.name,
      createdAt: customer.createdAt,
    );
  }

}