import 'package:dartz/dartz.dart';
import 'package:wisetube/core/error/failures.dart';
import 'package:wisetube/features/result/domain/repositories/search_repository.dart';
import 'package:youtube_scrape_api/models/video.dart';

class SearchVideos {
  final SearchRepository repository;

  const SearchVideos(this.repository);

  Future<Either<Failure, List<Video>>> call(String query) async {
    return await repository.searchVideos(query);
  }
}
