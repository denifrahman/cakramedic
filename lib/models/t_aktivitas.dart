/// pendaftaran_id : "2208"
/// no_registrasi : ""
/// tanggal_masuk : "2020-02-06 11:31:09.50118"
/// tanggal_keluar : null
/// m_unit_id : "12"
/// m_pasien_id : "40"
/// m_pegawai_id : "82"
/// m_penjamin_id : "1"
/// m_kelas_id : "1"
/// m_biayamasuk_id : null
/// m_caramasuk_id : null
/// m_shift_id : "0"
/// pendaftaran_id_asal : "0"
/// status_kunjungan : "L"
/// m_nonpasien_id : "0"
/// m_instalasi_id : "1"
/// pendaftaran_status : ""
/// t_jadwalpraktek_id : "15569"
/// pendaftaran_cito : "t"
/// pendaftaran_noresep : null
/// m_paket_id : null
/// pendaftaran_keterangan : null
/// pendaftaran_aktif : "y"
/// pendaftaran_created_date : "2020-02-06 11:31:09.50168"
/// pendaftaran_created_by : "Android"
/// pendaftaran_updated_date : null
/// pendaftaran_updated_by : null
/// pendaftaran_revised : null
/// reg_company_id : null
/// reg_apps_id : null
/// t_orderpenunjang_id : null
/// t_orderresep_id : null
/// no_antrian_dokter : "1"
/// m_klaim_id : null
/// alasan : null
/// tgl_booking : "2020-02-10 00:00:00"
/// kodebooking : "05436"
/// statusbooking : "BOOKING"
/// statuskonfirmasi : null
/// unit_nama : "KLINIK GIGI"
/// pegawai_nama : "drg. GUFA BAGUS PAMUNGKAS"

class TAktivitas {
  String pendaftaranId;
  String noRegistrasi;
  String tanggalMasuk;
  dynamic tanggalKeluar;
  String mUnitId;
  String mPasienId;
  String mPegawaiId;
  String mPenjaminId;
  String mKelasId;
  dynamic mBiayamasukId;
  dynamic mCaramasukId;
  String mShiftId;
  String pendaftaranIdAsal;
  String statusKunjungan;
  String mNonpasienId;
  String mInstalasiId;
  String pendaftaranStatus;
  String tJadwalpraktekId;
  String pendaftaranCito;
  dynamic pendaftaranNoresep;
  dynamic mPaketId;
  dynamic pendaftaranKeterangan;
  String pendaftaranAktif;
  String pendaftaranCreatedDate;
  String pendaftaranCreatedBy;
  dynamic pendaftaranUpdatedDate;
  dynamic pendaftaranUpdatedBy;
  dynamic pendaftaranRevised;
  dynamic regCompanyId;
  dynamic regAppsId;
  dynamic tOrderpenunjangId;
  dynamic tOrderresepId;
  String noAntrianDokter;
  dynamic mKlaimId;
  dynamic alasan;
  String tglBooking;
  String kodebooking;
  String statusbooking;
  dynamic statuskonfirmasi;
  String unitNama;
  String pegawaiNama;

