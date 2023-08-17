class DataModel {
  String name;
  int id;
  double score;
  String address;
  List <DataModel> mylist=[];


  DataModel(this.name, this.id, this.score, this.address);

  factory DataModel.fromJson(Map<String, dynamic> json) {

    return DataModel(
      json['name'] as String,
      json['id'] as int,
      json['score'] as double,
      json['address'] as String,
    );
  }
  Map <String,dynamic> mymap={'name':"asad",'id':233,};

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'score': score,
      'address': address,
    };
  }

  String toJson() {
    return toMap().toString();
  }
}
