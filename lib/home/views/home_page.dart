import 'dart:math';

import 'package:chuck_norris/home/bloc/bloc.dart';
import 'package:chuck_norris/home/bloc/pokemon/pokemon_bloc.dart';
import 'package:chuck_norris/home/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    JokeBloc jokeBloc = BlocProvider.of<JokeBloc>(context);
    PokemonBloc pokeBloc = BlocProvider.of<PokemonBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chuck Norris Jokes'),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BlocBuilder<PokemonBloc, PokemonState>(
              builder: (context, state) {
                if (state is PokemonLoadSuccessful) {
                  return Column(
                    children: [
                      Text(
                        '${state.poke.name.toTitleCase()} Norris',
                        key: const Key('pokemon_name'),
                      ),
                      Image.network(
                        state.poke.sprites['other']['official-artwork']
                            ['front_default'],
                        key: const Key('pokemon_image'),
                        width: 200,
                        fit: BoxFit.contain,
                      ),
                    ],
                  );
                } else if (state is PokemonLoadInProgress) {
                  return const SpinKitSpinningLines(
                    color: Colors.yellow,
                  );
                } else if (state is PokemonError) {
                  return Text(
                    state.error,
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            BlocBuilder<JokeBloc, JokeState>(
              builder: (context, state) {
                if (state is JokeLoadSuccessful) {
                  return Text(
                    state.joke.description,
                    key: const Key('chuck_norris_joke'),
                    textAlign: TextAlign.center,
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
                    pokeBloc.add(FetchSprite(
                      pokeNumber: Random().nextInt(620) + 1,
                    ));
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: const [
                    Text('Joke category'),
                    CategoryDropdown(),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      this.length > 0 ? '${this[0].toUpperCase()}${this.substring(1)}' : '';
  String toTitleCase() => this
      .replaceAll(RegExp(' +'), ' ')
      .split(" ")
      .map((str) => str.toCapitalized())
      .join(" ");
}
