import 'package:to_do_list_with_redux/favoriteItem.dart';
import 'package:to_do_list_with_redux/to_do_item.dart';

class FetchListAction {}

class FetchListSuccessAction {
  final List<ListItem> list;

  FetchListSuccessAction(this.list);
}

class FetchListFailAction {
  final Object errors;

  FetchListFailAction(this.errors);
}

// class RemoveItemAction {
//   final ListItem item;

//   RemoveItemAction(this.item);
// }

// class AddItemAction {
//   final ListItem item;

//   AddItemAction(this.item);
// }

class UpdateItemAction {
  final ListItem item;

  UpdateItemAction(this.item);
}

class RemoveFavItemAction {
  final FavoriteItem favoriteItem;
  RemoveFavItemAction(this.favoriteItem);
}

class AddFavItemAction {
  final FavoriteItem favoriteItem;
  AddFavItemAction(this.favoriteItem);
}

// class DisplayListOnlyAction {}

// class DisplayListWithNewItemAction {}

// class SaveListAction {}

// class FavListAction {}
