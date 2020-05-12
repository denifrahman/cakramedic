/// pegawai_nama : "dr. TOMMY,Sp.B."
/// m_pegawai_id : "90"
/// m_unit_id : "6"
/// jadwal : [{"jadwaldokter_jam_awal":"08:00","jadwaldokter_jam_akhir":"11:00","m_pegawai_id":"90","jadwaldokter_hari":"Senin","m_unit_id":"6","urut":"1"},{"jadwaldokter_jam_awal":"08:00","jadwaldokter_jam_akhir":"11:00","m_pegawai_id":"90","jadwaldokter_hari":"Selasa","m_unit_id":"6","urut":"2"},{"jadwaldokter_jam_awal":"08:00","jadwaldokter_jam_akhir":"11:00","m_pegawai_id":"90","jadwaldokter_hari":"Rabu","m_unit_id":"6","urut":"3"},{"jadwaldokter_jam_awal":"08:00","jadwaldokter_jam_akhir":"11:00","m_pegawai_id":"90","jadwaldokter_hari":"Kamis","m_unit_id":"6","urut":"4"},{"jadwaldokter_jam_awal":"08:00","jadwaldokter_jam_akhir":"11:00","m_pegawai_id":"90","jadwaldokter_hari":"Jumat","m_unit_id":"6","urut":"5"},{"jadwaldokter_jam_awal":"05:00","jadwaldokter_jam_akhir":"08:00","m_pegawai_id":"90","jadwaldokter_hari":"Sabtu","m_unit_id":"6","urut":"6"}]

class MasterJadwalDokter {
  String pegawaiNama;
  String mPegawaiId;
  String mUnitId;
  List<JadwalBean> jadwal;

  static MasterJadwalDokter fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    MasterJadwalDokter masterJadwalDokterBean = MasterJadwalDokter();
    masterJadwalDokterBean.pegawaiNama = map['pegawai_nama'];
    masterJadwalDokterBean.mPegawaiId = map['m_pegawai_id'];
    masterJadwalDokterBean.mUnitId = map['m_unit_id'];
    masterJadwalDokterBean.jadwal = List()..addAll(
      (map['jadwal'] as List ?? []).map((o) => JadwalBean.fromMap(o))
    );
    return masterJadwalDokterBean;
  }

  Map toJson() => {
    "pegawai_nama": pegawaiNama,
    "m_pegawai_id": mPegawaiId,
    "m_unit_id": mUnitId,
    "jadwal": jadwal,
  };
}

/// jadwaldokter_jam_awal : "08:00"
/// jadwaldokter_jam_akhir : "11:00"
/// m_pegawai_id : "90"
/// jadwaldokter_hari : "Senin"
/// m_unit_id : "6"
/// urut : "1"

class JadwalBean {
  String jadwaldokterJamAwal;
  String jadwaldokterJamAkhir;
  String mPegawaiId;
  String jadwaldokterHari;
  String mUnitId;
  String urut;

  static JadwalBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    JadwalBean jadwalBean = JadwalBean();
    jadwalBean.jadwaldokterJamAwal = map['jadwaldokter_jam_awal'];
    jadwalBean.jadwaldokterJamAkhir = map['jadwaldokter_jam_akhir'];
    jadwalBean.mPegawaiId = map['m_pegawai_id'];
    jadwalBean.jadwaldokterHari = map['jadwaldokter_hari'];
    jadwalBean.mUnitId = map['m_unit_id'];
    jadwalBean.urut = map['urut'];
    return jadwalBean;
  }

  Map toJson() => {
    "jadwaldokter_jam_awal": jadwaldokterJamAwal,
    "jadwaldokter_jam_akhir": jadwaldokterJamAkhir,
    "m_pegawai_id": mPegawaiId,
    "jadwaldokter_hari": jadwaldokterHari,
    "m_unit_id": mUnitId,
    "urut": urut,
  };
}