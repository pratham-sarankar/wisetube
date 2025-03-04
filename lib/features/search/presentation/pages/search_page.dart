import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:wisetube/core/routes/app_routes.dart';
import 'package:wisetube/features/search/services/suggestions_service.dart';
import 'dart:async';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  /// List of search suggestions fetched from YouTube API
  List<String> _suggestions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('WiseTube'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          children: [
            SearchAnchor.bar(
              barElevation: WidgetStateProperty.all(3),
              barLeading: const Icon(IconlyLight.search),
              barHintText: 'Search',
              isFullScreen: true,
              onChanged: _updateSuggestions,
              suggestionsBuilder: (context, controller) async {
                return _suggestions.map(
                  (search) {
                    return Column(
                      children: [
                        ListTile(
                          title: Text(search),
                          onTap: () {
                            controller.closeView(search);
                            Navigator.pushNamed(
                              context,
                              AppRoutes.search,
                              arguments: search,
                            );
                          },
                          trailing: GestureDetector(
                            onTap: () {
                              controller.text = search;
                              _updateSuggestions(search);
                            },
                            child: Transform.rotate(
                              angle: 45,
                              child: const Icon(IconlyLight.arrowLeft),
                            ),
                          ),
                        ),
                        const Divider(
                          height: 1,
                          thickness: 1,
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateSuggestions(String query) async {
    try {
      if (query.isEmpty) {
        setState(() => _suggestions = []);
        return;
      }

      final suggestions = await SuggestionsService.fetchSuggestions(query);
      setState(() => _suggestions = suggestions);
    } catch (e) {
      debugPrint('Error fetching suggestions: $e');
    }
  }
}
