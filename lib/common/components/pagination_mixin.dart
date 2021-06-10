import 'package:flutter/material.dart';

mixin PaginationMixin<T extends StatefulWidget> on State<T> {
  ScrollController get scrollController;
  bool get isLoading;
  bool get hasDataToLoad;

  Future<void> load();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    final position = scrollController.position.pixels;
    final uploadPosition = scrollController.position.maxScrollExtent - 600;

    final reachedLoadingPosition = position > uploadPosition;

    if (reachedLoadingPosition && !isLoading && hasDataToLoad) {
      load();
    }
  }
}
