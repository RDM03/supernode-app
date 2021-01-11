import 'package:fish_redux/fish_redux.dart';

enum OrganizationsAction { onUpdate, selectedItem }

class OrganizationsActionCreator {
  static Action onUpdate() {
    return const Action(OrganizationsAction.onUpdate);
  }

  static Action selectedItem(String id, String name) {
    return Action(OrganizationsAction.selectedItem,
        payload: {'id': id, 'name': name});
  }
}
