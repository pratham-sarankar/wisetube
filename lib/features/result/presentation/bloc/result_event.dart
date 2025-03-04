part of 'result_bloc.dart';

abstract class ResultEvent extends Equatable {
  const ResultEvent();

  @override
  List<Object?> get props => [];
}

class InitializeSearch extends ResultEvent {
  final String searchText;

  const InitializeSearch(this.searchText);

  @override
  List<Object?> get props => [searchText];
}

class LoadMoreVideos extends ResultEvent {
  final String searchText;

  const LoadMoreVideos(this.searchText);
}
