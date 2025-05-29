import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:visits/visits.dart';


import '../../../core/exceptions.dart';
import '../../../domain/repositories/visit_repository.dart';

import 'package:http/http.dart' as http;


class VisitRepositoryImpl implements VisitRepository {
  final http.Client _client;
  final String _baseUrl;
  final Map<String, String> _headers;

  VisitRepositoryImpl({
    required http.Client client,
    required String baseUrl,
    required Map<String, String> headers
  })  : _client = client,
        _baseUrl = baseUrl,
        _headers = headers;


  Future<http.Response> _safeRequest(Future<http.Response> Function() request) async {
    try {
      final response = await request();

      print(response);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return response;
      } else if (response.statusCode == 404) {
        throw NotFoundException();
      } else {
        print(response.body);
        throw ApiException(response.body, statusCode: response.statusCode);
      }
    } on http.ClientException catch (e) {
      throw NetworkException(e.message);
    } catch (e, s) {
      throw AppException('Unexpected error: $e', s);
    }
  }


  @override
  Future<void> addVisit(Visit visit) async {
    final uri = Uri.parse('$_baseUrl/visits');

    // TODO: if time implement return saved visit
    await _safeRequest(() => _client.post(uri, headers: _headers, body: jsonEncode(visit)));

  }

  @override
  Future<void> deleteVisit(int id) {
    // TODO: implement deleteVisit
    throw UnimplementedError();
  }

  @override
  Future<int> getVisitCount({VisitStatus? status}) {
    // TODO: implement getVisitCount
    throw UnimplementedError();
  }

  @override
  Future<Map<VisitStatus, int>> getVisitStatistics() async {
    final uri = Uri.parse('$_baseUrl/visits?select=status,count:id');
    final response = await _safeRequest(() => _client.get(uri, headers: _headers));
    print(response);
    final List<dynamic> body = json.decode(response.body);

    final result = <VisitStatus, int>{};
    for (final item in body) {
      print('item: $item status: ${item['status']}');
      VisitStatus.values.map((status) => print('status: ${status.toApiString()}'));
      print('Last');
      final status = VisitStatus.values.firstWhere((status) => status.toApiString() == item['status']);
      print('status: $status ${status.toApiString()}');
      print('result: $result');
      try {
        result[status] = item['count'] as int;
      } catch (e) {
        print('error: $e ${item['count']}');
      }
      result[status] = result[status] = item['count'] as int;
      ;

      print('result: $result');
    }
    return result;
  }

  @override
  Future<Map<VisitStatus, int>> getVisitStatisticsByCustomer(int customerId) async {
    final uri = Uri.parse('$_baseUrl/visits?elect=status,count:id&group=status&customer_id=eq.$customerId');
    final response = await _safeRequest(() => _client.get(uri, headers: _headers));
    print(response);
    final List<dynamic> body = json.decode(response.body);




    final result = <VisitStatus, int>{};
    for (final item in body) {
      final status = VisitStatus.values.firstWhere((status) => status.toApiString() == item['status']);
      result[status] = int.tryParse(item['count']) ?? 0;
    }
    return result;
  }
  @override
  Future<List<Visit>> getVisits({
    String? searchQuery, VisitStatus? statusFilter, DateTime? startDate, DateTime? endDate
  }) async {

    final queryParams = <String>[];
    if (searchQuery != null && searchQuery.isNotEmpty) {
      queryParams.add('or=(notes.ilike.*$searchQuery*,location.ilike.*$searchQuery*)');
    }
    if (statusFilter != null) {
      queryParams.add('status=eq.${statusFilter.toApiString()}');
    }
    if (startDate != null) {
      queryParams.add('start_date=gte.${startDate.toIso8601String()}');
    }
    if (endDate != null) {
      queryParams.add('end_date=lte.${endDate.toIso8601String()}');
    }
    queryParams.add('select=*');

    final uri = Uri.parse('$_baseUrl/visits?${queryParams.join('&')}');
    final response = await _safeRequest(() =>
        _client.get(uri, headers: _headers)
    );

    final List<dynamic> body = json.decode(response.body);

    if (kDebugMode) {
      print("body: $body");
    }

    return body.map((e) => VisitModel.fromJson(e)).map((e) => e.toEntity()).toList();
  }

  @override
  Future<void> updateVisit(Visit visit) {
    // TODO: implement updateVisit
    throw UnimplementedError();
  }

}