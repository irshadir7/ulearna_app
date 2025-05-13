part of 'video_bloc.dart';

abstract class VideoState extends Equatable {
  const VideoState();

  @override
  List<Object?> get props => [];
}

class VideoInitial extends VideoState {}

class VideoLoading extends VideoState {}

class VideoLoaded extends VideoState {
  final List<ReelEntity> videos;
  final MetaData metaData;

  const VideoLoaded({required this.videos, required this.metaData});

  @override
  List<Object?> get props => [videos];
}

class VideoError extends VideoState {
  final String message;

  const VideoError(this.message);

  @override
  List<Object?> get props => [message];
}
