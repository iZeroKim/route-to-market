import 'package:field_flow/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:route_to_market/route_to_market.dart';
import 'package:http/http.dart' as http;

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  final client = http.Client();
  final apiKey = dotenv.env['API_KEY'] ?? '';
  final headers= {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $apiKey',
    'apiKey': apiKey
  };

  final visitRepository = VisitRepositoryImpl(client: client, headers: headers, baseUrl: AppConstants.baseUrl);


  runApp(MyApp(getVisitsUseCase: GetVisitsUseCase(repository: visitRepository),));
}

class MyApp extends StatelessWidget {
  final GetVisitsUseCase getVisitsUseCase;
  const MyApp({Key? key, required this.getVisitsUseCase}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Route to Market app',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => VisitsCubit(getVisitsUseCase: getVisitsUseCase),
        child: const VisitsPage(),
      ),
    );
  }
}

