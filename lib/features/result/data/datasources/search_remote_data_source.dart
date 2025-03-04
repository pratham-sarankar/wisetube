import 'package:youtube_scrape_api/models/video.dart';
import 'package:youtube_scrape_api/youtube_scrape_api.dart';

abstract class SearchRemoteDataSource {
  Future<List<Video>> searchVideos(String query);
}

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  final YoutubeDataApi youtubeApi;

  const SearchRemoteDataSourceImpl({required this.youtubeApi});

  @override
  Future<List<Video>> searchVideos(String query) async {
    try {
      return await youtubeApi.fetchSearchVideo(query);
    } catch (e) {
      throw Exception('Failed to search videos');
    }
  }
}
