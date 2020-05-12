class Detail_megajar {
  String id;
  String id_mengajar;
  String nama_pelajaran;
  String nama_materi;
  String tgl_ngajar;
  String durasi;
  String status;

  Detail_megajar(
  String id,
  String id_mengajar,
  String nama_pelajaran,
  String nama_materi,
  String tgl_ngajar,
  String durasi,
  String status,
  ) {

    this.id = id;
    this.id_mengajar = id_mengajar;
    this.nama_pelajaran = nama_pelajaran;
    this.nama_materi= nama_materi;
    this.tgl_ngajar = tgl_ngajar;
    this.durasi = durasi;
    this.status = status;
  }

  Detail_megajar.fromJson(Map json)
      : id = json['id'],
        id_mengajar = json['id_mengajar'],
        nama_pelajaran = json['nama_pelajaran'],
        nama_materi = json['nama_materi'],
        tgl_ngajar= json['tgl_ngajar'],
        durasi = json['durasi'],
        status = json['status'];

  Map toJson() {
    return {
      'id': id,
      'id_mengajar': id_mengajar,
      'nama_pelajaran': nama_pelajaran,
      'nama_materi':nama_materi,
      'tgl_ngajar':tgl_ngajar,
      'durasi':durasi,
      'status':status,
    };
  }
}
