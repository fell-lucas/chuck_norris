import 'package:chuck_norris/home/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PokemonColumn extends StatelessWidget {
  const PokemonColumn({
    Key? key,
  }) : super(key: key);

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
