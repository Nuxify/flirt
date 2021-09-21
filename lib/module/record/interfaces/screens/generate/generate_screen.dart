import 'package:flirt/interfaces/widgets/header.dart';
import 'package:flirt/module/record/service/cubit/record_cubit.dart';
import 'package:flirt/module/record/service/cubit/record_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateScreen extends StatefulWidget {
  const GenerateScreen({
    Key? key,
  }) : super(key: key);

  static const String routeName = '/generate';

  @override
  _GenerateScreenState createState() => _GenerateScreenState();
}

class _GenerateScreenState extends State<GenerateScreen> {
  String _generatedQRCode = '';

  /// Textbox controller
  final TextEditingController _idTextController = TextEditingController();
  final TextEditingController _dataTextController = TextEditingController();

  @override
  void initState() {
    _resetFields();
    super.initState();
  }

  void _resetFields() {
    context.read<RecordCubit>().resetState();
    setState(() {
      _idTextController.clear();
      _dataTextController.clear();
      _generatedQRCode = '';
    });
  }

  void _generateQRCode(BuildContext context) {
    final RecordRequestDTO payload = RecordRequestDTO(
      id: _idTextController.text,
      data: _dataTextController.text,
    );
    context.read<RecordCubit>().recordData(payload);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
            children: <Widget>[
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
              BlocListener<RecordCubit, RecordState>(
                listener: (
                  BuildContext context,
                  RecordState state,
                ) {
                  if (state is RecordFailed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: _theme.errorColor,
                        content: Text('Error: ${state.message}'),
                      ),
                    );
                  }
                  if (state is RecordSuccess) {
                    setState(() {
                      _generatedQRCode = state.recordResponse.id;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.green,
                        content: const Text('QR code is ready.'),
                        action: SnackBarAction(
                          label: 'CREATE NEW',
                          textColor: Colors.black,
                          onPressed: () => _resetFields(),
                        ),
                      ),
                    );
                  }
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: BlocBuilder<RecordCubit, RecordState>(
                    builder: (BuildContext context, RecordState state) {
                      final String buttonText = (state is RecordLoading)
                          ? 'GENERATING...'
                          : 'GENERATE';
                      return TextButton.icon(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                              vertical: 20,
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all(_theme.primaryColor),
                        ),
                        icon: const Icon(
                          Icons.select_all,
                        ),
                        label: Text(
                          buttonText,
                          style: const TextStyle(fontSize: 20.0),
                        ),
                        onPressed:
                            (state is RecordLoading || state is RecordSuccess)
                                ? null
                                : () => _generateQRCode(context),
                      );
                    },
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: _mediaQuery.size.height * 0.06,
                ),
                child: BlocBuilder<RecordCubit, RecordState>(
                  builder: (BuildContext context, RecordState state) {
                    if (state is RecordLoading) {
                      return Column(
                        children: <Widget>[
                          SizedBox(
                            height: _mediaQuery.size.height * 0.12,
                          ),
                          const CircularProgressIndicator(
                            backgroundColor: Colors.black26,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.blueAccent),
                          )
                        ],
                      );
                    } else if (state is RecordSuccess) {
                      return QrImage(
                        data: _generatedQRCode,
                        size: 200.0,
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
