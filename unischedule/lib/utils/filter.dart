List<T> filterByQuery<T>(List<T> list, String query, String Function(T) getQuery) {
  if (query.isEmpty) {
    return list;
  } else {
    final wordsToSearch = query.toLowerCase().split(" ");
    return list.where((element) =>
        wordsToSearch.every((word) =>
            getQuery(element).toLowerCase().contains(word))
    ).toList();
  }
}