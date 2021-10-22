import 'package:chuck_norris/home/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PokemonColumn extends StatelessWidget {
  const PokemonColumn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonBloc, PokemonState>(
      builder: (context, state) {
        if (state is PokemonLoadSuccessful) {
          return Column(
            children: [
              Text(
                '${state.poke.name.toTitleCase()} Norris',
                key: const Key('pokemon_name'),
              ),
              Image.network(
                state.poke.sprites.other.officialArtwork.url,
                key: const Key('pokemon_image'),
                width: 200,
                fit: BoxFit.contain,
              ),
            ],
          );
        } else if (state is PokemonLoadInProgress) {
          return const SpinKitSpinningLines(
            key: Key('loadInProgress_pokemon_indicator'),
            color: Colors.yellow,
          );
        } else if (state is PokemonError) {
          return Text(
            state.error,
            key: const Key('error_pokemon_text'),
            style: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.w500,
            ),
          );
        } else {
          return const Text(
            'Press the shiny button for a pokémon!',
            key: Key('initial_pokemon_text'),
          );
        }
      },
    );
  }
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      isNotEmpty ? '${this[0].toUpperCase()}${substring(1)}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(" ")
      .map((str) => str.toCapitalized())
      .join(" ");
}
