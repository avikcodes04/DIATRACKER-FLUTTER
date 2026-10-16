import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:diatrack/features/ai_recommendation/data/repositories/ai_repository.dart';

class AiRecommendationState {
  final bool isLoading;
  final Map<String, dynamic>? result;
  final String? errorMessage;

  const AiRecommendationState({
    this.isLoading = false,
    this.result,
    this.errorMessage,
  });

  AiRecommendationState copyWith({
    bool? isLoading,
    Map<String, dynamic>? result,
    String? errorMessage,
    bool clearError = false,
  }) {
    return AiRecommendationState(
      isLoading: isLoading ?? this.isLoading,
      result: result ?? this.result,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

final aiRecommendationControllerProvider =
    NotifierProvider<AiRecommendationNotifier, AiRecommendationState>(
        AiRecommendationNotifier.new);

class AiRecommendationNotifier extends Notifier<AiRecommendationState> {
  late final AiRepository _repository;

  @override
  AiRecommendationState build() {
    _repository = ref.watch(aiRepositoryProvider);
    return const AiRecommendationState();
  }

  Future<Map<String, dynamic>?> generateRecommendation(
      Map<String, dynamic> clinicalData) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final result = await _repository.getRecommendation(clinicalData);
      state = state.copyWith(
        isLoading: false,
        result: result,
      );
      return result;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      return null;
    }
  }
}
