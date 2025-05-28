import '../entities/visit.dart';
import '../entities/visit_status.dart';

abstract class VisitRepository {
  Future<List<Visit>> getVisits({
    String? searchQuery,
    VisitStatus? statusFilter,
    DateTime? startDate,
    DateTime? endDate,
  });

  Future<void> addVisit(Visit visit);

  Future<void> updateVisit(Visit visit);

  Future<void> deleteVisit(int id);

  Future<int> getVisitCount({VisitStatus? status});
}
