import 'package:sitediary/datas/user.dart';
import 'to_do_item.dart';

class RemoveItemAction {
  final ToDoItem item;
  RemoveItemAction(this.item);
}

class AddItemAction {
  final ToDoItem item;
  AddItemAction(this.item);
}

class ChangeServerIpAction {
  final String serverIP;
  ChangeServerIpAction(this.serverIP);
}

class DisplayListWithNewItemAction { }

class LoadListAction { }

class SaveListAction {
  @override
  String toString() {
    return  "SaveList overrided toString()";
  }
}

class HttpAction{
  final bool isProcessing;
  HttpAction(this.isProcessing);
}

class ChangeUserSelectedSectionAction{
  final int userSelectedSection;
  ChangeUserSelectedSectionAction(this.userSelectedSection);
}

class UserDoSearchAction{
  final UserSearchOption userSearchOption;
  UserDoSearchAction(this.userSearchOption);
}



