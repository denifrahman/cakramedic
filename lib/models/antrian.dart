/// tanggal_masuk : "2020-02-21 09:19:50"
/// no_registrasi : "RJ21022020-0001"
/// pasien_norm : "00000020"
/// pasien_nama : "NURYATI"
/// unit_nama : "KLINIK SYARAF"
/// no_antrian_dokter : "1"
/// m_pasien_id : "40"
/// pendaftaran_panggil_antrian : "y"
/// pendaftaran_status : "Layani"
/// m_unit_id : "5"
/// pendaftaran_id : "7579"
/// pegawai_nama : "dr. VANIA ANGELINE BACHTIAR, Sp.N"
/// pendaftaran_updated_antrian : "2020-02-21 09:38:26"
/// t_jadwalpraktek_id : "177777"

class Antrian {
  String panggilAntrian;
  String jadwal;
  String tanggalMasuk;
  String noRegistrasi;
  String pasienNorm;
  String pasienNama;
  String unitNama;
  String noAntrianDokter;
  String mPasienId;
  String pendaftaranPanggilAntrian;
  String pendaftaranStatus;
  String mUnitId;
  String pendaftaranId;
  String pegawaiNama;
  String pendaftaranUpdatedAntrian;
  String tJadwalpraktekId;

  static Antrian fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Antrian antrianBean = Antrian();
    antrianBean.panggilAntrian = map['panggil_antrian'];
    antrianBean.jadwal = map['jadwal'];
    antrianBean.tanggalMasuk = map['tanggal_masuk'];
    antrianBean.noRegistrasi = map['no_registrasi'];
    antrianBean.pasienNorm = map['pasien_norm'];
    antrianBean.pasienNama = map['pasien_nama'];
    antrianBean.unitNama = map['unit_nama'];
    antrianBean.noAntrianDokter = map['no_antrian_dokter'];
    antrianBean.mPasienId = map['m_pasien_id'];
    antrianBean.pendaftaranPanggilAntrian = map['pendaftaran_panggil_antrian'];
    antrianBean.pendaftaranStatus = map['pendaftaran_status'];
    antrianBean.mUnitId = map['m_unit_id'];
    antrianBean.pendaftaranId = map['pendaftaran_id'];
    antrianBean.pegawaiNama = map['pegawai_nama'];
    antrianBean.pendaftaranUpdatedAntrian = map['pendaftaran_updated_antrian'];
    antrianBean.tJadwalpraktekId = map['t_jadwalpraktek_id'];
    return antrianBean;
  }

  Map toJson() => {
    "panggil_antrian": panggilAntrian,
    "jadwal": jadwal,
    "tanggal_masuk": tanggalMasuk,
    "no_registrasi": noRegistrasi,
    "pasien_norm": pasienNorm,
    "pasien_nama": pasienNama,
    "unit_nama": unitNama,
    "no_antrian_dokter": noAntrianDokter,
    "m_pasien_id": mPasienId,
    "pendaftaran_panggil_antrian": pendaftaranPanggilAntrian,
    "pendaftaran_status": pendaftaranStatus,
    "m_unit_id": mUnitId,
    "pendaftaran_id": pendaftaranId,
    "pegawai_nama": pegawaiNama,
    "pendaftaran_updated_antrian": pendaftaranUpdatedAntrian,
    "t_jadwalpraktek_id": tJadwalpraktekId,
  };
}