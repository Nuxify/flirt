import 'package:flirt/configs/themes.dart';
import 'package:flirt/module/home/service/cubit/quote_cubit.dart';
import 'package:flirt/module/home/service/cubit/quote_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListQuotes extends StatelessWidget {
  ListQuotes({Key? key}) : super(key: key);

  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final QuoteStateDTO state = context.watch<QuoteCubit>().state.data;

    return Scaffold(
      appBar: AppBar(
        // ignore: use_decorated_box
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: flirtGradient),
          ),
        ),
        elevation: 0,
      ),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: flirtGradient,
          ),
        ),
        child: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  controller: _controller,
                  itemCount: state.quotes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(state.quotes[index].en),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Card(
        shape: const CircleBorder(),
        color: theme.primaryColor.withAlpha(240),
        child: IconButton(
          onPressed: () {
            _controller.animateTo(
              _controller.position.maxScrollExtent,
              duration: const Duration(seconds: 2),
              curve: Curves.fastOutSlowIn,
            );
          },
          icon: const Icon(
            Icons.arrow_downward_sharp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
