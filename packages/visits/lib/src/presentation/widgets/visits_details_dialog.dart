import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:route_to_market_main/route_to_market_main.dart';


class VisitDetailsDialog extends StatelessWidget {
  final Visit visit;
  final String customerName;

  const VisitDetailsDialog({
    super.key,
    required this.visit,
    required this.customerName,
  });

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'missed':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = visit.status?.name ?? 'Unknown';
    final date = visit.visitDate?.toLocal();
    final dateString = date != null
        ? '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}'
        : 'No date';

    return BlocBuilder<ActivitiesCubit, ActivitiesState>(
      builder: (context, state) {
        if (state is ActivitiesLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.green),
          );
        }

        if (state is ActivitiesError) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(state.message),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ],
          );
        }

        if (state is ActivitiesLoaded) {
          final activities = state.activities;

          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            insetPadding: const EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 600),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(Icons.close, size: 24, color: Colors.black),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                    Text(
                      'Visit Details',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Icon(Icons.person_outline, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(customerName, style: Theme.of(context).textTheme.titleMedium),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Chip(
                          label: Text(
                            status.toUpperCase(),
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          backgroundColor: _statusColor(status),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            const Icon(Icons.calendar_today_outlined, size: 18),
                            const SizedBox(width: 4),
                            Text(dateString, style: Theme.of(context).textTheme.bodyMedium),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Divider(),
                    if(visit.notes != null && visit.notes!.isNotEmpty)...[
                      Text(
                        'Notes',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 10),
                    Text( '${visit.notes}' ),
                    const SizedBox(height: 24),
                    const Divider(),
                    ],
                    Text(
                      'Activities done',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 12),
                    if (visit.activitiesDone != null && visit.activitiesDone!.isNotEmpty)
                      Flexible(
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: visit.activitiesDone!.length,
                          itemBuilder: (context, index) {
                            final activityId = visit.activitiesDone![index];
                            final activity = activities.firstWhere(
                                  (a) => a.id == activityId,
                              orElse: () => ActivityModel(
                                id: activityId,
                                description: 'Unknown activity',
                                createdAt: DateTime.now(),
                              ),
                            );
                            return ListTile(
                              dense: true,
                              contentPadding: EdgeInsets.zero,
                              leading: const Icon(Icons.check_circle_outline, color: Colors.green),
                              title: Text(activity.description ?? 'Unnamed activity'),
                            );
                          },
                        ),
                      )
                    else
                      const Text('No activities recorded for this visit.'),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

