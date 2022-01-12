import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sampleapi/bloc/bloc/home_bloc.dart';
import 'package:sampleapi/services/network/bored_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        RepositoryProvider.of<BoredService>(context),
      )..add(LoadApiEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Activaties for Bored People"),
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is HomeLoadedState) {
              return boredServiceActivityInfo(state, context);
            }
            return Container();
          },
        ),
      ),
    );
  }

  Center boredServiceActivityInfo(HomeLoadedState state, BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(state.activityName),
          Text(state.activityType),
          Text(state.participants.toString()),
          ElevatedButton(
            onPressed: () =>
                BlocProvider.of<HomeBloc>(context).add(LoadApiEvent()),
            child: const Text("Load Next"),
          ),
        ],
      ),
    );
  }
}
