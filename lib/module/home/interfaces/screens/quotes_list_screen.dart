import 'package:flirt/configs/themes.dart';
import 'package:flirt/module/home/interfaces/widgets/floating_button.dart';
import 'package:flirt/module/home/service/cubit/home_cubit.dart';
import 'package:flirt/module/home/service/cubit/home_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuotesListScreen extends StatelessWidget {
  QuotesListScreen({Key? key}) : super(key: key);

  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final QuoteStateDTO state = context.watch<HomeCubit>().state.data;

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
                  itemCount: state.quotes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(state.quotes[index].content),
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
