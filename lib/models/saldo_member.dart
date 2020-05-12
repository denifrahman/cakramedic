/// saldo : "0"

class SaldoMember {
  String saldo;

  static SaldoMember fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    SaldoMember saldoMemberBean = SaldoMember();
    saldoMemberBean.saldo = map['saldo'];
    return saldoMemberBean;
  }

  Map toJson() => {
    "saldo": saldo,
  };
}