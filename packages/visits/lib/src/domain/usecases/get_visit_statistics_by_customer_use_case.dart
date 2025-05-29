import '../../../visits.dart';
import '../repositories/visit_repository.dart';

class GetVisitStatisticsByCustomerUseCase {
  final VisitRepository repository;
  GetVisitStatisticsByCustomerUseCase({required this.repository});

  Future<Map<VisitStatus, int>> call(int customerId) {
    return repository.getVisitStatisticsByCustomer(customerId);
  }
}
