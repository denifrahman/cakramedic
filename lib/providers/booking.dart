import 'dart:async';

import 'package:http/http.dart' as http;

//const baseUrl = "https://api-resource.cakramedic.com/index.php/";
//const baseUrl = "http://103.135.0.106:2020/api_mobile_charlie/index.php/";
const baseUrl = "http://192.168.0.8:8888/api-simrs-cakra/index.php/";

class Api {
  static Future getDokter(unit) {
    var url = baseUrl + "/dokter/cari_pegawai_by_unit?unitid="+unit;
    print(url);
    return http.get(url);
  }
  static Future getJadwalDokterByUnitPegawai(unit,pegawai) {
    var url = baseUrl + "/dokter/cari_jadwal_by_unit_pegawai?unitid="+unit+"&pegawaiid="+pegawai;
    print(url);
    return http.get(url);
  }
  static Future getJadwalDokterByTglAndPoli(String date, String unitId) {
    var url = baseUrl + "/dokter/cari_by_tglunitid?tgl="+date+"&unitid="+unitId;
    print(url);
    return http.get(url);
  }
  static Future getMurid(String id) {
    var url = baseUrl + "/getMurid/"+id;
    return http.get(url);
  }
  static Future getPertemuan(String id) {
    var url = baseUrl + "/getPertemuan/"+id;
    return http.get(url);
  }
  static Future getDataPasienByNoRm(noRm, tglLahir) {
    var url = baseUrl + "/pasien/cari_by_norm_tgllahir?norm="+noRm+"&&tgllahir="+tglLahir;
    return http.get(url);
  }
  static Future getAllPenjamin() {
    var url = baseUrl + "/penjamin";
    return http.get(url);
  }
  static Future getAllPoliKlinik() {
    var url = baseUrl + "/poliklinik";
    return http.get(url);
  }
  static Future getByNoRm(noRm) {
    var url = baseUrl + "AkunPasien/get_by_no_rm/"+noRm;
    return http.get(url);
  }
  static Future daftarPasienBaru(body) {
    var url = baseUrl + "/AkunPasien/add";
    print(body);
    return http.post(url,body: body);
  }
  static Future chekNoTelp(noTelp) {
    var url = baseUrl + "/AkunPasien/chek_no_telp/"+noTelp;
    return http.get(url);
  }
  static Future loginPost(body) {
    var url = baseUrl + "/LoginAndroid/loginPasien";
    return http.post(url,body: body);
  }
  static Future bookingPendaftaran(body) {
    var url = baseUrl + "/Booking/add";
    return http.post(url,body: body);
  }
  static Future getNoRegistrasi(tanggal_masuk,id_jadwal_praktek) {
    var url = baseUrl + "/Booking/get_no_antrian/"+tanggal_masuk+"/"+id_jadwal_praktek;
    return http.get(url);
  }
  static Future getBookingByPasienAndStatus(idPasien,statusBooking, statusBooking2) {
    var url = baseUrl + "/Booking/get_booking_by_pasien/"+idPasien+"/"+statusBooking+"/"+statusBooking2;
    return http.get(url);
  }
  static Future getBookingByPasienAndStatusBooking(idPasien,statusBooking) {
    var url = baseUrl + "booking/get_all_booking_by_status_booking_pasien/"+idPasien+"/"+statusBooking;
    return http.get(url);
  }
  static Future getAllBookingByPasien(idPasien) {
    var url = baseUrl + "Booking/get_all_booking_by_pasien/"+idPasien;
    return http.get(url);
  }
  static Future getBookingByPendaftaranId(pendaftaranId) {
    var url = baseUrl + "/Booking/get_booking_by_pendaftaran_id/"+pendaftaranId;
    return http.get(url);
  }
  static Future getSettingInitWaktuChekin() {
    var url = baseUrl + "/SettingInit/get_setting_sebelum_chekin";
    return http.get(url);
  }
  static Future ubah(body) {
    var url = baseUrl + "/Booking/ubah";
    return http.post(url,body: body);
  }
  static Future getAntrianByPasien(idPasien) {
    var url = baseUrl + "/antrian/get_all_antrian_by_pasien/"+idPasien;
    print(url);
    return http.get(url);
  }
  static Future getTotalAntrian(panggilan_status) {
    var url = baseUrl + "/antrian/get_total_antrian_by_pasien/"+panggilan_status;
    return http.get(url);
  }
  static Future getAntrianPanggil(panggilan_status,jadwal_praktek_id) {
    var url = baseUrl + "antrian/get_antrian_panggil_by_pasien/"+panggilan_status+'/'+jadwal_praktek_id;
    return http.get(url);
  }
  static Future getInfo() {
    var url = baseUrl + "SettingInit/get_info";
    return http.get(url);
  }

  static Future getAllPasien() {
    var url = baseUrl + "Dashboard/get_all_pasien";
//    print(url);
    return http.get(url);
  }

  static Future getAllPasienPerInstalasi() {
    var url = baseUrl + "Dashboard/get_all_pasien_per_instalasi";
    return http.get(url);
  }

  static Future getKunjunganPerTangganAndInstalasi(fromDate, toDate) {
    var url = baseUrl + "Dashboard/get_kunjungan_per_instalasi_dan_tanggal/" +
        fromDate + '/' + toDate;
//    print(url);
    return http.get(url);
  }

  static Future getPendapatanTunai(datePendapatan,toDate) {
    var url = baseUrl + "Dashboard/get_pendapatan_tunai/" + datePendapatan + '/' + toDate;
//    print(url);
    return http.get(url);
  }
  static Future getPendapatanTunaiUnit(datePendapatanUnit,toDate, unitId) {
    var url = baseUrl + "Dashboard/get_pendapatan_tunai_by_unit/" + datePendapatanUnit + '/' + toDate + '/' +unitId;
//    print(url);
    return http.get(url);
  }
  static Future getPendapatanTunaiPenjamin(datePendapatanPenjamin,toDate, penjaminId) {
    var url = baseUrl + "Dashboard/get_pendapatan_tunai_by_penjamin/" + datePendapatanPenjamin + '/' + toDate + '/' +penjaminId;
//    print(url);
    return http.get(url);
  }
  static Future getPiutangUnit(datePiutangUnit, toDate, unitId, status) {
    var url = baseUrl + "Dashboard/get_piutang_by_unit/" + datePiutangUnit + '/' + toDate + '/' + unitId + '/'+ status;
    print(url);
    return http.get(url);
  }
  static Future getPiutangPenjamin(datePiutangPenjamin, toDate, penjaminId, status) {
    var url = baseUrl + "Dashboard/get_piutang_by_penjamin/" + datePiutangPenjamin + '/' + toDate + '/' +penjaminId+'/'+status;
    print(url);
    return http.get(url);
  }
  static Future lupaPassword(body) {
    var url = baseUrl + "AkunPasien/lupaPassword/";
    print(url);
    return http.post(url,body: body);
  }
}