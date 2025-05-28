import 'package:activities/src/domain/entities/activity.dart';

class ActivityModel extends Activity{
   ActivityModel({
    required super.id,
    required super.description,
    required super.createdAt});


   factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      id: json['id'],
      description: json['description'],
      createdAt: DateTime.parse(json['created_at']),
    );

  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'created_at': createdAt.toIso8601String(),
    };
  }

  Activity toEntity() {
    return Activity(
      id: id,
      description: description,
      createdAt: createdAt,
    );
  }

  factory ActivityModel.fromEntity(Activity entity) {
    return ActivityModel(
      id: entity.id,
      description: entity.description,
      createdAt: entity.createdAt,
    );
  }
}