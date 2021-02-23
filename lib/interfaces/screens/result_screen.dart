import 'package:Flirt/models/record.dart';
import 'package:Flirt/networking/api_response.dart';
import 'package:flutter/material.dart';

import '../blocs/record/record.dart';

import '../widgets/header.dart';

class ResultScreen extends StatefulWidget {
  static const routeName = '/result';

  final String qrData;
  final Function rescan;

  ResultScreen(this.qrData, this.rescan);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  RecordBloc _recordBloc;

  final _headerTitle = "QR Data";

  getData() async {
    _recordBloc.fetchRecord(widget.qrData);
  }

  @override
  void initState() {
    super.initState();
    _recordBloc = RecordBloc();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
    final _theme = Theme.of(context);
    return WillPopScope(
      onWillPop: () async {
        widget.rescan();
        return true;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: Header(_headerTitle),
        body: Container(
          margin: EdgeInsets.only(
            left: _mediaQuery.size.width * 0.15,
            right: _mediaQuery.size.width * 0.15,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(_mediaQuery.size.height * 0.02),
                        child: StreamBuilder<ApiResponse<Record>>(
                          stream: _recordBloc.recordStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              switch (snapshot.data.status) {
                                case Status.COMPLETED:
                                  return Column(
                                    children: [
                                      Text(
                                        snapshot.data.data.errorCode == null
                                            ? snapshot.data.data.id
                                            : snapshot.data.data.message,
                                        style:
                                            _theme.textTheme.headline4.copyWith(
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        snapshot.data.data.errorCode == null
                                            ? snapshot.data.data.data
                                            : '',
                                        style:
                                            _theme.textTheme.bodyText1.copyWith(
                                          fontSize: 22,
                                          color: Colors.black,
                                        ),
                                        softWrap: false,
                                      )
                                    ],
                                  );
                                  break;
                                default:
                                  Text('');
                                  break;
                              }
                            }
                            return Container();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [_theme.primaryColor, _theme.accentColor],
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: FlatButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        widget.rescan();
                      },
                      label: Text('Scan again',
                          style: TextStyle(color: Colors.white)),
                      icon: Icon(
                        Icons.center_focus_weak,
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.only(
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
