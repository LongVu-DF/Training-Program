# Repository Patttern

Split repository into 2 parts in 2 different files.
- **`domain/repositories`:** contain repository interface.
- **`data/repositories`:** contain repository implement from `domain/repositories`

Repository dont allow to have:
- BloC ... any state management.
- UI.
- Use Case.
Repository is just one part of Clean Architecture, which helps the `domain` layer to be independent of the implementation details of the `data` layer.
### 1. domain/repositories layer
Specifies the repository method required, regardless of where the data comes from.
```
abstract class AuthRepository {
  Future<User> login(String email, String password);
  Future<void> logout();
}
```
### 2. data/repositories layer
Connect to API or database to get data, then convert to domain
```
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<User> login(String email, String password) async {
    final userModel = await remoteDataSource.login(email, password);
    return User(id: userModel.id, name: userModel.name, email: userModel.email);
  }

  @override
  Future<void> logout() async {
    return remoteDataSource.logout();
  }
}
```