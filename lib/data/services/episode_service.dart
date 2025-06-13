import 'package:rick_and_morty_app/core/network/api_client.dart';
import 'package:rick_and_morty_app/data/models/episode_model.dart';

class EpisodeService {
  final ApiClient _apiClient = ApiClient();

  Future<EpisodeModel> getEpisodeById(int id) async {
    String endpoint = "episode/$id";

    final response = await _apiClient.get(endpoint);

    return EpisodeModel.fromJson(response);
  }
}