  static TAktivitas fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    TAktivitas tAktivitasBean = TAktivitas();
    tAktivitasBean.pendaftaranId = map['pendaftaran_id'];
    tAktivitasBean.noRegistrasi = map['no_registrasi'];
    tAktivitasBean.tanggalMasuk = map['tanggal_masuk'];
    tAktivitasBean.tanggalKeluar = map['tanggal_keluar'];
    tAktivitasBean.mUnitId = map['m_unit_id'];
    tAktivitasBean.mPasienId = map['m_pasien_id'];
    tAktivitasBean.mPegawaiId = map['m_pegawai_id'];
    tAktivitasBean.mPenjaminId = map['m_penjamin_id'];
    tAktivitasBean.mKelasId = map['m_kelas_id'];
    tAktivitasBean.mBiayamasukId = map['m_biayamasuk_id'];
    tAktivitasBean.mCaramasukId = map['m_caramasuk_id'];
    tAktivitasBean.mShiftId = map['m_shift_id'];
    tAktivitasBean.pendaftaranIdAsal = map['pendaftaran_id_asal'];
    tAktivitasBean.statusKunjungan = map['status_kunjungan'];
    tAktivitasBean.mNonpasienId = map['m_nonpasien_id'];
    tAktivitasBean.mInstalasiId = map['m_instalasi_id'];
    tAktivitasBean.pendaftaranStatus = map['pendaftaran_status'];
    tAktivitasBean.tJadwalpraktekId = map['t_jadwalpraktek_id'];
    tAktivitasBean.pendaftaranCito = map['pendaftaran_cito'];
    tAktivitasBean.pendaftaranNoresep = map['pendaftaran_noresep'];
    tAktivitasBean.mPaketId = map['m_paket_id'];
    tAktivitasBean.pendaftaranKeterangan = map['pendaftaran_keterangan'];
    tAktivitasBean.pendaftaranAktif = map['pendaftaran_aktif'];
    tAktivitasBean.pendaftaranCreatedDate = map['pendaftaran_created_date'];
    tAktivitasBean.pendaftaranCreatedBy = map['pendaftaran_created_by'];
    tAktivitasBean.pendaftaranUpdatedDate = map['pendaftaran_updated_date'];
    tAktivitasBean.pendaftaranUpdatedBy = map['pendaftaran_updated_by'];
    tAktivitasBean.pendaftaranRevised = map['pendaftaran_revised'];
    tAktivitasBean.regCompanyId = map['reg_company_id'];
    tAktivitasBean.regAppsId = map['reg_apps_id'];
    tAktivitasBean.tOrderpenunjangId = map['t_orderpenunjang_id'];
    tAktivitasBean.tOrderresepId = map['t_orderresep_id'];
    tAktivitasBean.noAntrianDokter = map['no_antrian_dokter'];
    tAktivitasBean.mKlaimId = map['m_klaim_id'];
    tAktivitasBean.alasan = map['alasan'];
    tAktivitasBean.tglBooking = map['tgl_booking'];
    tAktivitasBean.kodebooking = map['kodebooking'];
    tAktivitasBean.statusbooking = map['statusbooking'];
    tAktivitasBean.statuskonfirmasi = map['statuskonfirmasi'];
    tAktivitasBean.unitNama = map['unit_nama'];
    tAktivitasBean.pegawaiNama = map['pegawai_nama'];
    return tAktivitasBean;
  }

  Map toJson() => {
    "pendaftaran_id": pendaftaranId,
    "no_registrasi": noRegistrasi,
    "tanggal_masuk": tanggalMasuk,
    "tanggal_keluar": tanggalKeluar,
    "m_unit_id": mUnitId,
    "m_pasien_id": mPasienId,
    "m_pegawai_id": mPegawaiId,
    "m_penjamin_id": mPenjaminId,
    "m_kelas_id": mKelasId,
    "m_biayamasuk_id": mBiayamasukId,
    "m_caramasuk_id": mCaramasukId,
    "m_shift_id": mShiftId,
    "pendaftaran_id_asal": pendaftaranIdAsal,
    "status_kunjungan": statusKunjungan,
    "m_nonpasien_id": mNonpasienId,
    "m_instalasi_id": mInstalasiId,
    "pendaftaran_status": pendaftaranStatus,
    "t_jadwalpraktek_id": tJadwalpraktekId,
    "pendaftaran_cito": pendaftaranCito,
    "pendaftaran_noresep": pendaftaranNoresep,
    "m_paket_id": mPaketId,
    "pendaftaran_keterangan": pendaftaranKeterangan,
    "pendaftaran_aktif": pendaftaranAktif,
    "pendaftaran_created_date": pendaftaranCreatedDate,
    "pendaftaran_created_by": pendaftaranCreatedBy,
    "pendaftaran_updated_date": pendaftaranUpdatedDate,
    "pendaftaran_updated_by": pendaftaranUpdatedBy,
    "pendaftaran_revised": pendaftaranRevised,
    "reg_company_id": regCompanyId,
    "reg_apps_id": regAppsId,
    "t_orderpenunjang_id": tOrderpenunjangId,
    "t_orderresep_id": tOrderresepId,
    "no_antrian_dokter": noAntrianDokter,
    "m_klaim_id": mKlaimId,
    "alasan": alasan,
    "tgl_booking": tglBooking,
    "kodebooking": kodebooking,
    "statusbooking": statusbooking,
    "statuskonfirmasi": statuskonfirmasi,
    "unit_nama": unitNama,
    "pegawai_nama": pegawaiNama,
  };
}