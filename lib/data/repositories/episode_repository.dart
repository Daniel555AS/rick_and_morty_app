import 'package:rick_and_morty_app/data/models/episode_model.dart';
import 'package:rick_and_morty_app/data/services/episode_service.dart';

class EpisodeRepository {
  final EpisodeService _episodeService = EpisodeService();

  Future<EpisodeModel> getEpisodeById(int id) async {
    return await _episodeService.getEpisodeById(id);
  }

  Future<List<EpisodeModel>> getEpisodesByIds(List<int> episodesIds) async {
    List<EpisodeModel> episodes = [];

    final rawList = await _episodeService.getEpisodesByIds(episodesIds);

    for (Map<String, dynamic> json in rawList) {
      episodes.add(EpisodeModel.fromJson(json));
    }

    return episodes;
  }
}
