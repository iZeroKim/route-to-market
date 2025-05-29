enum VisitStatus {
  completed,
  pending,
  cancelled,
}

extension VisitStatusExtension on VisitStatus {
  String toApiString() {
    switch (this) {
      case VisitStatus.completed:
        return 'Completed';
      case VisitStatus.pending:
        return 'Pending';
      case VisitStatus.cancelled:
        return 'Cancelled';

    }
  }

  static VisitStatus fromApiString(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return VisitStatus.completed;
      case 'pending':
        return VisitStatus.pending;
      case 'cancelled':
        return VisitStatus.cancelled;
      default:
        throw ArgumentError('Unknown visit status: $status');
    }
  }
}
