import 'package:activities/src/domain/entities/activity.dart';

abstract class ActivitiesRepository {
  Future<List<Activity>> fetchActivities();
}