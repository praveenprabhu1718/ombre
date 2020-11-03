class Event{
  String name;
  String imageUrl;
  List categories;

  Event({this.name, this.imageUrl, this.categories});

  Event.fromMap(Map<String,dynamic> map){
    this.name = map['event_name'];
    this.categories = map['categories'];
    this.imageUrl = map['imageUrl'];
  }
}