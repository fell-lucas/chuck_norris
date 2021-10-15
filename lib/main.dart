import 'package:chuck_norris/home/bloc/joke_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joke_repository/joke_repository.dart';

import 'package:chuck_norris/home/home.dart';

void main() {
  final JokeApi jokeApi = JokeApi();
  final JokeRepository jokeRepository = Repository(jokeApi: jokeApi);
  runApp(MyApp(
    jokeRepository: jokeRepository,
  ));
}

class MyApp extends StatelessWidget {
  final JokeRepository jokeRepository;

  const MyApp({
    Key? key,
    required this.jokeRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<JokeBloc>(
        create: (context) => JokeBloc(jokeRepository: jokeRepository),
        child: HomePage(),
      ),
    );
  }
}
