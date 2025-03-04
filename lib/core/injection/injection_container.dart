import 'package:get_it/get_it.dart';
import 'package:youtube_scrape_api/youtube_scrape_api.dart';
import 'package:wisetube/features/result/data/datasources/search_remote_data_source.dart';
import 'package:wisetube/features/result/data/repositories/search_repository_impl.dart';
import 'package:wisetube/features/result/domain/repositories/search_repository.dart';
import 'package:wisetube/features/result/domain/usecases/search_videos.dart';
import 'package:wisetube/features/result/presentation/bloc/result_bloc.dart';

final sl = GetIt.instance;

void setupDependencies() {
  // External
  sl.registerLazySingleton(() => YoutubeDataApi());

  // Blocs
  sl.registerFactory(() => ResultBloc(searchVideos: sl()));

  // Use cases
  sl.registerLazySingleton(() => SearchVideos(sl()));

  // Repositories
  sl.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<SearchRemoteDataSource>(
    () => SearchRemoteDataSourceImpl(youtubeApi: sl()),
  );
}
