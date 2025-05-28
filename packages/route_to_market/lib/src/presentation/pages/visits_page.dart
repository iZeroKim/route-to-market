import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../state/visits_state_cubit.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Customer Visits')),
      body: BlocBuilder<VisitsCubit, VisitsState>(
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
                    '${visit.status.name} on ${visit.visitDate.toLocal()}',
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
    );
  }
}
