import 'reel_model.dart';

class VideoResponseModel {
  final List<ReelModel> videos;
  final MetaData metaData;

  VideoResponseModel({required this.videos, required this.metaData});

  factory VideoResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    final List<ReelModel> videos = (data['data'] as List)
        .map((videoJson) => ReelModel.fromJson(videoJson))
        .toList();
    final metaData = MetaData.fromJson(data['meta_data']);

    return VideoResponseModel(videos: videos, metaData: metaData);
  }
}
