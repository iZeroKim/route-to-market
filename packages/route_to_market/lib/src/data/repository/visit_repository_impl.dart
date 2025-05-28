import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:route_to_market/src/domain/entities/visit.dart';

import 'package:route_to_market/src/domain/entities/visit_status.dart';

import '../../core/exceptions.dart';
import '../../domain/repositories/visit_repository.dart';

import 'package:http/http.dart' as http;

import '../models/visit_model.dart';

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

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return response;
      } else if (response.statusCode == 404) {
        throw NotFoundException();
      } else {
        throw ApiException(response.body, statusCode: response.statusCode);
      }
    } on http.ClientException catch (e) {
      throw NetworkException(e.message);
    } catch (e, s) {
      throw AppException('Unexpected error: $e', s);
    }
  }


  @override
  Future<void> addVisit(Visit visit) {
    // TODO: implement addVisit
    throw UnimplementedError();
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
  Future<Map<VisitStatus, int>> getVisitStatistics() {
    // TODO: implement getVisitStatistics
    throw UnimplementedError();
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
    try {
      body.map((e) => VisitModel.fromJson(e)).map((e) => e.toEntity()).toList();
    } catch (e, s) {
      if (kDebugMode) {
        print("Error parsing response: $e $s");
      }
    }
    return body.map((e) => VisitModel.fromJson(e)).map((e) => e.toEntity()).toList();
  }

  @override
  Future<void> updateVisit(Visit visit) {
    // TODO: implement updateVisit
    throw UnimplementedError();
  }

}