import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wisetube/features/result/domain/usecases/search_videos.dart';
import 'package:youtube_scrape_api/models/video.dart';

part 'result_event.dart';
part 'result_state.dart';

class ResultBloc extends Bloc<ResultEvent, ResultState> {
  final SearchVideos searchVideos;

  ResultBloc({required this.searchVideos}) : super(SearchInitial()) {
    on<InitializeSearch>(_onInitializeSearch, transformer: droppable());
    on<LoadMoreVideos>(_onLoadMoreVideos, transformer: droppable());
  }

  Future<void> _onInitializeSearch(
    InitializeSearch event,
    Emitter<ResultState> emit,
  ) async {
    emit(Searching(state.videos));

    final result = await searchVideos(event.searchText);

    result.fold(
      (failure) => emit(SearchError('Failed to fetch search results')),
      (videos) => emit(SearchSuccess(videos)),
    );
  }

  Future<void> _onLoadMoreVideos(
    LoadMoreVideos event,
    Emitter<ResultState> emit,
  ) async {
    emit(LoadingMoreVideos(state.videos));

    final result = await searchVideos(event.searchText);
    result.fold(
      (failure) => emit(SearchError('Failed to fetch search results')),
      (videos) => emit(SearchSuccess(state.videos + videos)),
    );
  }
}
