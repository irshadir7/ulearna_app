import '../models/video_response_model.dart';

abstract class VideoRepository {
  Future<VideoResponseModel> getVideos(int page, int limit);
}

