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
  @override
  void initState() {
    super.initState();
  }

  final String _headerTitle = 'Generate a QR code';
  String _idTextField = '';
  String _dataTextField = '';
  double _qrOpacity = 0.0;

  void _resetFields() {
    setState(() {
      _idTextField = '';
      _dataTextField = '';
      _qrOpacity = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData _mediaQuery = MediaQuery.of(context);
    final ThemeData _theme = Theme.of(context);

    return Scaffold(
      appBar: Header(title: _headerTitle),
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
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'ID (optional)',
                  ),
                  onChanged: (String value) => _idTextField = value,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Data',
                  ),
                  onChanged: (String value) => _dataTextField = value,
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
                        backgroundColor: Colors.red,
                        content: Text('Error: ${state.message}'),
                      ));
                      setState(() {
                        _qrOpacity = 0.0;
                      });
                    }
                    if (state is RecordSuccess) {
                      setState(() {
                        _qrOpacity = 1.0;
                      });
                      Scaffold.of(context).showSnackBar(SnackBar(
                        duration: const Duration(seconds: 120),
                        backgroundColor: Colors.green,
                        content: const Text('QR code is ready.'),
                        action: SnackBarAction(
                          label: 'CREATE NEW',
                          textColor: Colors.black,
                          onPressed: () {
                            _resetFields();
                          },
                        ),
                      ));
                    }
                  },
                  builder: (BuildContext context, RecordState state) {
                    return FlatButton.icon(
                      icon: const Icon(Icons.select_all, color: Colors.white),
                      label: Text('GENERATE',
                          style: _theme.textTheme.bodyText1
                              .copyWith(fontSize: 20)),
                      onPressed: () {
                        final RecordRequestDTO payload = RecordRequestDTO(
                            id: _idTextField, data: _dataTextField);
                        context.read<RecordCubit>().recordData(payload);
                      },
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, left: 20, right: 20),
                      color: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: _mediaQuery.size.height * 0.08),
                child: AnimatedOpacity(
                  opacity: _qrOpacity,
                  duration: const Duration(seconds: 1),
                  child: QrImage(
                    data: _idTextField,
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
