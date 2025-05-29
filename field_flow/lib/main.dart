import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:route_to_market_main/route_to_market_main.dart';

import 'core/theme/theme.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  final client = http.Client();
  final apiKey = dotenv.env['API_KEY'] ?? '';
  final headers= {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $apiKey',
    'apiKey': apiKey
  };
  final apiClient = ApiClient(client: client, headers: headers, baseUrl: AppConstants.baseUrl);

  final visitRepository = VisitRepositoryImpl(client: client, headers: headers, baseUrl: AppConstants.baseUrl);
  final customerRepository = CustomerRepositoryImpl(apiClient: apiClient);
  final activityRepository = ActivityRepositoryImpl(apiClient: apiClient);



  runApp(MyApp(
      getActivitiesUseCase: GetActivitiesUseCase(repository: activityRepository),
      getVisitsUseCase: GetVisitsUseCase(repository: visitRepository),
      getCustomersUseCase: GetCustomersUseCase(repository: customerRepository),
    addVisitUseCase: AddVisitUseCase(repository: visitRepository),
    getVisitStatisticsUseCase: GetVisitStatisticsUseCase(repository: visitRepository),
    getVisitStatisticsByCustomerUseCase: GetVisitStatisticsByCustomerUseCase(repository: visitRepository),
  ));
}

class MyApp extends StatelessWidget {
  final GetVisitsUseCase getVisitsUseCase;
  final GetCustomersUseCase getCustomersUseCase;
  final GetActivitiesUseCase getActivitiesUseCase;
  final AddVisitUseCase addVisitUseCase;
  final GetVisitStatisticsUseCase getVisitStatisticsUseCase;
  final GetVisitStatisticsByCustomerUseCase getVisitStatisticsByCustomerUseCase;
  const MyApp({
    super.key,
    required this.getVisitsUseCase,
    required this.getCustomersUseCase,
    required this.getActivitiesUseCase,
    required this.addVisitUseCase,
    required this.getVisitStatisticsUseCase,
    required this.getVisitStatisticsByCustomerUseCase
  });


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Route to Market app',
      debugShowCheckedModeBanner: false,
      theme: CustomThemeData.getThemeData(),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => VisitsCubit(getVisitsUseCase: getVisitsUseCase)),
          BlocProvider(create: (context) => CustomersCubit(getCustomersUseCase: getCustomersUseCase)),
          BlocProvider(create: (context) => ActivitiesCubit(getActivitiesUseCase: getActivitiesUseCase)),
          BlocProvider(create: (context) => AddVisitCubit(addVisitUseCase: addVisitUseCase)),
          BlocProvider(create: (context) => VisitStatisticsCubit(getVisitStatisticsUseCase: getVisitStatisticsUseCase)),
          BlocProvider(create: (context) => VisitStatisticsByCustomerCubit(getVisitStatisticsByCustomerUseCase: getVisitStatisticsByCustomerUseCase)),
        ],

        child: const VisitsPage(),
      ),
    );
  }
}

