class Durasi {
  String id;
  String jam;


  Durasi(
      String id,
      String jam,

      ) {

    this.id= id;
    this.jam = jam;

  }

  Durasi.fromJson(Map json)
      : id = json['id'],
        jam = json['penjamin_id'];


  Map toJson() {
    return {
      'id': id,
      'jam': jam,

    };
  }
}
