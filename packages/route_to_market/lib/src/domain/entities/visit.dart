import 'package:equatable/equatable.dart';
import 'package:route_to_market/src/domain/entities/visit_status.dart';


class Visit extends Equatable {
  final int id;
  final int customerId;
  final DateTime? visitDate;
  final VisitStatus? status;
  final String? location;
  final String? notes;
  final List<int>? activitiesDone;
  final DateTime? createdAt;

  const Visit({
    required this.id,
    required this.customerId,
    required this.visitDate,
    required this.status,
    required this.location,
    required this.notes,
    required this.activitiesDone,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    customerId,
    visitDate,
    status,
    location,
    notes,
    activitiesDone,
    createdAt,
  ];
}
