class Store{
  String? store_id;
  String? name;
  String? url;
  Store({this.name, this.store_id, this.url});
  factory Store.fromMap(Map<String, dynamic> map){
    return Store(
      store_id: map['store_id'],
      name: map['name'],
      url: map['url']
    );
  }
}