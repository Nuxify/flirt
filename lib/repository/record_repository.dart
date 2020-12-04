import '../networking/api_base_helper.dart';
import '../models/record.dart';

class RecordRepository {
  final String _recordId = '1l5RjWjCfWhRPWxp7NcGQQeQSzO';

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<Record> fetchRecord() async {
    final response = await _helper.get("$_recordId");
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
