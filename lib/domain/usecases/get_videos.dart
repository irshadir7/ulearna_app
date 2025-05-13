import '../../data/models/video_response_model.dart';
import '../../data/repositories/video_repository.dart';


class GetVideos {
  final VideoRepository repository;

  GetVideos({required this.repository});

  Future<VideoResponseModel> call(int page, int limit) {
    return repository.getVideos(page, limit);
  }
}
