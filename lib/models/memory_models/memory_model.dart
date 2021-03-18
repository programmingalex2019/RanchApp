class MemoryModel {
  
  final String description;
  final String timeStamp;
  final String id;
  final String image;
  final String addedBy;
  MemoryModel({this.description, this.timeStamp, this.id, this.image , this.addedBy});

  factory MemoryModel.fromJson(Map<String, dynamic> data) {
    return MemoryModel(
      description: data['description'],
      timeStamp: data['timeStamp'],
      id: data['id'],
      image: data['image'],
      addedBy: data['addedBy'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': this.description,
      'timeStamp': this.timeStamp,
      'id': this.id,
      'image': this.image,
      'addedBy': this.addedBy,
    };
  }
}
