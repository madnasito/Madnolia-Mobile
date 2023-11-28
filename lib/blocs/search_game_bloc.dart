import 'dart:async';

class SearchGameBloc {
  final _searchController = StreamController<String>.broadcast();

  // Get values
  Stream<String> get searchController => _searchController.stream;

  // Insert values
  Function(String) get searchValue => _searchController.sink.add;

  void dispose() {
    _searchController.close();
  }
}
