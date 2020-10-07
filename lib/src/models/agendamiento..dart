class Agendamiento {
  int id;
  String nombrecancha;
  String nombrepersona;
  String fecha;

  Agendamiento({
    this.id,
    this.nombrecancha,
    this.nombrepersona,
    this.fecha,
  });

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombrecancha": nombrecancha,
        "nombrepersona": nombrepersona,
        "fecha": fecha,
      };
  factory Agendamiento.fromMap(Map<String, dynamic> json) => new Agendamiento(
        id: json["id"],
        nombrecancha: json["nombrecancha"],
        nombrepersona: json["nombrepersona"],
        fecha: json["fecha"],
      );
}
