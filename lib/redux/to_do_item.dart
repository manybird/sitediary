import 'package:json_annotation/json_annotation.dart';

part 'to_do_item.g.dart';

@JsonSerializable()
class ToDoItem {
  String title;

  ToDoItem();

  @override
  bool operator == (Object other) {
    return identical(this, other) ||
        other is ToDoItem && runtimeType == other.runtimeType &&
            title == other.title;
  }

  factory ToDoItem.fromJson(Map<String, dynamic> json) {
    return _$ToDoItemFromJson(json);
  }

  dynamic toJson()=> _$ToDoItemToJson (this);

  factory ToDoItem.fromTitle(String title) {
    return ToDoItem()..title = title ;
  }

  @override
  int get hashCode => title.hashCode;
}
