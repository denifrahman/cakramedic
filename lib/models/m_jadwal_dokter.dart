/// jadwalpraktek_id : "14571"
/// jadwalpraktek_tanggal : "2020-01-28"
/// m_pegawai_id : "79"
/// m_unit_id : "8"
/// jadwalpraktek_hari : "Selasa"
/// jadwalpraktek_jam_awal : "00:00:00"
/// jadwalpraktek_jam_akhir : "00:00:00"
/// jadwalpraktek_kuota : "10"
/// jadwalpraktek_aktif : "y"
/// jadwalpraktek_created_by : "Super Admin"
/// jadwalpraktek_created_date : "2020-01-19 23:06:46"
/// jadwalpraktek_updated_by : null
/// jadwalpraktek_updated_date : null
/// jadwalpraktek_revised : "0"
/// reg_company_id : "1"
/// reg_apps_id : "1"
/// pegawai_nik : null
/// pegawai_nama : "dr. DIPDHA ARUM SANGORA"
/// pegawai_no : "1222"
/// pegawai_kategori : "DOKTER UMUM"
/// unit_nama : "KLINIK VCT"

class MJadwalDokter {
  String jadwalpraktekId;
  String jadwalpraktekTanggal;
  String mPegawaiId;
  String mUnitId;
  String jadwalpraktekHari;
  String jadwalpraktekJamAwal;
  String jadwalpraktekJamAkhir;
  String jadwalpraktekKuota;
  String jadwalpraktekAktif;
  String jadwalpraktekCreatedBy;
  String jadwalpraktekCreatedDate;
  dynamic jadwalpraktekUpdatedBy;
  dynamic jadwalpraktekUpdatedDate;
  String jadwalpraktekRevised;
  String regCompanyId;
  String regAppsId;
  dynamic pegawaiNik;
  String pegawaiNama;
  String pegawaiNo;
  String pegawaiKategori;
  String unitNama;

  static MJadwalDokter fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    MJadwalDokter mJadwalDokterBean = MJadwalDokter();
    mJadwalDokterBean.jadwalpraktekId = map['jadwalpraktek_id'];
    mJadwalDokterBean.jadwalpraktekTanggal = map['jadwalpraktek_tanggal'];
    mJadwalDokterBean.mPegawaiId = map['m_pegawai_id'];
    mJadwalDokterBean.mUnitId = map['m_unit_id'];
    mJadwalDokterBean.jadwalpraktekHari = map['jadwalpraktek_hari'];
    mJadwalDokterBean.jadwalpraktekJamAwal = map['jadwalpraktek_jam_awal'];
    mJadwalDokterBean.jadwalpraktekJamAkhir = map['jadwalpraktek_jam_akhir'];
    mJadwalDokterBean.jadwalpraktekKuota = map['jadwalpraktek_kuota'];
    mJadwalDokterBean.jadwalpraktekAktif = map['jadwalpraktek_aktif'];
    mJadwalDokterBean.jadwalpraktekCreatedBy = map['jadwalpraktek_created_by'];
    mJadwalDokterBean.jadwalpraktekCreatedDate = map['jadwalpraktek_created_date'];
    mJadwalDokterBean.jadwalpraktekUpdatedBy = map['jadwalpraktek_updated_by'];
    mJadwalDokterBean.jadwalpraktekUpdatedDate = map['jadwalpraktek_updated_date'];
    mJadwalDokterBean.jadwalpraktekRevised = map['jadwalpraktek_revised'];
    mJadwalDokterBean.regCompanyId = map['reg_company_id'];
    mJadwalDokterBean.regAppsId = map['reg_apps_id'];
    mJadwalDokterBean.pegawaiNik = map['pegawai_nik'];
    mJadwalDokterBean.pegawaiNama = map['pegawai_nama'];
    mJadwalDokterBean.pegawaiNo = map['pegawai_no'];
    mJadwalDokterBean.pegawaiKategori = map['pegawai_kategori'];
    mJadwalDokterBean.unitNama = map['unit_nama'];
    return mJadwalDokterBean;
  }

  Map toJson() => {
    "jadwalpraktek_id": jadwalpraktekId,
    "jadwalpraktek_tanggal": jadwalpraktekTanggal,
    "m_pegawai_id": mPegawaiId,
    "m_unit_id": mUnitId,
    "jadwalpraktek_hari": jadwalpraktekHari,
    "jadwalpraktek_jam_awal": jadwalpraktekJamAwal,
    "jadwalpraktek_jam_akhir": jadwalpraktekJamAkhir,
    "jadwalpraktek_kuota": jadwalpraktekKuota,
    "jadwalpraktek_aktif": jadwalpraktekAktif,
    "jadwalpraktek_created_by": jadwalpraktekCreatedBy,
    "jadwalpraktek_created_date": jadwalpraktekCreatedDate,
    "jadwalpraktek_updated_by": jadwalpraktekUpdatedBy,
    "jadwalpraktek_updated_date": jadwalpraktekUpdatedDate,
    "jadwalpraktek_revised": jadwalpraktekRevised,
    "reg_company_id": regCompanyId,
    "reg_apps_id": regAppsId,
    "pegawai_nik": pegawaiNik,
    "pegawai_nama": pegawaiNama,
    "pegawai_no": pegawaiNo,
    "pegawai_kategori": pegawaiKategori,
    "unit_nama": unitNama,
  };
}