/// label : "RAWAT DARURAT"
/// count : "1"
/// total : "9817"
/// color : "c0392b"
/// tanggal_masuk : "2020-01-01 00:25:12"

class RawatInap {
  String label;
  String count;
  String total;
  String color;
  String tanggalMasuk;

  static RawatInap fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    RawatInap RawatInapBean = RawatInap();
    RawatInapBean.label = map['label'];
    RawatInapBean.count = map['count'];
    RawatInapBean.total = map['total'];
    RawatInapBean.color = map['color'];
    RawatInapBean.tanggalMasuk = map['tanggal_masuk'];
    return RawatInapBean;
  }

  Map toJson() => {
        "label": label,
        "count": count,
        "total": total,
        "color": color,
        "tanggal_masuk": tanggalMasuk,
      };
}
