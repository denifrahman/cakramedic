/// label : "RAWAT DARURAT"
/// count : "1"
/// total : "9817"
/// color : "c0392b"
/// tanggal_masuk : "2020-01-01 00:25:12"

class Farmasi {
  String label;
  String count;
  String total;
  String color;
  String tanggalMasuk;

  static Farmasi fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Farmasi FarmasiBean = Farmasi();
    FarmasiBean.label = map['label'];
    FarmasiBean.count = map['count'];
    FarmasiBean.total = map['total'];
    FarmasiBean.color = map['color'];
    FarmasiBean.tanggalMasuk = map['tanggal_masuk'];
    return FarmasiBean;
  }

  Map toJson() => {
        "label": label,
        "count": count,
        "total": total,
        "color": color,
        "tanggal_masuk": tanggalMasuk,
      };
}
