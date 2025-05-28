import 'package:route_to_market/src/domain/entities/visit.dart';
import 'package:route_to_market/src/domain/entities/visit_status.dart';

import '../repositories/visit_repository.dart';

class GetVisitsUseCase {
  final VisitRepository repository;
  GetVisitsUseCase({required this.repository});

  Future<List<Visit>> call({String? searchQuery, VisitStatus? statusFilter, DateTime? startDate, DateTime? endDate}){
    return repository.getVisits(
      searchQuery: searchQuery,
      statusFilter: statusFilter,
      startDate: startDate,
      endDate: endDate
    );
  }

}