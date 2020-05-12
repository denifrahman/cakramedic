/// label : "RAWAT DARURAT"
/// count : "1"
/// total : "9817"
/// color : "c0392b"
/// tanggal_masuk : "2020-01-01 00:25:12"

class RawatDarurat {
  String label;
  String count;
  String total;
  String color;
  String tanggalMasuk;

  static RawatDarurat fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    RawatDarurat RawatDaruratBean = RawatDarurat();
    RawatDaruratBean.label = map['label'];
    RawatDaruratBean.count = map['count'];
    RawatDaruratBean.total = map['total'];
    RawatDaruratBean.color = map['color'];
    RawatDaruratBean.tanggalMasuk = map['tanggal_masuk'];
    return RawatDaruratBean;
  }

  Map toJson() => {
        "label": label,
        "count": count,
        "total": total,
        "color": color,
        "tanggal_masuk": tanggalMasuk,
      };
}
