import '../networking/api_base_helper.dart';
import '../models/record.dart';

class RecordRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<Record> fetchRecord(String id) async {
    final response = await _helper.get(id);
    return Record.fromJson(response);
  }

  Future<Record> createRecord(dynamic payload) async {
    final response = await _helper.post(
      '',
      payload,
    );
    print(response);
    return Record.fromJson(response);
  }
}
