import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'package:to_do_list_with_redux/model/favoriteItem.dart';
import 'package:to_do_list_with_redux/state/state.dart';

import '../action/actions.dart';
import '../model/to_do_item.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel.create(store),
        builder: (BuildContext context, _ViewModel viewModel) => Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: 30,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(viewModel.favCount.toString(),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          body: ListView(
              children: viewModel.items
                  .map((_ItemViewModel item) => _createWidget(item))
                  .toList()),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: viewModel.onAddItem,
          //   child: const Icon(Icons.add),
          // ),
        ),
      );

  Widget _createWidget(_ItemViewModel item) {
    if (item is _ListItemViewModel) {
      return _createListItemWidget(item);
    }
    // else if (item is _EmptyItemViewModel) {
    //   return _createEmptyItemWidget(item);
    // }
    else {
      return const Text("EMPTY");
    }
  }

  // Widget _createEmptyItemWidget(_EmptyItemViewModel item) => Column(
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
  //           child: TextField(
  //             onSubmitted: ((value) => item.onCreateItem(value, false)),
  //             autofocus: true,
  //             decoration: InputDecoration(
  //               hintText: item.createItemToolTip,
  //             ),
  //           ),
  //         )
  //       ],
  //     );

  Widget _createListItemWidget(_ListItemViewModel item) => Padding(
        padding: const EdgeInsets.all(5.0),
        child: Card(
            elevation: 1,
            child: ListTile(
              leading: SizedBox(
                width: 310,
                child: Text(
                  item.title,
                  style: const TextStyle(
                      fontSize: 15, overflow: TextOverflow.ellipsis),
                ),
              ),
              trailing: IconButton(
                  onPressed: () {
                    item.addFavItem(!item.favStatus);
                  },
                  icon: item.favStatus
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : const Icon(Icons.favorite_outline)),
            )),
      );
}

class _ViewModel {
  final List<_ItemViewModel> items;
  final int favCount;
  // final Function() onAddItem;

  _ViewModel(
    this.items,
    this.favCount,
    // this.onAddItem
  );

  factory _ViewModel.create(Store<AppState> store) {
    int favCount = store.state.favoriteItems.length;
    List<_ItemViewModel> items = store.state.posts
        // ignore: unnecessary_cast
        .map((ListItem item) =>
            // ignore: unnecessary_cast
            _ListItemViewModel(item.title, item.favStatus, (bool favStatus) {
              if (favStatus) {
                store.dispatch(
                    UpdateItemAction(ListItem(item.id, item.title, favStatus)));
                store.dispatch(AddFavItemAction(FavoriteItem(item.title)));
              } else {
                FavoriteItem favoriteItem = FavoriteItem(item.title);
                store.dispatch(RemoveFavItemAction(favoriteItem));
                store.dispatch(
                    UpdateItemAction(ListItem(item.id, item.title, favStatus)));
              }
            }) as _ItemViewModel)
        .toList();

    return _ViewModel(
      items, favCount,
      //  () => store.dispatch(DisplayListWithNewItemAction()
      //  )
    );
  }
}

abstract class _ItemViewModel {}

@immutable
class _EmptyItemViewModel extends _ItemViewModel {
  final String hint;
  final Function(String, bool) onCreateItem;
  final String createItemToolTip;

  _EmptyItemViewModel(this.hint, this.onCreateItem, this.createItemToolTip);
}

@immutable
class _ListItemViewModel extends _ItemViewModel {
  final String title;
  final bool favStatus;
  final Function(bool) addFavItem;
  _ListItemViewModel(this.title, this.favStatus, this.addFavItem);
}
