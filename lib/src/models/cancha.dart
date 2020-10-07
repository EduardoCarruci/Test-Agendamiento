class Cancha {
  int id;
  String nombre;
  String tipo;

  Cancha({
    this.id,
    this.nombre,
    this.tipo,
  });

  List<Cancha> creacionCanchas() {
    
    List<Cancha> array = List<Cancha>();

    Cancha cancha = new Cancha(id: 1, nombre: "Juancin Football", tipo: "A");
    Cancha cancha2 = new Cancha(id: 2, nombre: "Freestyle Football", tipo: "B");
    Cancha cancha3 = new Cancha(id: 3, nombre: "Batallas Football", tipo: "C");

    array.add(cancha);
    array.add(cancha2);
    array.add(cancha3);
    return array;
  }


}
