import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:route_to_market_main/route_to_market_main.dart';
import 'package:visits/src/presentation/pages/statistics_card.dart';

class VisitsPage extends StatefulWidget {
  const VisitsPage({super.key});

  @override
  State<VisitsPage> createState() => _VisitsPageState();
}

class _VisitsPageState extends State<VisitsPage> {
  @override
  void initState() {
    super.initState();
    context.read<VisitsCubit>().fetchVisits();
    context.read<CustomersCubit>().fetchCustomers();
    context.read<ActivitiesCubit>().fetchActivities();
    context.read<VisitStatisticsCubit>().getVisitStatistics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(DateTime.now().toString()), elevation: 0,),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Customer Visits', style: Theme.of(context).textTheme.titleLarge,),
            SizedBox(height: 20,),
            StatisticsCard(),

            // cards

            Text(Strings.customersDropdownTitle),
            CustomersDropdown(),
            const Divider(),
            Text(Strings.activitiesDropdownTitle),
            ActivitiesDropdown(),
            const Divider(),
            Text(Strings.visitsListTitle),
            Expanded(
              child: BlocBuilder<VisitsCubit, VisitsState>(
                builder: (context, state) {
                  if (state is VisitsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is VisitsLoaded) {
                    if (state.visits.isEmpty) {
                      return const Center(child: Text('No visits found.'));
                    }

                    return ListView.builder(
                      itemCount: state.visits.length,
                      itemBuilder: (context, index) {
                        final visit = state.visits[index];
                        return ListTile(
                          title: Text('Visit to Customer ${visit.customerId}'),
                          subtitle: Text(
                            '${visit.status?.name} on ${visit.visitDate?.toLocal()}',
                          ),
                        );
                      },
                    );
                  } else if (state is VisitsError) {
                    return Center(child: Text(state.message));
                  }

                  return const Center(child: Text('Welcome to Visits Tracker'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}



