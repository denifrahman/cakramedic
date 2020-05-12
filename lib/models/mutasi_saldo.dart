class Mutasi_saldo {
  String id;
  String status;
  String nominal;
  String id_guru;
  String tgl_ins;
  String status_penarikan;


  Mutasi_saldo(
  String id,
  String status,
  String nominal,
  String id_guru,
  String tgl_ins,
  String status_penarikan,

  ) {

    this.id= id;
    this.status = status;
    this.nominal= nominal;
    this.id_guru= id_guru;
    this.tgl_ins= tgl_ins;
    this.status_penarikan= status_penarikan;

  }

  Mutasi_saldo.fromJson(Map json)
      : id= json['id'],
        status = json['status'],
        nominal= json['nominal'],
        id_guru= json['id_guru'],
        tgl_ins= json['tgl_ins'],
        status_penarikan= json['status_penarikan'];


  Map toJson() {
    return {
      'id': id,
      'status': status,
      'nominal': nominal,
      'id_guru': id_guru,
      'tgl_ins': tgl_ins,
      'status_penarikan': status_penarikan,

    };
  }
}

