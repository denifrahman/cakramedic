/// jenis_antrian_id : "1"
/// jenis_antrian_nama : "UMUM"
/// jenis_antrian_label : "A"
/// jenis_antrian_awalnomor : "1"
/// jenis_antrian_warna : null
/// jenis_antrian_keterangan : null
/// jenis_antrian_aktif : "y"
/// jenis_antrian_created_by : null
/// jenis_antrian_created_date : null
/// jenis_antrian_updated_by : null
/// jenis_antrian_updated_date : null
/// jenis_antrian_revised : "0"
/// reg_company_id : "1"
/// reg_apps_id : "1"

class JenisAntrian {
  String jenisAntrianId;
  String jenisAntrianNama;
  String jenisAntrianLabel;
  String jenisAntrianAwalnomor;
  dynamic jenisAntrianWarna;
  dynamic jenisAntrianKeterangan;
  String jenisAntrianAktif;
  dynamic jenisAntrianCreatedBy;
  dynamic jenisAntrianCreatedDate;
  dynamic jenisAntrianUpdatedBy;
  dynamic jenisAntrianUpdatedDate;
  String jenisAntrianRevised;
  String regCompanyId;
  String regAppsId;

  static JenisAntrian fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    JenisAntrian jenisAntrianBean = JenisAntrian();
    jenisAntrianBean.jenisAntrianId = map['jenis_antrian_id'];
    jenisAntrianBean.jenisAntrianNama = map['jenis_antrian_nama'];
    jenisAntrianBean.jenisAntrianLabel = map['jenis_antrian_label'];
    jenisAntrianBean.jenisAntrianAwalnomor = map['jenis_antrian_awalnomor'];
    jenisAntrianBean.jenisAntrianWarna = map['jenis_antrian_warna'];
    jenisAntrianBean.jenisAntrianKeterangan = map['jenis_antrian_keterangan'];
    jenisAntrianBean.jenisAntrianAktif = map['jenis_antrian_aktif'];
    jenisAntrianBean.jenisAntrianCreatedBy = map['jenis_antrian_created_by'];
    jenisAntrianBean.jenisAntrianCreatedDate = map['jenis_antrian_created_date'];
    jenisAntrianBean.jenisAntrianUpdatedBy = map['jenis_antrian_updated_by'];
    jenisAntrianBean.jenisAntrianUpdatedDate = map['jenis_antrian_updated_date'];
    jenisAntrianBean.jenisAntrianRevised = map['jenis_antrian_revised'];
    jenisAntrianBean.regCompanyId = map['reg_company_id'];
    jenisAntrianBean.regAppsId = map['reg_apps_id'];
    return jenisAntrianBean;
  }

  Map toJson() => {
    "jenis_antrian_id": jenisAntrianId,
    "jenis_antrian_nama": jenisAntrianNama,
    "jenis_antrian_label": jenisAntrianLabel,
    "jenis_antrian_awalnomor": jenisAntrianAwalnomor,
    "jenis_antrian_warna": jenisAntrianWarna,
    "jenis_antrian_keterangan": jenisAntrianKeterangan,
    "jenis_antrian_aktif": jenisAntrianAktif,
    "jenis_antrian_created_by": jenisAntrianCreatedBy,
    "jenis_antrian_created_date": jenisAntrianCreatedDate,
    "jenis_antrian_updated_by": jenisAntrianUpdatedBy,
    "jenis_antrian_updated_date": jenisAntrianUpdatedDate,
    "jenis_antrian_revised": jenisAntrianRevised,
    "reg_company_id": regCompanyId,
    "reg_apps_id": regAppsId,
  };
}