import 'package:flirt/configs/themes.dart';
import 'package:flirt/module/home/service/cubit/quote_cubit.dart';
import 'package:flirt/module/home/service/cubit/quote_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListAuthors extends StatelessWidget {
  ListAuthors({Key? key}) : super(key: key);

  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final QuoteStateDTO state = context.watch<QuoteCubit>().state.data;
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('List of authors'),
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
                  controller: _controller,
                  itemCount: state.authors.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                state.authors[index],
                                style: const TextStyle(
                                  color: Colors.pink,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    '"${state.quotes[index].en}"',
                                    overflow: TextOverflow.fade,
                                    maxLines: 3,
                                  ),
                                ),
                              ),
                            ],
                          ),
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
        color: theme.primaryColor,
        child: IconButton(
          onPressed: () {
            _controller.animateTo(
              _controller.position.maxScrollExtent,
              duration: const Duration(seconds: 2),
              curve: Curves.fastOutSlowIn,
            );
          },
          icon: const Icon(Icons.arrow_downward_sharp),
        ),
      ),
    );
  }
}
