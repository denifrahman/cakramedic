class User {
  String id;
  String nama_siswa;
  String alamat;
  String email;
  String no_telp;
  String lat;
  String long;
  String nama_wali;
  String id_fungsionalitas;
  String id_hak_akses;
  String nama_fungsionalitas;
  String nama_hak_akses;

  User(
  String id,
  String nama_siswa,
  String alamat,
  String email,
  String no_telp,
  String lat,
  String long,
  String nama_wali,
  String id_fungsionalitas,
  String id_hak_akses,
  String nama_fungsionalitas,
  String nama_hak_akses)

  {
    this.id = id;
    this.nama_siswa =nama_siswa;
    this.alamat = alamat;
    this.email =email;
    this.no_telp=no_telp;
    this.lat=lat;
    this.long=long;
    this.nama_wali=nama_wali;
    this.id_fungsionalitas=id_fungsionalitas;
    this.id_hak_akses=id_hak_akses;
    this.nama_fungsionalitas=nama_fungsionalitas;
    this.nama_hak_akses=nama_hak_akses;
  }

  User.fromJson(Map json)
      : id = json['id'],
        nama_siswa = json['nama_siswa'],
        alamat = json['alamat'],
        email = json['email'],
        no_telp = json['no_telp'],
        lat = json['lat'],
        long = json['long'],
        nama_wali = json['nama_wali'],
        id_fungsionalitas = json['id_fungsionalitas'],
        id_hak_akses = json['id_hak_akses'],
        nama_fungsionalitas = json['nama_fungsionalitas'],
        nama_hak_akses = json['nama_hak_akses'];

  Map toJson() {
    return {
      'id': id,
      'nama_siswa': nama_siswa,
      'alamat': alamat,
      'email': email,
      'no_telp':no_telp,
      'lat': lat,
      'long': long,
      'id_fungsionalitas': id_fungsionalitas,
      'id_hak_akes': id_hak_akses,
      'nama_fungsionalitas':nama_fungsionalitas,
      'nama_hak_akses':nama_hak_akses
    };
  }
}
