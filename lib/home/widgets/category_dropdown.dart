import 'package:chuck_norris/home/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryDropdown extends StatelessWidget {
  const CategoryDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        return DropdownButton<String>(
          value: (state is CategoryUpdated) ? state.category : 'random',
          items: const [
            "animal",
            "career",
            "celebrity",
            "dev",
            "explicit",
            "fashion",
            "food",
            "history",
            "money",
            "movie",
            "music",
            "political",
            "religion",
            "science",
            "sport",
            "travel",
            "random"
          ].map((e) => DropdownMenuItem(child: Text(e), value: e)).toList(),
          onChanged: (value) {
            BlocProvider.of<CategoryBloc>(context).add(
              UpdateCategory(category: value!),
            );
          },
        );
      },
    );
  }
}
