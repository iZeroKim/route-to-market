import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:route_to_market_main/route_to_market_main.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../domain/entities/chart_data.dart';

class StatisticsCard extends StatelessWidget {
  const StatisticsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VisitStatisticsCubit, VisitStatisticsState>(
      builder: (context, state) {
        if (state is VisitStatisticsLoading) {
          return SizedBox(height: 300,child:  Center(child: CircularProgressIndicator(color: Colors.green,)));
        } else if (state is VisitStatisticsError) {
          return Center(child: Text(state.message));
        } else if (state is VisitStatisticsSuccess) {
          final visits = state.visits;

          final int completed = visits[VisitStatus.completed] ?? 0;
          final int pending = visits[VisitStatus.pending] ?? 0;
          final int cancelled = visits[VisitStatus.cancelled] ?? 0;

          return IntrinsicHeight(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,


              child: Row(
               children: [
                 Expanded(
                   child: Container(
                     padding: const EdgeInsets.all(20),
                     decoration: BoxDecoration(
                       color: const Color(0xFFE3F9E5),
                       borderRadius: BorderRadius.circular(30),
                     ),
                     child: Stack(
                       children: [
                         const Positioned(
                           top: 0,
                           right: 0,
                           child: Icon(Icons.check_circle_outline_rounded, color: Colors.green),
                         ),
                         Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             // Chart
                             SizedBox(
                               height: 120,
                               width: 120,
                               child: Stack(
                                 children: [
                                   SfCircularChart(
                                     tooltipBehavior: TooltipBehavior(enable: true),
                                     series: <CircularSeries>[
                                       DoughnutSeries<ChartData, String>(
                                         dataSource: [
                                           ChartData(x: 'Completed', y: completed.toDouble(), color: Colors.green),
                                           ChartData(x: 'Others', y: (pending + cancelled).toDouble(), color: Colors.grey.shade300),
                                         ],
                                         xValueMapper: (ChartData data, _) => data.x,
                                         yValueMapper: (ChartData data, _) => data.y,
                                         pointColorMapper: (ChartData data, _) => data.color,
                                         cornerStyle: CornerStyle.bothCurve,
                                         innerRadius: '85%',
                                         radius: '100%',
                                       ),
                                     ],
                                   ),
                                   Center(
                                     child: Column(
                                       mainAxisAlignment: MainAxisAlignment.center,
                                       children: [
                                         const Text('Comp'),
                                         Text(
                                           '$completed',
                                           style: TextStyle(fontSize: 24, color: Colors.black87),
                                         ),
                                       ],
                                     ),
                                   ),
                                 ],
                               ),
                             ),
                             const SizedBox(height: 8),
                             const Text(
                               Strings.completed,
                               style: TextStyle(fontSize: 17, color: Colors.black87),
                             ),
                           ],
                         ),
                       ],
                     ),
                   ),
                 ),
                 SizedBox(width: 10,),
                 Expanded(
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.stretch,
                     children: [
                       Flexible(
                         fit: FlexFit.loose,
                         child: Container(
                           padding: const EdgeInsets.all(20),
                           decoration: BoxDecoration(
                             color: const Color(0xFFFFE6C9),
                             borderRadius: BorderRadius.circular(30),
                           ),
                           child: Stack(
                             children: [
                               const Positioned(
                                 top: 0,
                                 right: 0,
                                 child: Icon(Icons.schedule, color: Colors.orange),
                               ),
                               Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Text(
                                     '$pending',
                                     style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
                                   ),
                                   const SizedBox(height: 8),
                                   const Text(
                                     Strings.pending,
                                     style: TextStyle(fontSize: 17, color: Colors.black87),
                                   ),
                                 ],
                               ),
                             ],
                           ),
                         ),
                       ),
                       const SizedBox(height: 10),
                       Flexible(
                         fit: FlexFit.loose,
                         child: Container(
                           padding: const EdgeInsets.all(10),
                           decoration: BoxDecoration(
                             color: const Color(0xFFFFD6D6),
                             borderRadius: BorderRadius.circular(20),
                           ),
                           child: Stack(
                             children: [
                               const Positioned(
                                 top: 0,
                                 right: 0,
                                 child: Icon(Icons.cancel_outlined, color: Colors.redAccent),
                               ),
                               Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Text(
                                     '$cancelled',
                                     style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
                                   ),
                                   const SizedBox(height: 8),
                                   const Text(
                                     Strings.cancelled,
                                     style: TextStyle(fontSize: 17, color: Colors.black87),
                                   ),
                                 ],
                               ),
                             ],
                           ),
                         ),
                       ),
                     ],
                   ),
                 )
               ],
              ),
            ),
          );
        }

        return SizedBox(height: 300,child:  Center(child: CircularProgressIndicator(
          color: Colors.green,
        )));
      },
    );
  }
}
