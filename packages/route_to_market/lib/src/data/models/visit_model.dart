import 'package:route_to_market/src/domain/entities/visit.dart';
import 'package:route_to_market/src/domain/entities/visit_status.dart';

class VisitModel {
  final int id;
  final int customerId;
  final DateTime visitDate;
  final VisitStatus status;
  final String location;
  final String notes;
  final List<int> activitiesDone;
  final DateTime createdAt;

  const VisitModel({
    required this.id,
    required this.customerId,
    required this.visitDate,
    required this.status,
    required this.location,
    required this.notes,
    required this.activitiesDone,
    required this.createdAt,
  });

  factory VisitModel.fromJson(Map<String, dynamic> json) {
    return VisitModel(
      id: json['id'] as int,
      customerId: json['customer_id'] as int,
      visitDate: DateTime.parse(json['visit_date'] as String),
      status: VisitStatusExtension.fromApiString(json['status'] as String),
      location: json['location'] as String,
      notes: json['notes'] as String,
      activitiesDone: List<String>.from(json['activities_done'] ?? [])
          .map((e) => int.parse(e))
          .toList(),
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer_id': customerId,
      'visit_date': visitDate.toIso8601String(),
      'status': status.toApiString(),
      'location': location,
      'notes': notes,
      'activities_done': activitiesDone.map((e) => e.toString()).toList(),
      'created_at': createdAt.toIso8601String(),
    };
  }

  Visit toEntity() {
    return Visit(
      id: id,
      customerId: customerId,
      visitDate: visitDate,
      status: status,
      location: location,
      notes: notes,
      activitiesDone: activitiesDone,
      createdAt: createdAt,
    );
  }

  factory VisitModel.fromEntity(Visit visit) {
    return VisitModel(
      id: visit.id,
      customerId: visit.customerId,
      visitDate: visit.visitDate,
      status: visit.status,
      location: visit.location,
      notes: visit.notes,
      activitiesDone: visit.activitiesDone,
      createdAt: visit.createdAt,
    );
  }
}
