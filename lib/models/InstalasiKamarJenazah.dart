/// label : "RAWAT DARURAT"
/// count : "1"
/// total : "9817"
/// color : "c0392b"
/// tanggal_masuk : "2020-01-01 00:25:12"

class InstalasiKamarJenazah {
  String label;
  String count;
  String total;
  String color;
  String tanggalMasuk;

  static InstalasiKamarJenazah fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    InstalasiKamarJenazah InstalasiKamarJenazahBean = InstalasiKamarJenazah();
    InstalasiKamarJenazahBean.label = map['label'];
    InstalasiKamarJenazahBean.count = map['count'];
    InstalasiKamarJenazahBean.total = map['total'];
    InstalasiKamarJenazahBean.color = map['color'];
    InstalasiKamarJenazahBean.tanggalMasuk = map['tanggal_masuk'];
    return InstalasiKamarJenazahBean;
  }

  Map toJson() => {
        "label": label,
        "count": count,
        "total": total,
        "color": color,
        "tanggal_masuk": tanggalMasuk,
      };
}
