import '../../data/models/user_model.dart';

class MockUsers {
  static List<User> getUsers() {
    return [
      User(
        id: '1',
        name: 'Cliente',
        email: 'teste.cliente@americana.com',
        password: '123',
        role: UserRole.cliente,
      ),
      User(
        id: '2',
        name: 'Atendente',
        email: 'teste.atendente@americana.com',
        password: '123',
        role: UserRole.atendente,
      ),
      User(
        id: '3',
        name: 'Farmacêutico',
        email: 'teste.farmaceutico@americana.com',
        password: '123',
        role: UserRole.farmaceutico,
      ),
      User(
        id: '4',
        name: 'Dono da Farmácia',
        email: 'teste.dono@americana.com',
        password: '123',
        role: UserRole.dono,
      ),
    ];
  }
}