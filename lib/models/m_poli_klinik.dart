/// unit_id : "1"
/// unit_kode : "KU"
/// unit_nama : "KLINIK UMUM"
/// m_instalasi_id : "1"
/// unit_keterangan : null
/// unit_aktif : "t"
/// unit_created_by : "INJECT"
/// unit_created_date : "2019-08-06 11:46:48"
/// unit_updated_by : null
/// unit_updated_date : null
/// unit_revised : "0"
/// reg_company_id : "1"
/// reg_apps_id : "1"
/// unit_kode_bpjs : null
/// m_depobarang_id : "1"

class MPoliKlinik {
  String unitId;
  String unitKode;
  String unitNama;
  String mInstalasiId;
  dynamic unitKeterangan;
  String unitAktif;
  String unitCreatedBy;
  String unitCreatedDate;
  dynamic unitUpdatedBy;
  dynamic unitUpdatedDate;
  String unitRevised;
  String regCompanyId;
  String regAppsId;
  dynamic unitKodeBpjs;
  String mDepobarangId;

  static MPoliKlinik fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    MPoliKlinik mPoliKlinikBean = MPoliKlinik();
    mPoliKlinikBean.unitId = map['unit_id'];
    mPoliKlinikBean.unitKode = map['unit_kode'];
    mPoliKlinikBean.unitNama = map['unit_nama'];
    mPoliKlinikBean.mInstalasiId = map['m_instalasi_id'];
    mPoliKlinikBean.unitKeterangan = map['unit_keterangan'];
    mPoliKlinikBean.unitAktif = map['unit_aktif'];
    mPoliKlinikBean.unitCreatedBy = map['unit_created_by'];
    mPoliKlinikBean.unitCreatedDate = map['unit_created_date'];
    mPoliKlinikBean.unitUpdatedBy = map['unit_updated_by'];
    mPoliKlinikBean.unitUpdatedDate = map['unit_updated_date'];
    mPoliKlinikBean.unitRevised = map['unit_revised'];
    mPoliKlinikBean.regCompanyId = map['reg_company_id'];
    mPoliKlinikBean.regAppsId = map['reg_apps_id'];
    mPoliKlinikBean.unitKodeBpjs = map['unit_kode_bpjs'];
    mPoliKlinikBean.mDepobarangId = map['m_depobarang_id'];
    return mPoliKlinikBean;
  }

  Map toJson() => {
    "unit_id": unitId,
    "unit_kode": unitKode,
    "unit_nama": unitNama,
    "m_instalasi_id": mInstalasiId,
    "unit_keterangan": unitKeterangan,
    "unit_aktif": unitAktif,
    "unit_created_by": unitCreatedBy,
    "unit_created_date": unitCreatedDate,
    "unit_updated_by": unitUpdatedBy,
    "unit_updated_date": unitUpdatedDate,
    "unit_revised": unitRevised,
    "reg_company_id": regCompanyId,
    "reg_apps_id": regAppsId,
    "unit_kode_bpjs": unitKodeBpjs,
    "m_depobarang_id": mDepobarangId,
  };
}