import 'dart:async';
import 'dart:convert' as convert;

import 'package:redux/redux.dart';
import 'package:http/http.dart' as http;
import 'package:to_do_list_with_redux/model/to_do_item.dart';

import '../action/actions.dart';
import '../state/state.dart';

List<Middleware<AppState>> createStoreMiddleware() => [
      TypedMiddleware<AppState, FetchListAction>(_fetchList),
    ];

Future _fetchList(Store<AppState> store, action, NextDispatcher next) async {
  if (action is FetchListAction) {
    try {
      final uri = Uri.parse("https://jsonplaceholder.typicode.com/posts");
      final response = await http.get(uri);

      final res = convert.jsonDecode(response.body) as List;
      List<ListItem> list =
          res.map((e) => ListItem(e['id'], e['title'], false)).toList();
      store.dispatch(FetchListSuccessAction(list));
    } catch (e) {
      store.dispatch(FetchListFailAction(e));
    }
  }
  next(action);
}
