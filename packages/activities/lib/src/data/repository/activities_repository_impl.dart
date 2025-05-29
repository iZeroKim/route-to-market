import 'dart:convert';

import 'package:activities/src/domain/repositories/activities_repository.dart';
import 'package:route_to_market_main/route_to_market_main.dart';

class ActivityRepositoryImpl extends ActivitiesRepository{
  final ApiClient _apiClient;

  ActivityRepositoryImpl({required ApiClient apiClient}) : _apiClient = apiClient;
  @override
  Future<List<Activity>> fetchActivities() async {
    final response = await _apiClient.get('/activities');
    final List<dynamic> body = json.decode(response.body);
    return body.map((dynamic item) => ActivityModel.fromJson(item).toEntity()).toList();

  }
}