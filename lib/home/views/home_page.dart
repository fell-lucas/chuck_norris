import 'package:chuck_norris/home/bloc/joke_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    JokeBloc jokeBloc = BlocProvider.of<JokeBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chuck Norris Jokes'),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BlocBuilder<JokeBloc, JokeState>(
              builder: (context, state) {
                if (state is JokeLoadSuccessful) {
                  return Text(
                    state.joke.description,
                    textAlign: TextAlign.justify,
                  );
                } else if (state is JokeLoadInProgress) {
                  return const CircularProgressIndicator();
                } else if (state is JokeError) {
                  return Text(
                    state.error,
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                } else {
                  return const Text('Press the F#@% Button to see a joke');
                }
              },
            ),
            ElevatedButton(
              onPressed: () {
                jokeBloc.add(FetchJoke());
              },
              child: const Text('F#@% Button'),
            ),
          ],
        ),
      ),
    );
  }
}
