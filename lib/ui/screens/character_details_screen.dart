import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/core/theme/app_colors.dart';
import 'package:rick_and_morty_app/core/theme/text_styles.dart';
import 'package:rick_and_morty_app/data/models/character_model.dart';
import 'package:rick_and_morty_app/data/models/episode_model.dart';
import 'package:rick_and_morty_app/data/repositories/episode_repository.dart';
import 'package:rick_and_morty_app/ui/components/rick_and_morty_loading.dart';

class CharacterDetailsScreen extends StatefulWidget {
  final CharacterModel character;

  const CharacterDetailsScreen({super.key, required this.character});

  @override
  State<CharacterDetailsScreen> createState() => _CharacterDetailsScreenState();
}

class _CharacterDetailsScreenState extends State<CharacterDetailsScreen> {
  final EpisodeRepository _episodeRepository = EpisodeRepository();
  bool _isLoading = true;
  EpisodeModel? _firstEpisode;

  Future<void> _getFirstEpisodeFromCharacter() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final episode = await _episodeRepository.getEpisodeById(
        int.parse(
          widget.character.episode[0].replaceAll(
            "https://rickandmortyapi.com/api/episode/",
            "",
          ),
        ),
      );
      setState(() {
        _firstEpisode = episode;
        _isLoading = false;
      });
    } catch (e) {
      _isLoading = false;
    }
  }

  @override
  void initState() {
    super.initState();
    _getFirstEpisodeFromCharacter();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double contentWidth = screenWidth * 0.8;

    return Scaffold(
      appBar: _getAppBar(),
      backgroundColor: AppColors.scaffoldBackground,
      body: _getBody(contentWidth),
    );
  }

  Widget _getBody(double contentWidth) {
    if (_isLoading) {
      return RickAndMortyLoading();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 25.0, bottom: 25.0),
      child: Center(
        child: SizedBox(
          width: contentWidth,
          child: ListView(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
                child: Image.network(
                  widget.character.image,
                  width: double.infinity,
                  fit: BoxFit.cover, // Opcional
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.characterBoxDecotarion,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          widget.character.name,
                          style: TextStyles.characterDetailsName,
                          textAlign: TextAlign.center,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.circle,
                              size: 15,
                              color: _getStatusColor(widget.character.status),
                            ),
                            Flexible(
                              child: Text(
                                "${widget.character.status} - ${widget.character.gender}",
                                style:
                                    TextStyles.characterDetailsStatusAndGender,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 35.0),
                        Text(
                          "Origin",
                          style: TextStyles.characterDetailsSubtitleCharacter,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          widget.character.origin.name,
                          style: TextStyles.characterDetailsStatusAndGender,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 15.0),
                        Text(
                          "Last Know Location",
                          style: TextStyles.characterDetailsSubtitleCharacter,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          widget.character.location.name,
                          style: TextStyles.characterDetailsStatusAndGender,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 15.0),
                        Text(
                          "First Seen In",
                          style: TextStyles.characterDetailsSubtitleCharacter,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          (_firstEpisode != null)
                              ? "${_firstEpisode!.episode}: ${_firstEpisode!.name}"
                              : "ERROR: Data could not be obtained...",
                          style: TextStyles.characterDetailsStatusAndGender,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _getAppBar() {
    return AppBar(
      title: Center(
        child: Text(
          "Rick and Morty Wiki",
          style: TextStyles.scaffoldAppBarTitle,
        ),
      ),
      backgroundColor: AppColors.scaffoldAppBarBackground,
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
