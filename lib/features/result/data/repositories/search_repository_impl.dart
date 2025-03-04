import 'package:dartz/dartz.dart';
import 'package:wisetube/core/error/failures.dart';
import 'package:wisetube/features/result/data/datasources/search_remote_data_source.dart';
import 'package:wisetube/features/result/domain/repositories/search_repository.dart';
import 'package:youtube_scrape_api/models/video.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource remoteDataSource;

  const SearchRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Video>>> searchVideos(String query) async {
    try {
      final videos = await remoteDataSource.searchVideos(query);
      return Right(videos);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
