import '../entities/activity.dart';
import '../repositories/activities_repository.dart';

class GetActivitiesUseCase {
  final ActivitiesRepository repository;
  GetActivitiesUseCase({required this.repository});
  Future<List<Activity>> call() => repository.fetchActivities();
}