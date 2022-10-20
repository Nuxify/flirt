import 'package:flirt/configs/themes.dart';
import 'package:flirt/module/quote/service/cubit/quote_cubit.dart';
import 'package:flirt/module/quote/service/cubit/quote_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListQuotes extends StatelessWidget {
  const ListQuotes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<QuoteResponseDTO>? state =
        context.watch<QuoteCubit>().state.quotes;

    return Scaffold(
      appBar: AppBar(
        title: const Text('List of quotes'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: flirtGradient,
          ),
        ),
        child: Center(
          child: Column(
            children: <Widget>[
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'List is updated when the state is updated',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: state != null ? state.length : 0,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(state![index].en),
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
    );
  }
}
