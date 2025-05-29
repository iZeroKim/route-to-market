import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:route_to_market_main/route_to_market_main.dart';
import 'package:visits/src/presentation/widgets/visits_details_dialog.dart';


void showVisitDetailsDialog({
  required BuildContext context,
  required Visit visit,
  required String customerName,
}) {
  showGeneralDialog(
    context: context,
    barrierColor: Colors.black54,
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (_, __, ___) {
      return BlocProvider.value(
        value: context.read<ActivitiesCubit>(),
        child: VisitDetailsDialog(
          visit: visit,
          customerName: customerName,
        ),
      );
    },
  );
}
