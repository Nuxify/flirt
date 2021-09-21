import 'dart:convert';
import 'dart:io';
import 'package:flirt/infrastructures/api/api_response.dart';
import 'package:flirt/module/record/models/record_request.dart';
import 'package:flirt/module/record/models/record_response.dart';
import 'package:http/http.dart' as http;

class RecordRepository {
  final String _baseURL = 'flirt.nuxify.tech';
  final String _recordRepositoryURL = '/api/v1/record';

  Future<APIResponse<RecordResponse>> createRecordData(
      RecordRequest payload) async {
    try {
      final http.Response response =
          await http.post(Uri.https(_baseURL, _recordRepositoryURL),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(payload));

      final APIResponse<RecordResponse> result =
          APIResponse<RecordResponse>.fromJson(
              jsonDecode(response.body) as Map<String, dynamic>,
              (Object? data) =>
                  RecordResponse.fromJson(data! as Map<String, dynamic>));

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return result;
      }

      throw result;
    } on SocketException {
      final APIResponse<RecordResponse> error =
          APIResponse<RecordResponse>.fromJson(
              APIResponse.socketErrorResponse(),
              (Object? data) => RecordResponse.fromJson(<String, dynamic>{}));

      throw error;
    }
  }

  Future<APIResponse<RecordResponse>> fetchRecordData(String id) async {
    try {
      final http.Response response = await http.get(
        Uri.https(_baseURL, '$_recordRepositoryURL/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      final APIResponse<RecordResponse> result =
          APIResponse<RecordResponse>.fromJson(
              jsonDecode(response.body) as Map<String, dynamic>,
              (Object? data) =>
                  RecordResponse.fromJson(data! as Map<String, dynamic>));

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return result;
      }

      throw result;
    } on SocketException {
      final APIResponse<RecordResponse> error =
          APIResponse<RecordResponse>.fromJson(
              APIResponse.socketErrorResponse(),
              (Object? data) => RecordResponse.fromJson(<String, dynamic>{}));

      throw error;
    }
  }
}
