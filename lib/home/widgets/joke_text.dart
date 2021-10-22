import 'package:chuck_norris/home/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class JokeText extends StatelessWidget {
  const JokeText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JokeBloc, JokeState>(
      builder: (context, state) {
        if (state is JokeLoadSuccessful) {
          return Text(
            state.joke.description,
            key: const Key('chuck_norris_joke'),
            textAlign: TextAlign.center,
          );
        } else if (state is JokeLoadInProgress) {
          return const SpinKitSpinningLines(
            key: Key('loadInProgress_joke_indicator'),
            color: Colors.red,
          );
        } else if (state is JokeError) {
          return Text(
            state.error,
            key: const Key('error_joke_text'),
            style: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.w500,
            ),
          );
        } else {
          return const Text(
            'And a Chuck Norris joke!',
            key: Key('initial_joke_text'),
          );
        }
      },
    );
  }
}
