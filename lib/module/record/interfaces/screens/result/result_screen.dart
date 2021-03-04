import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:qr_flutter/qr_flutter.dart';

import 'package:Flirt/interfaces/widgets/header.dart';
import 'package:Flirt/module/record/service/cubit/record_cubit.dart';
import 'package:Flirt/interfaces/widgets/rounded_button.dart';
import 'package:Flirt/module/record/interfaces/screens/scan/scan_screen.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({
    Key key,
    this.qrData,
    this.rescan,
  }) : super(key: key);

  static const String routeName = '/result';

  final String qrData;
  final Function rescan;

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  void initState() {
    context.read<RecordCubit>().fetchRecord(widget.qrData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData _mediaQuery = MediaQuery.of(context);
    final ThemeData _theme = Theme.of(context);
    return WillPopScope(
      onWillPop: () async {
        widget.rescan();
        return true;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const Header(title: 'QR Data Result'),
        body: Container(
          margin: EdgeInsets.only(
            left: _mediaQuery.size.width * 0.15,
            right: _mediaQuery.size.width * 0.15,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(_mediaQuery.size.height * 0.02),
                      child: BlocBuilder<RecordCubit, RecordState>(
                        builder: (BuildContext context, RecordState state) {
                          if (state is RecordLoading) {
                            return Column(
                              children: <Widget>[
                                const CircularProgressIndicator(
                                  backgroundColor: Colors.black26,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.blueAccent),
                                ),
                                SizedBox(
                                  height: _mediaQuery.size.height * 0.1,
                                ),
                              ],
                            );
                          } else if (state is RecordFailed) {
                            return Column(
                              children: <Widget>[
                                Text(
                                  state.errorCode.toString(),
                                  style: TextStyle(
                                    color: _theme.errorColor,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: _mediaQuery.size.height * 0.1,
                                ),
                              ],
                            );
                          } else if (state is RecordSuccess) {
                            return Column(
                              children: <Widget>[
                                Text(
                                  state.recordResponse.data,
                                  style: TextStyle(
                                    color: _theme.primaryColor,
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                Text(
                                  state.recordResponse.id,
                                  style: const TextStyle(
                                    color: Colors.black38,
                                    fontSize: 12.0,
                                  ),
                                  softWrap: false,
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                QrImage(
                                  data: state.recordResponse.data,
                                  size: 200.0,
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                              ],
                            );
                          } else {
                            return const Text('');
                          }
                        },
                      ),
                    ),
                  ],
                ),
                RoundedButton(
                  buttonLabel: 'SCAN AGAIN',
                  buttonIcon: Icons.center_focus_weak,
                  onPressedFunc: () {
                    Navigator.pushNamed(
                      context,
                      ScanScreen.routeName,
                    );
                    widget.rescan();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
