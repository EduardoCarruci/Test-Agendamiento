import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:agendamiento_canchas/src/controllers/db_local.dart';
import 'package:agendamiento_canchas/src/models/agendamiento..dart';

class MockitoDatabase extends Mock implements ClientDatabaseProvider {}

class MockitoAgedanmiento extends Mock implements Agendamiento {}

class MockitoListAgedanmiento extends Mock implements List<Agendamiento> {}
// Test!!

void main() async {
  test('evaluar si existen los registros', () async {
    expect(
        await MockitoDatabase().getValueElements("nombre", "12/12/5050"), null);
  });

  test('eliminar la reserva', () async {
    expect(await MockitoDatabase().deleteReserva(5600), null);
  });

  test('agregar elementos a la db nulos', () async {
    expect(await MockitoDatabase().addElement(MockitoAgedanmiento()), null);
  });

  test('get full data', () async {
    expect(await MockitoDatabase().getAllReservas(), isNull);
  });
}
