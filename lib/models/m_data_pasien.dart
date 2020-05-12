/// pasien_id : "40"
/// pasien_norm : "00000020"
/// pasien_nama : "NURYATI"
/// pasien_jk : "P"
/// pasien_tempat_lahir : "176"
/// pasien_tanggal_lahir : "1963-07-15"
/// pasien_no_hp : "081329267755"
/// pasien_no_kk : ""
/// m_agama_id : "1"
/// pasien_goldar : ""
/// m_pekerjaan_id : "47"
/// m_pendidikan_id : "3"
/// pasien_suku : ""
/// pasien_jenis_identitas : ""
/// pasien_no_identitas : ""
/// pasien_kewarganegaran : "wni"
/// status_nikah : "NIKAH"
/// pasien_email : ""
/// pasien_alamat : "SIDOREJO RT 3 RW 03 TAMBANGAN MIJEN"
/// pasien_komplek : ""
/// pasien_domisili : ""
/// m_kelurahan_id : "32301"
/// m_kecamatan_id : "3504"
/// m_kabupaten_id : "394"
/// m_propinsi_id : "10"
/// m_negara_id : "104"
/// pasien_keterangan : ""
/// pasien_aktif : "y"
/// pasien_created_by : "MUSTIKAWATI"
/// pasien_created_date : "2019-09-15 23:01:18"
/// pasien_updated_by : null
/// pasien_updated_date : null
/// pasien_revised : "0"
/// reg_company_id : "1"
/// reg_apps_id : "1"
/// pasien_ibu_kandung : "SUKIYATI"
/// pasien_title : "Ny"
/// pasien_rfid : null
/// kota_id : "176"
/// kota_nama : "Kendal"

class MDataPasien {
  String pasienId;
  String pasienNorm;
  String pasienNama;
  String pasienJk;
  String pasienTempatLahir;
  String pasienTanggalLahir;
  String pasienNoHp;
  String pasienNoKk;
  String mAgamaId;
  String pasienGoldar;
  String mPekerjaanId;
  String mPendidikanId;
  String pasienSuku;
  String pasienJenisIdentitas;
  String pasienNoIdentitas;
  String pasienKewarganegaran;
  String statusNikah;
  String pasienEmail;
  String pasienAlamat;
  String pasienKomplek;
  String pasienDomisili;
  String mKelurahanId;
  String mKecamatanId;
  String mKabupatenId;
  String mPropinsiId;
  String mNegaraId;
  String pasienKeterangan;
  String pasienAktif;
  String pasienCreatedBy;
  String pasienCreatedDate;
  dynamic pasienUpdatedBy;
  dynamic pasienUpdatedDate;
  String pasienRevised;
  String regCompanyId;
  String regAppsId;
  String pasienIbuKandung;
  String pasienTitle;
  dynamic pasienRfid;
  String kotaId;
  String kotaNama;

