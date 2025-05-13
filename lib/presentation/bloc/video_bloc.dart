import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/reel_model.dart';
import '../../domain/usecases/get_videos.dart';

part 'video_event.dart';
part 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  final GetVideos getVideos;
  int currentPage = 1;
  final int limit = 10;
  bool isLoading = false;

  VideoBloc({required this.getVideos}) : super(VideoInitial()) {
    on<FetchVideosEvent>(_onFetchVideos);
  }

  Future<void> _onFetchVideos(FetchVideosEvent event, Emitter<VideoState> emit) async {
    if (isLoading) return;
    isLoading = true;

    try {
      final response = await getVideos(currentPage, limit);
      currentPage++;

      // Filter out videos with 'auth_key' in the url
      final filteredVideos = response.videos
          .where((video) => !video.cdnUrl.contains("auth_key"))
          .toList();

      if (state is VideoLoaded) {
        final oldState = state as VideoLoaded;
        final combinedVideos = [...oldState.videos, ...filteredVideos];
        emit(VideoLoaded(videos: combinedVideos, metaData: response.metaData));
      } else {
        emit(VideoLoaded(videos: filteredVideos, metaData: response.metaData));
      }
    } catch (e) {
      emit(VideoError("Failed to load videos: ${e.toString()}"));
    } finally {
      isLoading = false;
    }
  }


}
