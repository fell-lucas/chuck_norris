import 'package:chuck_norris/home/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:joke_repository/joke_repository.dart';

import 'package:chuck_norris/home/home.dart';

GetIt getIt = GetIt.instance;

void main() {
  getIt.registerSingleton<JokeApi>(JokeApi());
  getIt.registerSingleton<JokeRepository>(
    Repository(jokeApi: getIt<JokeApi>()),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<JokeBloc>(
            create: (context) => JokeBloc(
              jokeRepository: getIt<JokeRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => CategoryBloc(),
          ),
        ],
        child: const HomePage(),
      ),
    );
  }
}
