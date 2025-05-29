import '../../../visits.dart';
import '../repositories/visit_repository.dart';

class GetVisitStatisticsByCustomerUseCase {
  final VisitRepository _repository;
  GetVisitStatisticsByCustomerUseCase(this._repository);

  Future<Map<VisitStatus, int>> call(int customerId) {
    return _repository.getVisitStatisticsByCustomer(customerId);
  }
}
