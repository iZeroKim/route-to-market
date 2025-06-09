import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:route_to_market_main/route_to_market_main.dart';
import 'package:visits/src/presentation/pages/statistics_card.dart';

import '../widgets/show_visit_details_dialog.dart';
import '../widgets/visits_details_dialog.dart';

class VisitsPage extends StatefulWidget {
  const VisitsPage({super.key});

  @override
  State<VisitsPage> createState() => _VisitsPageState();
}

class _VisitsPageState extends State<VisitsPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<VisitsCubit>().fetchVisits();
    context.read<CustomersCubit>().fetchCustomers();
    context.read<ActivitiesCubit>().fetchActivities();
    context.read<VisitStatisticsCubit>().getVisitStatistics();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final visitsState = context.watch<VisitsCubit>().state;
    final customersState = context.watch<CustomersCubit>().state;
    final activitiesState = context.watch<ActivitiesCubit>().state;
    final statsState = context.watch<VisitStatisticsCubit>().state;

    final isLoading = visitsState is VisitsLoading ||
        customersState is CustomersLoading ||
        activitiesState is ActivitiesLoading ||
        statsState is VisitStatisticsLoading;

    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.green,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        title: const Text(''),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Strings.statistics,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: AppConstants.smallPadding),
            const StatisticsCard(),
            SizedBox(height: AppConstants.bigPadding),
            Text(
              Strings.customerVisits,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: AppConstants.smallPadding),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(254, 254, 254, 1),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: BlocBuilder<VisitsCubit, VisitsState>(
                  builder: (context, state) {
                    if (state is VisitsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is VisitsLoaded) {
                      final visits = [...state.visits];
                      print('here');

                      visits.sort((a, b) {
                        final aDate = a.visitDate ?? DateTime(1970);
                        final bDate = b.visitDate ?? DateTime(1970);
                        return bDate.compareTo(aDate);
                      });

                      if (visits.isEmpty) {
                        return const Center(child: Text('No visits found.'));
                      }

                      return Scrollbar(
                        controller: _scrollController,
                        thumbVisibility: true,
                        thickness: 6,
                        radius: const Radius.circular(8),
                        child: ListView.builder(
                          controller: _scrollController,
                          itemCount: visits.length,
                          padding: const EdgeInsets.all(16),
                          itemBuilder: (context, index) {
                            final visit = visits[index];
                            final status = visit.status?.name ?? 'Unknown';
                            final date = visit.visitDate?.toLocal();
                            final dateString = date != null
                                ? '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}'
                                : 'No date';

                            Color statusColor;
                            IconData statusIcon;

                            switch (visit.status) {
                              case VisitStatus.completed:
                                statusColor = Colors.green;
                                statusIcon = Icons.check_circle_outline;
                                break;
                              case VisitStatus.pending:
                                statusColor = Colors.orange;
                                statusIcon = Icons.schedule;
                                break;
                              case VisitStatus.cancelled:
                                statusColor = Colors.redAccent;
                                statusIcon = Icons.cancel_outlined;
                                break;
                              default:
                                statusColor = Colors.grey;
                                statusIcon = Icons.help_outline;
                            }

                            final customersState =
                                context.read<CustomersCubit>().state;
                            String? customerName = '${visit.customerId}';

                            if (customersState is CustomersLoaded) {
                              final customer = customersState.customers.firstWhere(
                                    (c) => c.id == visit.customerId,
                                orElse: () => Customer(
                                  id: visit.customerId,
                                  name: '',
                                  createdAt: DateTime.now(),
                                ),
                              );
                              customerName = customer.name;
                            }

                            return InkWell(
                              onTap: () {
                                showVisitDetailsDialog(
                                  context: context,
                                  visit: visit,
                                  customerName: customerName ?? '',
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.03),
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    )
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: statusColor.withOpacity(0.1),
                                      child: Icon(statusIcon, color: statusColor),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            customerName.isNotEmpty
                                                ? customerName
                                                : 'Customer ${visit.customerId}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            dateString,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Activities ${visit.activitiesDone?.length ?? 0}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else if (state is VisitsError) {
                      return Center(child: Text(state.message));
                    }

                    return const Center(child: Text('Welcome to Visits Tracker'));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
