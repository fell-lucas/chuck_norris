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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Press the F#@% button to see the word'),
            ElevatedButton(
              onPressed: () {
                jokeBloc.add(FetchJoke());
              },
              child: const Text('Generate'),
            ),
            BlocBuilder<JokeBloc, JokeState>(
              builder: (context, state) {
                if (state is JokeLoadSuccessful) {
                  // TODO: REFACTOR VALUE PROPERTY
                  return Text(state.joke.value);
                } else if (state is JokeLoadInProgress) {
                  return Container(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Text('');
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
