/// panggil_antrian : "2"

class NomorPanggilan {
  String panggilAntrian;

  static NomorPanggilan fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    NomorPanggilan nomorPanggilanBean = NomorPanggilan();
    nomorPanggilanBean.panggilAntrian = map['panggil_antrian'];
    return nomorPanggilanBean;
  }

  Map toJson() => {
    "panggil_antrian": panggilAntrian,
  };
}