import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/data/models/character_model.dart';
import 'package:rick_and_morty_app/ui/components/character_card.dart';
import 'package:rick_and_morty_app/ui/screens/character_details_screen.dart';

class CharacterGrid extends StatelessWidget {
  final List<CharacterModel> characters;

  const CharacterGrid({super.key, required this.characters});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(15.0),
      itemCount: characters.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Columas}
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 15.0,
        childAspectRatio: 0.62,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => CharacterDetailsScreen(
                      character: characters[index]
                    ),
              ),
            );
          },
          child: CharacterCard(character: characters[index]),
        );
      },
    );
  }
}
