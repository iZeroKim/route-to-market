import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:route_to_market_main/route_to_market_main.dart';

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


  runApp(MyApp(getVisitsUseCase: GetVisitsUseCase(repository: visitRepository), getCustomersUseCase: GetCustomersUseCase(repository: customerRepository)));
}

class MyApp extends StatelessWidget {
  final GetVisitsUseCase getVisitsUseCase;
  final GetCustomersUseCase getCustomersUseCase;
  const MyApp({super.key, required this.getVisitsUseCase, required this.getCustomersUseCase});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Route to Market app',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => VisitsCubit(getVisitsUseCase: getVisitsUseCase)),
          BlocProvider(create: (context) => CustomersCubit(getCustomersUseCase: getCustomersUseCase)),
        ],

        child: const VisitsPage(),
      ),
    );
  }
}

