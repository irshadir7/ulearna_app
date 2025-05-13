import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/api_constants.dart';
import '../models/video_response_model.dart'; // ReelModel implements ReelEntity

abstract class VideoRemoteDataSource {
  Future<VideoResponseModel> fetchVideos(int page, int limit);
}

class VideoRemoteDataSourceImpl implements VideoRemoteDataSource {
  final http.Client client;

  VideoRemoteDataSourceImpl({required this.client});

  @override
  Future<VideoResponseModel> fetchVideos(int page, int limit) async {
    final response = await client.get(Uri.parse('$baseUrl?page=$page&limit=$limit'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return VideoResponseModel.fromJson(data);
    } else {
      throw Exception('Failed to load videos');
    }

  }

}
