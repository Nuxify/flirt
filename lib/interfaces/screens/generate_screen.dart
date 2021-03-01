import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:qr_flutter/qr_flutter.dart';

import 'package:Flirt/interfaces/widgets/header.dart';
import 'package:Flirt/module/record/service/cubit/record_dto.dart';
import 'package:Flirt/module/record/service/cubit/record_cubit.dart';

class GenerateScreen extends StatefulWidget {
  const GenerateScreen({
    Key key,
  }) : super(key: key);

  static const String routeName = '/generate';

  @override
  _GenerateScreenState createState() => _GenerateScreenState();
}

class _GenerateScreenState extends State<GenerateScreen> {
  double _qrOpacity = 0.0;
  String _generatedData = '';

  /// Textbox controller
  final TextEditingController _idTextController = TextEditingController();
  final TextEditingController _dataTextController = TextEditingController();

  void _resetFields() {
    setState(() {
      _idTextController.clear();
      _dataTextController.clear();
      _generatedData = '';
      _qrOpacity = 0.0;
    });
  }

  void _generateQRCode(BuildContext context) {
    final RecordRequestDTO payload = RecordRequestDTO(
      id: _idTextController.text,
      data: _dataTextController.text,
    );
    context.read<RecordCubit>().recordData(payload);
    Scaffold.of(context).hideCurrentSnackBar();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData _mediaQuery = MediaQuery.of(context);
    final ThemeData _theme = Theme.of(context);

    return Scaffold(
      appBar: const Header(title: 'Generate a QR code'),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            top: _mediaQuery.size.height * 0.05,
            left: _mediaQuery.size.width * 0.12,
            right: _mediaQuery.size.width * 0.12,
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: TextField(
                    controller: _idTextController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'ID (optional)',
                    )),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: TextField(
                  controller: _dataTextController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Data',
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: BlocConsumer<RecordCubit, RecordState>(
                    listener: (BuildContext context, RecordState state) {
                  if (state is RecordLoading) {
                    // disable button
                  }
                  if (state is RecordFailed) {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      backgroundColor: _theme.errorColor,
                      content: Text('Error: ${state.message}'),
                    ));
                    setState(() {
                      _qrOpacity = 0.0;
                    });
                  }
                  if (state is RecordSuccess) {
                    setState(() {
                      _qrOpacity = 1.0;
                      _generatedData = state.recordResponse.data;
                    });
                    Scaffold.of(context).showSnackBar(SnackBar(
                      duration: const Duration(seconds: 120),
                      backgroundColor: Colors.green,
                      content: const Text('QR code is ready.'),
                      action: SnackBarAction(
                        label: 'CREATE NEW',
                        textColor: Colors.black,
                        onPressed: () => _resetFields(),
                      ),
                    ));
                  }
                }, builder: (BuildContext context, RecordState state) {
                  return FlatButton.icon(
                    icon: const Icon(
                      Icons.select_all,
                      color: Colors.white,
                    ),
                    label: Text('GENERATE',
                        style: _theme.textTheme.bodyText1.copyWith(
                          fontSize: 20,
                        )),
                    onPressed: () => _generateQRCode(context),
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                      left: 20,
                      right: 20,
                    ),
                  );
                }),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: _mediaQuery.size.height * 0.08,
                ),
                child: AnimatedOpacity(
                  opacity: _qrOpacity,
                  duration: const Duration(
                    seconds: 1,
                  ),
                  child: QrImage(
                    data: _generatedData,
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
