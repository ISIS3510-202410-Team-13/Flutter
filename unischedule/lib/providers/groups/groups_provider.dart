import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unischedule/models/groups_page/group_model.dart';
import 'package:unischedule/repositories/groups_page/groups_page_repository.dart';
import 'package:unischedule/services/network/groups_api_service.dart';

// Define el proveedor del servicio API
final groupsApiServiceProvider = Provider<GroupsApiService>((ref) {
  return GroupsApiService();
});

// Define el proveedor del repositorio
final groupsRepositoryProvider = Provider<GroupsRepository>((ref) {
  return GroupsRepository(ref.read(groupsApiServiceProvider));
});

// Define el proveedor para obtener grupos
final groupsProvider = FutureProvider.family<List<Group>, String>((ref, userId) {
  final repository = ref.read(groupsRepositoryProvider);
  return repository.getGroups(userId);
});
