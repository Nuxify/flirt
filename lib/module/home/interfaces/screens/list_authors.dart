import 'package:flirt/configs/themes.dart';
import 'package:flirt/module/home/interfaces/widgets/floating_button.dart';
import 'package:flirt/module/home/service/cubit/quote_cubit.dart';
import 'package:flirt/module/home/service/cubit/quote_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListAuthors extends StatelessWidget {
  ListAuthors({Key? key}) : super(key: key);

  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final QuoteStateDTO state = context.watch<QuoteCubit>().state.data;
    final ThemeData theme = Theme.of(context);

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
                  controller: controller,
                  itemCount: state.authors.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                '"${state.quotes[index].content}"',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              Text(
                                '\n- ${state.authors[index]}',
                                style: const TextStyle(
                                  color: Colors.pink,
                                ),
                                textAlign: TextAlign.right,
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
      floatingActionButton: QuoteFloatingButton(controller: controller),
    );
  }
}
