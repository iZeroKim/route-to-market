import '../../../visits.dart';
import '../repositories/visit_repository.dart';

class GetVisitStatisticsUseCase {
  final VisitRepository repository;
  GetVisitStatisticsUseCase({required this.repository});

  Future<Map<VisitStatus, int>> call() {
  return repository.getVisitStatistics();
}
}