  static MDataPasien fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    MDataPasien mDataPasienBean = MDataPasien();
    mDataPasienBean.pasienId = map['pasien_id'];
    mDataPasienBean.pasienNorm = map['pasien_norm'];
    mDataPasienBean.pasienNama = map['pasien_nama'];
    mDataPasienBean.pasienJk = map['pasien_jk'];
    mDataPasienBean.pasienTempatLahir = map['pasien_tempat_lahir'];
    mDataPasienBean.pasienTanggalLahir = map['pasien_tanggal_lahir'];
    mDataPasienBean.pasienNoHp = map['pasien_no_hp'];
    mDataPasienBean.pasienNoKk = map['pasien_no_kk'];
    mDataPasienBean.mAgamaId = map['m_agama_id'];
    mDataPasienBean.pasienGoldar = map['pasien_goldar'];
    mDataPasienBean.mPekerjaanId = map['m_pekerjaan_id'];
    mDataPasienBean.mPendidikanId = map['m_pendidikan_id'];
    mDataPasienBean.pasienSuku = map['pasien_suku'];
    mDataPasienBean.pasienJenisIdentitas = map['pasien_jenis_identitas'];
    mDataPasienBean.pasienNoIdentitas = map['pasien_no_identitas'];
    mDataPasienBean.pasienKewarganegaran = map['pasien_kewarganegaran'];
    mDataPasienBean.statusNikah = map['status_nikah'];
    mDataPasienBean.pasienEmail = map['pasien_email'];
    mDataPasienBean.pasienAlamat = map['pasien_alamat'];
    mDataPasienBean.pasienKomplek = map['pasien_komplek'];
    mDataPasienBean.pasienDomisili = map['pasien_domisili'];
    mDataPasienBean.mKelurahanId = map['m_kelurahan_id'];
    mDataPasienBean.mKecamatanId = map['m_kecamatan_id'];
    mDataPasienBean.mKabupatenId = map['m_kabupaten_id'];
    mDataPasienBean.mPropinsiId = map['m_propinsi_id'];
    mDataPasienBean.mNegaraId = map['m_negara_id'];
    mDataPasienBean.pasienKeterangan = map['pasien_keterangan'];
    mDataPasienBean.pasienAktif = map['pasien_aktif'];
    mDataPasienBean.pasienCreatedBy = map['pasien_created_by'];
    mDataPasienBean.pasienCreatedDate = map['pasien_created_date'];
    mDataPasienBean.pasienUpdatedBy = map['pasien_updated_by'];
    mDataPasienBean.pasienUpdatedDate = map['pasien_updated_date'];
    mDataPasienBean.pasienRevised = map['pasien_revised'];
    mDataPasienBean.regCompanyId = map['reg_company_id'];
    mDataPasienBean.regAppsId = map['reg_apps_id'];
    mDataPasienBean.pasienIbuKandung = map['pasien_ibu_kandung'];
    mDataPasienBean.pasienTitle = map['pasien_title'];
    mDataPasienBean.pasienRfid = map['pasien_rfid'];
    mDataPasienBean.kotaId = map['kota_id'];
    mDataPasienBean.kotaNama = map['kota_nama'];
    return mDataPasienBean;
  }

  Map toJson() => {
    "pasien_id": pasienId,
    "pasien_norm": pasienNorm,
    "pasien_nama": pasienNama,
    "pasien_jk": pasienJk,
    "pasien_tempat_lahir": pasienTempatLahir,
    "pasien_tanggal_lahir": pasienTanggalLahir,
    "pasien_no_hp": pasienNoHp,
    "pasien_no_kk": pasienNoKk,
    "m_agama_id": mAgamaId,
    "pasien_goldar": pasienGoldar,
    "m_pekerjaan_id": mPekerjaanId,
    "m_pendidikan_id": mPendidikanId,
    "pasien_suku": pasienSuku,
    "pasien_jenis_identitas": pasienJenisIdentitas,
    "pasien_no_identitas": pasienNoIdentitas,
    "pasien_kewarganegaran": pasienKewarganegaran,
    "status_nikah": statusNikah,
    "pasien_email": pasienEmail,
    "pasien_alamat": pasienAlamat,
    "pasien_komplek": pasienKomplek,
    "pasien_domisili": pasienDomisili,
    "m_kelurahan_id": mKelurahanId,
    "m_kecamatan_id": mKecamatanId,
    "m_kabupaten_id": mKabupatenId,
    "m_propinsi_id": mPropinsiId,
    "m_negara_id": mNegaraId,
    "pasien_keterangan": pasienKeterangan,
    "pasien_aktif": pasienAktif,
    "pasien_created_by": pasienCreatedBy,
    "pasien_created_date": pasienCreatedDate,
    "pasien_updated_by": pasienUpdatedBy,
    "pasien_updated_date": pasienUpdatedDate,
    "pasien_revised": pasienRevised,
    "reg_company_id": regCompanyId,
    "reg_apps_id": regAppsId,
    "pasien_ibu_kandung": pasienIbuKandung,
    "pasien_title": pasienTitle,
    "pasien_rfid": pasienRfid,
    "kota_id": kotaId,
    "kota_nama": kotaNama,
  };
}