import 'package:redux/redux.dart';
import 'package:to_do_list_with_redux/actions.dart';
import 'package:to_do_list_with_redux/state.dart';
import 'favoriteItem.dart';
import 'to_do_item.dart';

AppState appReducer(AppState state, action) {
  if (action is FetchListAction) {
    return AppState(state.posts, state.favoriteItems);
  } else if (action is FetchListSuccessAction) {
    return AppState(action.list, state.favoriteItems);
  } else if (action is FetchListFailAction) {
    return AppState([], []);
  } else if (action is UpdateItemAction) {
    List<ListItem> list = state.posts;
    int index = list.indexWhere((element) => element.id == action.item.id);
    list[index].favStatus = action.item.favStatus;
    return AppState(list, state.favoriteItems);
  } else if (action is AddFavItemAction) {
    final List<FavoriteItem> favItems = List.unmodifiable(
        List.from(state.favoriteItems)..add(action.favoriteItem));
    return AppState(state.posts, favItems);
  } else {
    final List<FavoriteItem> favItems = List.unmodifiable(
        List.from(state.favoriteItems)..remove(action.favoriteItem));
    return AppState(state.posts, favItems);
  }
}

// AppState appReducer(AppState state, action) => AppState(
//     toDoListReducer(state.toDos, action),
//     listStateReducer(state.listState, action),
//     favListReducer(state.favoriteItems, action));

// final Reducer<List<ListItem>> toDoListReducer = combineReducers([
//   TypedReducer<List<ListItem>, FetchListSuccessAction>(_fetchItem),
//   // TypedReducer<List<ListItem>, AddItemAction>(_addItem),
//   TypedReducer<List<ListItem>, RemoveItemAction>(_removeItem),
//   TypedReducer<List<ListItem>, UpdateItemAction>(_updateItem),
// ]);

// List<ListItem> _fetchItem(FetchListSuccessAction action) {
//   return action.list;
// }

// List<ListItem> _removeItem(List<ListItem> toDos, RemoveItemAction action) =>
//     List.unmodifiable(List.from(toDos)..remove(action.item));

// List<ListItem> _addItem(List<ListItem> toDos, AddItemAction action) =>
//     List.unmodifiable(List.from(toDos)..add(action.item));

// List<ListItem> _updateItem(List<ListItem> toDos, UpdateItemAction action) {
//   int index = toDos.indexWhere((element) => element.title == action.item.title);
//   toDos[index].favStatus = action.item.favStatus;
//   return toDos;
// }

// final Reducer<ListState> listStateReducer = combineReducers<ListState>([
  // TypedReducer<ListState, DisplayListOnlyAction>(_displayListOnly),
  // TypedReducer<ListState, DisplayListWithNewItemAction>(
  //     _displayListWithNewItem),
// ]);

// ListState _displayListOnly(ListState listState, DisplayListOnlyAction action) =>
//     ListState.listOnly;

// ListState _displayListWithNewItem(
//         ListState listState, DisplayListWithNewItemAction action) =>
//     ListState.listWithNewItem;

// List<FavoriteItem> _removeFavItem(
//         List<FavoriteItem> favItems, RemoveFavItemAction action) =>
//     List.unmodifiable(List.from(favItems)..remove(action.favoriteItem));

// List<FavoriteItem> _addFavItem(
//     List<FavoriteItem> favoriteItems, AddFavItemAction action) {
//   return List.unmodifiable(List.from(favoriteItems)..add(action.favoriteItem));
// }

// final Reducer<List<FavoriteItem>> favListReducer = combineReducers([
//   TypedReducer<List<FavoriteItem>, AddFavItemAction>(_addFavItem),
//   TypedReducer<List<FavoriteItem>, RemoveFavItemAction>(_removeFavItem),
// ]);
