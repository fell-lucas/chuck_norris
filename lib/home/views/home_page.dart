import 'package:chuck_norris/home/bloc/bloc.dart';
import 'package:chuck_norris/home/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BlocBuilder<JokeBloc, JokeState>(
              builder: (context, state) {
                if (state is JokeLoadSuccessful) {
                  return Text(
                    state.joke.description,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18.0),
                  );
                } else if (state is JokeLoadInProgress) {
                  return const SpinKitSpinningLines(
                    color: Colors.red,
                  );
                } else if (state is JokeError) {
                  return Text(
                    state.error,
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                } else {
                  return const Text('Press the F#@% Button to get a joke');
                }
              },
            ),
            BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                return FuckingButton(
                  onPress: () {
                    if (state is CategoryUpdated) {
                      jokeBloc.add(
                        FetchJokeByCategory(category: state.category),
                      );
                    } else {
                      jokeBloc.add(FetchJoke());
                    }
                  },
                );
              },
            ),
            Column(
              children: const [
                Text('Choose a category'),
                CategoryDropdown(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
