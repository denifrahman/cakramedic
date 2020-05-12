/// label : "RAWAT DARURAT"
/// count : "1"
/// total : "9817"
/// color : "c0392b"
/// tanggal_masuk : "2020-01-01 00:25:12"

class Penunjang {
  String label;
  String count;
  String total;
  String color;
  String tanggalMasuk;

  static Penunjang fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Penunjang PenunjangBean = Penunjang();
    PenunjangBean.label = map['label'];
    PenunjangBean.count = map['count'];
    PenunjangBean.total = map['total'];
    PenunjangBean.color = map['color'];
    PenunjangBean.tanggalMasuk = map['tanggal_masuk'];
    return PenunjangBean;
  }

  Map toJson() => {
        "label": label,
        "count": count,
        "total": total,
        "color": color,
        "tanggal_masuk": tanggalMasuk,
      };
}
