import 'package:flutter/material.dart';

class SearchMovieDelegate extends SearchDelegate {
  SearchMovieDelegate()
    : super(
        searchFieldLabel: 'Buscar películas',
        textInputAction: TextInputAction.search,
      );

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      // IconButton(
      //   icon: const Icon(Icons.clear),
      //   onPressed: () {
      //     query = '';
      //   },
      // ),
      Text('Buiding actions...'),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return Text('Buiding buildLeading...');
    // IconButton(
    //   icon: const Icon(Icons.arrow_back),
    //   onPressed: () {
    //     close(context, null);
    //   },
    // );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Implement search results logic here
    return Text('Buiding buildResults...')
    // Center(child: Text('Resultados para "$query"'))
    ;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Implement search suggestions logic here
    return Text('Buiding buildSuggestions...');
    // Center(child: Text('Sugerencias para "$query"'))
    // ;
  }
}
