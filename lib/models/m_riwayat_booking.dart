/// pendaftaran_id : "2176"
/// no_registrasi : ""
/// tanggal_masuk : "2020-02-05 22:38:03.595819"
/// tanggal_keluar : null
/// m_unit_id : "8"
/// m_pasien_id : "40"
/// m_pegawai_id : "79"
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
/// t_jadwalpraktek_id : "15464"
/// pendaftaran_cito : "t"
/// pendaftaran_noresep : null
/// m_paket_id : null
/// pendaftaran_keterangan : null
/// pendaftaran_aktif : "y"
/// pendaftaran_created_date : "2020-02-05 22:38:03.596685"
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
/// tgl_booking : "2020-02-06 00:00:00"
/// kodebooking : "348Fxf"
/// statusbooking : "BOOKING"
/// statuskonfirmasi : null

class MRiwayatBooking {
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

  static MRiwayatBooking fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    MRiwayatBooking mRiwayatBookingBean = MRiwayatBooking();
    mRiwayatBookingBean.pendaftaranId = map['pendaftaran_id'];
    mRiwayatBookingBean.noRegistrasi = map['no_registrasi'];
    mRiwayatBookingBean.tanggalMasuk = map['tanggal_masuk'];
    mRiwayatBookingBean.tanggalKeluar = map['tanggal_keluar'];
    mRiwayatBookingBean.mUnitId = map['m_unit_id'];
    mRiwayatBookingBean.mPasienId = map['m_pasien_id'];
    mRiwayatBookingBean.mPegawaiId = map['m_pegawai_id'];
    mRiwayatBookingBean.mPenjaminId = map['m_penjamin_id'];
    mRiwayatBookingBean.mKelasId = map['m_kelas_id'];
    mRiwayatBookingBean.mBiayamasukId = map['m_biayamasuk_id'];
    mRiwayatBookingBean.mCaramasukId = map['m_caramasuk_id'];
    mRiwayatBookingBean.mShiftId = map['m_shift_id'];
    mRiwayatBookingBean.pendaftaranIdAsal = map['pendaftaran_id_asal'];
    mRiwayatBookingBean.statusKunjungan = map['status_kunjungan'];
    mRiwayatBookingBean.mNonpasienId = map['m_nonpasien_id'];
    mRiwayatBookingBean.mInstalasiId = map['m_instalasi_id'];
    mRiwayatBookingBean.pendaftaranStatus = map['pendaftaran_status'];
    mRiwayatBookingBean.tJadwalpraktekId = map['t_jadwalpraktek_id'];
    mRiwayatBookingBean.pendaftaranCito = map['pendaftaran_cito'];
    mRiwayatBookingBean.pendaftaranNoresep = map['pendaftaran_noresep'];
    mRiwayatBookingBean.mPaketId = map['m_paket_id'];
    mRiwayatBookingBean.pendaftaranKeterangan = map['pendaftaran_keterangan'];
    mRiwayatBookingBean.pendaftaranAktif = map['pendaftaran_aktif'];
    mRiwayatBookingBean.pendaftaranCreatedDate = map['pendaftaran_created_date'];
    mRiwayatBookingBean.pendaftaranCreatedBy = map['pendaftaran_created_by'];
    mRiwayatBookingBean.pendaftaranUpdatedDate = map['pendaftaran_updated_date'];
    mRiwayatBookingBean.pendaftaranUpdatedBy = map['pendaftaran_updated_by'];
    mRiwayatBookingBean.pendaftaranRevised = map['pendaftaran_revised'];
    mRiwayatBookingBean.regCompanyId = map['reg_company_id'];
    mRiwayatBookingBean.regAppsId = map['reg_apps_id'];
    mRiwayatBookingBean.tOrderpenunjangId = map['t_orderpenunjang_id'];
    mRiwayatBookingBean.tOrderresepId = map['t_orderresep_id'];
    mRiwayatBookingBean.noAntrianDokter = map['no_antrian_dokter'];
    mRiwayatBookingBean.mKlaimId = map['m_klaim_id'];
    mRiwayatBookingBean.alasan = map['alasan'];
    mRiwayatBookingBean.tglBooking = map['tgl_booking'];
    mRiwayatBookingBean.kodebooking = map['kodebooking'];
    mRiwayatBookingBean.statusbooking = map['statusbooking'];
    mRiwayatBookingBean.statuskonfirmasi = map['statuskonfirmasi'];
    return mRiwayatBookingBean;
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
  };
}