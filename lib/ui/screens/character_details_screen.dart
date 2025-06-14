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
  List<EpisodeModel> _episodes = [];

  Future<void> _getEpisodesFromCharacter() async {
    setState(() {
      _isLoading = true;
    });

    List<String> episodesUrls = widget.character.episode;
    List<int> episodesIds = [];

    try {
      for (int i = 0; i < episodesUrls.length; i++) {
        episodesIds.add(
          int.parse(
            episodesUrls[i].replaceAll(
              "https://rickandmortyapi.com/api/episode/",
              "",
            ),
          ),
        );
      }

      final response = await _episodeRepository.getEpisodesByIds(episodesIds);

      setState(() {
        _episodes = response;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _episodes = [];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getEpisodesFromCharacter();
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

    return Center(
      child: SizedBox(
        width: contentWidth,
        child: ListView(
          children: [
            SizedBox(height: 40.0),
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
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    bottom: 30.0,
                    left: 10.0,
                    right: 10.0,
                  ),
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
                              style: TextStyles.characterDetails,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 35.0),
                      _getCharacterDetailSubtitle(
                        "Origin",
                        Icons.location_history,
                      ),
                      Text(
                        widget.character.origin.name,
                        style: TextStyles.characterDetails,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 15.0),
                      _getCharacterDetailSubtitle(
                        "Last Know Location",
                        Icons.place_rounded,
                      ),
                      Text(
                        widget.character.location.name,
                        style: TextStyles.characterDetails,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 15.0),
                      _getCharacterDetailSubtitle(
                        "First Seen In",
                        Icons.tv_rounded,
                      ),
                      Text(
                        (_episodes.isNotEmpty)
                            ? "${_episodes[0].episode}: ${_episodes[0].name}"
                            : "ERROR: Data could not be obtained...",
                        style: TextStyles.characterDetails,
                        textAlign: TextAlign.center,
                      ),

                      _getFeaturedEpisodesSection(),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 40.0),
          ],
        ),
      ),
    );
  }

  Widget _getFeaturedEpisodesSection() {
    return ExpansionTile(
      title: Text(
        "Featured Episodes",
        style: TextStyles.characterDetailsFeaturedEpisodes,
      ),
      leading: Icon(
        Icons.play_circle_outlined,
        color: AppColors.episodesIconColor,
      ),
      iconColor: AppColors.episodesIconColor,
      collapsedIconColor: AppColors.episodesIconColor,
      children: _getFeaturedEpisodesSubSections(),
    );
  }

  List<Widget> _getFeaturedEpisodesSubSections() {
    List<Widget> episodes = [];

    for (int i = 0; i < _episodes.length; i++) {
      episodes.add(
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.chapterSectionBackground,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${_episodes[i].episode} : ${_episodes[i].name}",
                    style: TextStyles.characterDetails,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month_rounded,
                        color: AppColors.calendarIconColor,
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        _episodes[0].airDate,
                        style: TextStyles.episodeDateDescription,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return episodes;
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
      foregroundColor: AppColors.scaffoldAppBarForeground,
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

  Widget _getCharacterDetailSubtitle(String text, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyles.characterDetailsSubtitleCharacter,
          textAlign: TextAlign.center,
        ),
        SizedBox(width: 5.0),
        Icon(icon, size: 25.0, color: AppColors.subtitleCharacter),
      ],
    );
  }
}
