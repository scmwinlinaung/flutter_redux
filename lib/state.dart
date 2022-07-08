import 'package:to_do_list_with_redux/favoriteItem.dart';

import 'to_do_item.dart';

class AppState {
  final List<ListItem> posts;
  final List<FavoriteItem> favoriteItems;

  AppState(this.posts, this.favoriteItems);

  factory AppState.initial() =>
      AppState(List.unmodifiable([]), List.unmodifiable([]));
}

// enum ListState { listOnly, listWithNewItem }
