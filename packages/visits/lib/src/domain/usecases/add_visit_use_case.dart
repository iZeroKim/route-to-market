import '../../../visits.dart';
import '../repositories/visit_repository.dart';

class AddVisitUseCase {
  final VisitRepository repository;

  AddVisitUseCase({required this.repository});

  Future<void> call(Visit visit) {
    return repository.addVisit(visit);
  }
}