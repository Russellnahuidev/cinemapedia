import 'package:cinamapedia/infrastructure/datasources/isar_datasource_impl.dart';
import 'package:cinamapedia/infrastructure/repositories/local_storage_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localStoregeRepositoryProvider = Provider((ref) {
  return LocalStorageRepositoryImpl(IsarDatasourceImpl());
});
