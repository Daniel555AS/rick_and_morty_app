import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/core/theme/app_colors.dart';
import 'package:rick_and_morty_app/core/theme/text_styles.dart';
import 'package:rick_and_morty_app/data/models/character_model.dart';

class CharacterCard extends StatelessWidget {
  final CharacterModel character;

  const CharacterCard({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: AppColors.characterBoxDecotarion,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(character.image, width: 170),
            ),
            SizedBox(height: 10),
            Text(
              character.name,
              style: TextStyles.characterName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "Last known location:",
              style: TextStyles.subtitleCharacter,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              character.location.name,
              style: TextStyles.bodyCharacter,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children: [
                Icon(
                  Icons.circle,
                  size: 15,
                  color: _getStatusColor(character.status),
                ),
                SizedBox(width: 5),
                Text(
                  "${character.status} - ${character.gender}",
                  style: TextStyles.characterStatusAndGender,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "alive":
        return AppColors.alive;
      case "dead":
        return AppColors.dead;
      default:
        return AppColors.unknown;
    }
  }
}
