import 'package:visits/visits.dart';

class VisitModel {
  final int id;
  final int customerId;
  final DateTime? visitDate;
  final VisitStatus? status;
  final String? location;
  final String? notes;
  final List<int>? activitiesDone;
  final DateTime? createdAt;

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
    print( 'JSON: ${json['activities_done']}');
    List<int> activitiesDone =json['activities_done'] == null ? [] : json['activities_done'].forEach((element) {
      print('element: $element');
      try {
        int.parse(element.toString());
        print('parsed: $element');
      } catch (e) {
        print('error: $e');
      }
    })?.toList() ?? []; 
   
    
    return VisitModel(
      id: json['id'] as int,
      customerId: json['customer_id'] as int,
      visitDate:  json['visit_date'] == null ? null : DateTime.parse(json['visit_date'] as String),
      status: VisitStatusExtension.fromApiString(json['status'] as String),
      location: json['location'] as String?,
      notes: json['notes'] as String?,
      activitiesDone: activitiesDone,
      createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer_id': customerId,
      'visit_date': visitDate?.toIso8601String(),
      'status': status?.toApiString(),
      'location': location,
      'notes': notes,
      'activities_done': activitiesDone?.map((e) => e.toString()).toList(),
      'created_at': createdAt?.toIso8601String(),
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
