import '../datasources/video_remote_data_source.dart';
import '../models/video_response_model.dart';
import 'video_repository.dart';

class VideoRepositoryImpl implements VideoRepository {
  final VideoRemoteDataSource remoteDataSource;

  VideoRepositoryImpl({required this.remoteDataSource});

  @override
  Future<VideoResponseModel> getVideos(int page, int limit) {
    return remoteDataSource.fetchVideos(page, limit);
  }
}
