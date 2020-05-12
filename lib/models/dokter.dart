/// pegawai_nama : "dr. TOMMY,Sp.B."
/// m_pegawai_id : "90"
/// m_unit_id : "6"

class Dokter {
  String pegawaiNama;
  String mPegawaiId;
  String mUnitId;

  static Dokter fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Dokter dokterBean = Dokter();
    dokterBean.pegawaiNama = map['pegawai_nama'];
    dokterBean.mPegawaiId = map['m_pegawai_id'];
    dokterBean.mUnitId = map['m_unit_id'];
    return dokterBean;
  }

  Map toJson() => {
    "pegawai_nama": pegawaiNama,
    "m_pegawai_id": mPegawaiId,
    "m_unit_id": mUnitId,
  };
}