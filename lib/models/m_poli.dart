/// nama_poli : "poli gigi"

class MPoli {
  String namaPoli;

  static MPoli fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    MPoli mPoliBean = MPoli();
    mPoliBean.namaPoli = map['nama_poli'];
    return mPoliBean;
  }

  Map toJson() => {
    "nama_poli": namaPoli,
  };
}