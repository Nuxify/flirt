import 'dart:async';
import '../../models/record.dart';
import '../../networking/api_response.dart';
import '../../repository/record_repository.dart';

class RecordBloc {
  RecordRepository _recordRepository;

  StreamController _recordController;

  StreamSink<ApiResponse<Record>> get recordSink => _recordController.sink;

  Stream<ApiResponse<Record>> get recordStream => _recordController.stream;

  RecordBloc() {
    _recordController = StreamController<ApiResponse<Record>>();
    _recordRepository = RecordRepository();
    fetchRecord();
  }

  fetchRecord() async {
    recordSink.add(ApiResponse.loading('Fetching Details'));
    try {
      Record details = await _recordRepository.fetchRecord();
      recordSink.add(ApiResponse.completed(details));
    } catch (e) {
      recordSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  createRecord(dynamic payload) async {
    recordSink.add(ApiResponse.loading('Creating record'));
    try {
      Record details = await _recordRepository.createRecord(payload);
      recordSink.add(ApiResponse.completed(details));
    } catch (e) {
      recordSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _recordController?.close();
  }
}
