import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wisetube/features/result/presentation/bloc/result_bloc.dart';
import 'package:wisetube/features/result/presentation/widgets/video_card.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadMoreListener);
    WidgetsBinding.instance.addPostFrameCallback((_) => _initializeSearch());
  }

  @override
  void dispose() {
    _scrollController.removeListener(_loadMoreListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResultBloc, ResultState>(
      bloc: context.read<ResultBloc>(),
      listener: (context, state) {},
      builder: (context, state) {
        final isSearching = state is Searching;
        final videos = state.videos;
        return Scaffold(
          appBar: AppBar(),
          body: isSearching
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        physics: const ClampingScrollPhysics(),
                        itemCount: videos.length,
                        itemBuilder: (context, index) {
                          return VideoCard(video: videos[index]);
                        },
                      ),
                    ),
                    if (state is LoadingMoreVideos)
                      const SafeArea(
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: 15,
                          ),
                          child: Column(
                            spacing: 8,
                            children: [
                              SizedBox.square(
                                dimension: 25,
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                  strokeCap: StrokeCap.round,
                                ),
                              ),
                              Text("Loading more videos..."),
                            ],
                          ),
                        ),
                      )
                  ],
                ),
        );
      },
    );
  }

  void _initializeSearch() {
    final searchText = ModalRoute.of(context)?.settings.arguments as String?;
    context.read<ResultBloc>().add(InitializeSearch(searchText!));
  }

  void _loadMoreListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      final searchText = ModalRoute.of(context)?.settings.arguments as String?;
      context.read<ResultBloc>().add(LoadMoreVideos(searchText!));
    }
  }
}
