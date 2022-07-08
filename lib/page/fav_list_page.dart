// ignore_for_file: unnecessary_cast

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:to_do_list_with_redux/model/favoriteItem.dart';
import '../state/state.dart';

class FavListPage extends StatelessWidget {
  const FavListPage({super.key});

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel.create(store),
        builder: (BuildContext context, _ViewModel viewModel) => Scaffold(
          appBar: AppBar(
            title: const Text('Fav',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          body: ListView(
              children: viewModel.items
                  .map((_ItemViewModel item) => _createWidget(item))
                  .toList()),
        ),
      );

  Widget _createWidget(_ItemViewModel item) {
    if (item is _FavItemViewModel) {
      return _createPostWidget(item);
    } else {
      return const Text("EMPTY");
    }
  }

  Widget _createPostWidget(_FavItemViewModel item) => Padding(
        padding: const EdgeInsets.all(5.0),
        child: Card(
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              item.title,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ),
      );
}

class _ViewModel {
  final List<_ItemViewModel> items;
  _ViewModel(this.items);

  factory _ViewModel.create(Store<AppState> store) {
    List<_ItemViewModel> favItems = store.state.favoriteItems
        .map((FavoriteItem e) => _FavItemViewModel(e.title) as _ItemViewModel)
        .toList();
    return _ViewModel(favItems);
  }
}

abstract class _ItemViewModel {}

@immutable
class _FavItemViewModel extends _ItemViewModel {
  final String title;

  _FavItemViewModel(this.title);
}
