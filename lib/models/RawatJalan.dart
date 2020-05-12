/// label : "RAWAT DARURAT"
/// count : "1"
/// total : "9817"
/// color : "c0392b"
/// tanggal_masuk : "2020-01-01 00:25:12"

class RawatJalan {
  String label;
  String count;
  String total;
  String color;
  String tanggalMasuk;

  static RawatJalan fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    RawatJalan RawatJalanBean = RawatJalan();
    RawatJalanBean.label = map['label'];
    RawatJalanBean.count = map['count'];
    RawatJalanBean.total = map['total'];
    RawatJalanBean.color = map['color'];
    RawatJalanBean.tanggalMasuk = map['tanggal_masuk'];
    return RawatJalanBean;
  }

  Map toJson() => {
        "label": label,
        "count": count,
        "total": total,
        "color": color,
        "tanggal_masuk": tanggalMasuk,
      };
}
