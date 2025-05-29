import '../../../visits.dart';
import '../repositories/visit_repository.dart';

class GetVisitStatisticsUseCase {
  final VisitRepository _repository;
  GetVisitStatisticsUseCase(this._repository);

  Future<Map<VisitStatus, int>> call() {
  return _repository.getVisitStatistics();
}
}