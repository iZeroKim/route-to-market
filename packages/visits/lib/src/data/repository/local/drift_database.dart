import 'package:drift/drift.dart';

class Visits extends Table{
  IntColumn get id => integer().autoIncrement()();
  TextColumn get customerId => text()();
  TextColumn get notes => text()();
  TextColumn get location => text()();
  IntColumn get status => integer()();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime()();
}