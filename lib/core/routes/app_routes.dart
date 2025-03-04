import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wisetube/core/injection/injection_container.dart';
import 'package:wisetube/features/search/presentation/pages/search_page.dart';
import 'package:wisetube/features/result/presentation/bloc/result_bloc.dart';
import 'package:wisetube/features/result/presentation/pages/result_page.dart';

class AppRoutes {
  static const String home = '/';
  static const String search = '/search';

  static Map<String, WidgetBuilder> get routes => {
        home: (context) => const SearchPage(),
        search: (context) {
          return BlocProvider(
            create: (context) => sl.get<ResultBloc>(),
            child: const ResultPage(),
          );
        },
      };
}
