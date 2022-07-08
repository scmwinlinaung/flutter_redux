class ListItem {
  int id;
  String title;
  bool favStatus;

  ListItem(this.id, this.title, this.favStatus);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListItem &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          favStatus == other.favStatus;

  @override
  int get hashCode => title.hashCode;
}
