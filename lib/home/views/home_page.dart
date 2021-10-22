import 'dart:math';

import 'package:chuck_norris/home/bloc/bloc.dart';
import 'package:chuck_norris/home/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            const PokemonColumn(),
            const JokeText(),
            BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                return FuckingButton(
                  onPress: () {
                    BlocProvider.of<PokemonBloc>(context).add(FetchSprite(
                      pokeNumber: Random().nextInt(620) + 1,
                    ));
                    if (state is CategoryUpdated) {
                      BlocProvider.of<JokeBloc>(context).add(
                        FetchJokeByCategory(category: state.category),
                      );
                    } else {
                      BlocProvider.of<JokeBloc>(context).add(FetchJoke());
                    }
                  },
                );
              },
            ),
            Column(
              children: const [
                Text('Joke category'),
                CategoryDropdown(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
