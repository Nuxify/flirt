import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  RecordCubit _recordBloc;

  final String _headerTitle = 'QR Data';

  getData() async {
    // _recordBloc.fetchRecord(widget.qrData);
  }

  @override
  void initState() {
    super.initState();
    getData();
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
        appBar: Header(title: _headerTitle),
        body: Container(
          margin: EdgeInsets.only(
            left: _mediaQuery.size.width * 0.15,
            right: _mediaQuery.size.width * 0.15,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(_mediaQuery.size.height * 0.02),
                      child: BlocBuilder<RecordCubit, RecordState>(
                        builder: (BuildContext context, RecordState state) {
                          // if (snapshot.hasData) {
                          //   switch (snapshot.data.status) {
                          //     case Status.COMPLETED:
                          //       return Column(
                          //         children: [
                          //           Text(
                          //             snapshot.data.data.errorCode == null
                          //                 ? snapshot.data.data.id
                          //                 : snapshot.data.data.message,
                          //             style:
                          //                 _theme.textTheme.headline4.copyWith(
                          //               fontSize: 18,
                          //             ),
                          //           ),
                          //           Text(
                          //             snapshot.data.data.errorCode == null
                          //                 ? snapshot.data.data.data
                          //                 : '',
                          //             style:
                          //                 _theme.textTheme.bodyText1.copyWith(
                          //               fontSize: 22,
                          //               color: Colors.black,
                          //             ),
                          //             softWrap: false,
                          //           )
                          //         ],
                          //       );
                          //       break;
                          //     default:
                          //       const Text('');
                          //       break;
                          //   }
                          // }
                          return Container();
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
                        colors: [_theme.primaryColor, _theme.accentColor],
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
