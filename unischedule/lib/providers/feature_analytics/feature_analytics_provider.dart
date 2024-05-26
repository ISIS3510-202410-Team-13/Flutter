import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:unischedule/repositories/repositories.dart';

part 'feature_analytics_provider.g.dart';

@riverpod
Future<void> registerButtonTap(
    RegisterButtonTapRef ref, {
      required String buttonName,
    }
){
  final featureAnalyticsRepository = ref.watch(featureAnalyticsRepositoryProvider);
  ref.keepAlive();
  return featureAnalyticsRepository.registerButtonTap(buttonName);
}

@riverpod
Future<void> registerPageView(
    RegisterPageViewRef ref, {
      required String pageName,
    }
){
  final featureAnalyticsRepository = ref.watch(featureAnalyticsRepositoryProvider);
  ref.keepAlive();
  return featureAnalyticsRepository.registerPageView(pageName);
}

@riverpod
Future<void> registerEvent(
  RegisterEventRef ref, {
    required String eventName,
  }
){
  final featureAnalyticsRepository = ref.watch(featureAnalyticsRepositoryProvider);
  ref.keepAlive();
  return featureAnalyticsRepository.registerEvent(eventName);
}

@riverpod
Future<void> submitRating(
  SubmitRatingRef ref, {
    required double rating,
    required String classroom,
  }
){
  final featureAnalyticsRepository = ref.watch(featureAnalyticsRepositoryProvider);
  ref.keepAlive();
  return featureAnalyticsRepository.submitRating(rating, classroom);
}