part of 'result_bloc.dart';

abstract class ResultState extends Equatable {
  final List<Video> videos;
  const ResultState(this.videos);

  @override
  List<Object?> get props => [videos];

  @override
  String toString() {
    return 'SearchState(${videos.length} videos)';
  }
}

class SearchInitial extends ResultState {
  SearchInitial() : super([]);
}

class Searching extends ResultState {
  const Searching(super.videos);
}

class LoadingMoreVideos extends ResultState {
  const LoadingMoreVideos(super.videos);

  @override
  List<Object?> get props => [videos];
}

class SearchSuccess extends ResultState {
  const SearchSuccess(super.videos);

  @override
  List<Object?> get props => [videos];
}

class SearchError extends ResultState {
  final String message;

  SearchError(this.message) : super([]);

  @override
  List<Object?> get props => [message];
}
