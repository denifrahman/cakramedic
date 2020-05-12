/// penjamin_id : "24"
/// m_group_penjamin_id : "4"
/// penjamin_kode : "fasfa"
/// penjamin_nama : "testing saja"
/// penjamin_alamat : "dad"
/// penjamin_telp : "021-43434"
/// m_kota_id : null
/// penjamin_admri_persen : null
/// penjamin_admri_rupiah : null
/// penjamin_aktif : "t"
/// penjamin_created_by : "Super Admin"
/// penjamin_created_date : "2020-01-23 10:08:27"
/// penjamin_updated_by : "Super Admin"
/// penjamin_updated_date : "2020-01-23 11:05:08"
/// penjamin_revised : "0"
/// reg_company_id : "1"
/// reg_apps_id : "1"
/// m_jenistarif_id : "4"

class MPenjamin {
  String penjaminId;
  String mGroupPenjaminId;
  String penjaminKode;
  String penjaminNama;
  String penjaminAlamat;
  String penjaminTelp;
  dynamic mKotaId;
  dynamic penjaminAdmriPersen;
  dynamic penjaminAdmriRupiah;
  String penjaminAktif;
  String penjaminCreatedBy;
  String penjaminCreatedDate;
  String penjaminUpdatedBy;
  String penjaminUpdatedDate;
  String penjaminRevised;
  String regCompanyId;
  String regAppsId;
  String mJenistarifId;

  static MPenjamin fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    MPenjamin mPenjaminBean = MPenjamin();
    mPenjaminBean.penjaminId = map['penjamin_id'];
    mPenjaminBean.mGroupPenjaminId = map['m_group_penjamin_id'];
    mPenjaminBean.penjaminKode = map['penjamin_kode'];
    mPenjaminBean.penjaminNama = map['penjamin_nama'];
    mPenjaminBean.penjaminAlamat = map['penjamin_alamat'];
    mPenjaminBean.penjaminTelp = map['penjamin_telp'];
    mPenjaminBean.mKotaId = map['m_kota_id'];
    mPenjaminBean.penjaminAdmriPersen = map['penjamin_admri_persen'];
    mPenjaminBean.penjaminAdmriRupiah = map['penjamin_admri_rupiah'];
    mPenjaminBean.penjaminAktif = map['penjamin_aktif'];
    mPenjaminBean.penjaminCreatedBy = map['penjamin_created_by'];
    mPenjaminBean.penjaminCreatedDate = map['penjamin_created_date'];
    mPenjaminBean.penjaminUpdatedBy = map['penjamin_updated_by'];
    mPenjaminBean.penjaminUpdatedDate = map['penjamin_updated_date'];
    mPenjaminBean.penjaminRevised = map['penjamin_revised'];
    mPenjaminBean.regCompanyId = map['reg_company_id'];
    mPenjaminBean.regAppsId = map['reg_apps_id'];
    mPenjaminBean.mJenistarifId = map['m_jenistarif_id'];
    return mPenjaminBean;
  }

  Map toJson() => {
    "penjamin_id": penjaminId,
    "m_group_penjamin_id": mGroupPenjaminId,
    "penjamin_kode": penjaminKode,
    "penjamin_nama": penjaminNama,
    "penjamin_alamat": penjaminAlamat,
    "penjamin_telp": penjaminTelp,
    "m_kota_id": mKotaId,
    "penjamin_admri_persen": penjaminAdmriPersen,
    "penjamin_admri_rupiah": penjaminAdmriRupiah,
    "penjamin_aktif": penjaminAktif,
    "penjamin_created_by": penjaminCreatedBy,
    "penjamin_created_date": penjaminCreatedDate,
    "penjamin_updated_by": penjaminUpdatedBy,
    "penjamin_updated_date": penjaminUpdatedDate,
    "penjamin_revised": penjaminRevised,
    "reg_company_id": regCompanyId,
    "reg_apps_id": regAppsId,
    "m_jenistarif_id": mJenistarifId,
  };
}