
class Record {

  final String url;

  Record({this.url});
  
  factory Record.fromMap(Map<String, dynamic> data) {

    return Record(url: data['image']);

  }
      
        

  

}