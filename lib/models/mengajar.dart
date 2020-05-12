class Mengajar {
  String id;
  String tgl_ins;
  String tgl_ngajar;
  String id_pelanggan;
  String id_guru;
  String nama;
  String nama_siswa;
  String alamat;
  String no_telp;
  String telp_wali;
  String biaya;
  String id_member;
  String jadwal_les;

  Mengajar(
  String id,
  String tgl_ins,
  String tgl_ngajar,
  String id_pelanggan,
  String id_guru,
  String nama,
  String nama_siswa,
      String alamat,
      String no_telp,
      String telp_wali,
      String biaya,
      String id_member,
      String jadwal_les
      ) {

    this.id = id;
    this.tgl_ins = tgl_ins;
    this.tgl_ngajar = tgl_ngajar;
    this.id_pelanggan = id_pelanggan;
    this.id_guru = id_guru;
    this.nama = nama;
    this.nama_siswa = nama_siswa;
    this.alamat = alamat;
    this.no_telp = no_telp;
    this.telp_wali = telp_wali;
    this.biaya= biaya;
    this.id_member= id_member;
    this.jadwal_les= jadwal_les;
  }

  Mengajar.fromJson(Map json)
      : id = json['id'],
        tgl_ins = json['tgl_ins'],
        tgl_ngajar= json['tgl_ngajar'],
        id_pelanggan = json['id_pelanggan'],
        id_guru = json['id_guru'],
        nama = json['nama'],
        nama_siswa = json['nama_siswa'],
        alamat= json['alamat'],
        no_telp= json['no_telp'],
        telp_wali= json['telp_wali'],
        biaya= json['biaya'],
        id_member= json['id_member'],
        jadwal_les= json['jadwal_les'];

  Map toJson() {
    return {
      'id': id,
      'tgl_ins': tgl_ins,
      'tgl_ngajar':tgl_ngajar,
      'id_pelanggan': id_pelanggan,
      'id_guru': id_guru,
      'nama':nama,
      'nama_siswa':nama_siswa,
      'alamat':alamat,
      'no_telp':no_telp,
      'telp_wali':telp_wali,
      'biaya':biaya,
      'id_member':id_member,
      'jadwal_les':jadwal_les
    };
  }
}
