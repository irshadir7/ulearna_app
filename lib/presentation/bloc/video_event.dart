part of 'video_bloc.dart';

abstract class VideoEvent extends Equatable {
  const VideoEvent();

  @override
  List<Object?> get props => [];
}

class FetchVideosEvent extends VideoEvent {
  final int page;
  final int limit;

  const FetchVideosEvent({required this.page, required this.limit});

  @override
  List<Object?> get props => [page, limit];
}
class ToggleLikeEvent extends VideoEvent {
  final int videoId;

  const ToggleLikeEvent({required this.videoId});
}
