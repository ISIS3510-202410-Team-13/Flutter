import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:unischedule/constants/constants.dart';
import 'package:unischedule/services/services.dart';
import 'package:unischedule/providers/providers.dart';

part 'feature_analytics_repository.g.dart';

abstract class FeatureAnalyticsRepository {
  Future<void> registerButtonTap(String buttonName);
  Future<void> registerPageView(String pageName);
  Future<void> registerEvent(String eventName);
  Future<void> submitRating(double rating, String classroom);
}

class FeatureAnalyticsRepositoryImpl extends FeatureAnalyticsRepository {

  final DioApiService client;
  final Ref ref;

  FeatureAnalyticsRepositoryImpl({
    required this.ref,
    required this.client,
  });

  @override
  Future<void> registerButtonTap(buttonName) async {
    final userId = ref.watch(authenticationStatusProvider)?.uid ?? 'anonymous';
    final userType = ref.watch(authenticationStatusProvider.notifier).getUserType();
    try {
      await client.postRequest(
        'analytics/$userId/button-tap',
        data: {
          'timestamp': DateTime.now().toIso8601String(),
          'buttonName': buttonName,
          'userType': userType,
        }
      );
    } catch (error) {
      print('Failed to register button tap: $error');
    }
  }

  @override
  Future<void> registerPageView(pageName) async {
    final userId = ref.watch(authenticationStatusProvider)?.uid ?? 'anonymous';
    final userType = ref.watch(authenticationStatusProvider.notifier).getUserType();
    try {
      await client.postRequest(
        'analytics/$userId/page-view',
        data: {
          'timestamp': DateTime.now().toIso8601String(),
          'pageName': pageName,
          'userType': userType,
        }
      );
    } catch (error) {
      print('Failed to register page view: $error');
    }
  }

  @override
  Future<void> registerEvent(eventName) async {
    final userId = ref.watch(authenticationStatusProvider)?.uid ?? 'anonymous';
    final userType = ref.watch(authenticationStatusProvider.notifier).getUserType();
    try {
      await client.postRequest(
        'analytics/$userId/event',
        data: {
          'timestamp': DateTime.now().toIso8601String(),
          'eventName': eventName,
          'userType': userType,
        }
      );
    } catch (error) {
      print('Failed to register event: $error');
    }
  }

  @override
  Future<void> submitRating(rating, classroom) async {
    final userId = ref.watch(authenticationStatusProvider)?.uid ?? 'anonymous';
    final userType = ref.watch(authenticationStatusProvider.notifier).getUserType();
    try {
      await client.postRequest(
        'analytics/$userId/rating',
        data: {
          'timestamp': DateTime.now().toIso8601String(),
          'rating': rating,
          'classroom': classroom,
          'userType': userType,
        }
      );
    } catch (error) {
      print('Failed to submit rating: $error');
    }
  }
}

@riverpod
FeatureAnalyticsRepositoryImpl featureAnalyticsRepository(FeatureAnalyticsRepositoryRef ref) {
  return FeatureAnalyticsRepositoryImpl(
    ref: ref,
    client: DioApiServiceFactory.getService(HTTPConstants.FEATURE_ANALYTICS_BASE_URL),
  );
}