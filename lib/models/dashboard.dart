/// label : "INSTALASI KAMAR JENAZAH"
/// count : "1"
/// total : "9815"
/// color : "grey"

class Dashboard {
  String label;
  String count;
  String total;
  String color;

  static Dashboard fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Dashboard dashboardBean = Dashboard();
    dashboardBean.label = map['label'];
    dashboardBean.count = map['count'];
    dashboardBean.total = map['total'];
    dashboardBean.color = map['color'];
    return dashboardBean;
  }

  Map toJson() =>
      {
        "label": label,
        "count": count,
        "total": total,
        "color": color,
      };
}