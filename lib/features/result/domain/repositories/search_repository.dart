import 'package:dartz/dartz.dart';
import 'package:wisetube/core/error/failures.dart';
import 'package:youtube_scrape_api/models/video.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<Video>>> searchVideos(String query);
}
