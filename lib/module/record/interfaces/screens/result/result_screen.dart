import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:qr_flutter/qr_flutter.dart';

import 'package:Flirt/interfaces/widgets/header.dart';
import 'package:Flirt/module/record/service/cubit/record_cubit.dart';

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
                                Text(state.errorCode.toString(),
                                    style: TextStyle(
                                      color: _theme.errorColor,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    )),
                                SizedBox(
                                  height: _mediaQuery.size.height * 0.1,
                                ),
                              ],
                            );
                          } else if (state is RecordSuccess) {
                            return Column(
                              children: <Widget>[
                                Text(
                                  state.recordResponse.id,
                                  style: _theme.textTheme.headline4.copyWith(
                                    fontSize: 24,
                                  ),
                                ),
                                Text(
                                  state.recordResponse.data,
                                  style: _theme.textTheme.bodyText1.copyWith(
                                    fontSize: 18,
                                    color: Colors.black,
                                  ),
                                  softWrap: false,
                                ),
                                const SizedBox(
                                  height: 10.0,
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
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: <Color>[
                          _theme.primaryColor,
                          _theme.accentColor
                        ],
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: FlatButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        widget.rescan();
                      },
                      label: const Text('Scan again',
                          style: TextStyle(color: Colors.white)),
                      icon: const Icon(
                        Icons.center_focus_weak,
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, left: 20, right: 20),
                      color: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}