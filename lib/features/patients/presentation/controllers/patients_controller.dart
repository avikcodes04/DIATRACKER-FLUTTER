import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:diatrack/features/patients/data/models/patient_model.dart';
import 'package:diatrack/features/patients/data/repositories/patient_repository.dart';

class PatientsState {
  final bool isLoading;
  final List<PatientModel> allPatients;
  final String searchQuery;
  final String selectedFilter;
  final String? errorMessage;

  const PatientsState({
    this.isLoading = false,
    this.allPatients = const [],
    this.searchQuery = '',
    this.selectedFilter = 'All',
    this.errorMessage,
  });

  List<PatientModel> get filteredPatients {
    return allPatients.where((patient) {
      final matchesSearch = searchQuery.isEmpty ||
          patient.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          patient.id.toLowerCase().contains(searchQuery.toLowerCase()) ||
          patient.diagnosis.toLowerCase().contains(searchQuery.toLowerCase());

      final matchesFilter = selectedFilter == 'All' || patient.status == selectedFilter;

      return matchesSearch && matchesFilter;
    }).toList();
  }

  PatientsState copyWith({
    bool? isLoading,
    List<PatientModel>? allPatients,
    String? searchQuery,
    String? selectedFilter,
    String? errorMessage,
    bool clearError = false,
  }) {
    return PatientsState(
      isLoading: isLoading ?? this.isLoading,
      allPatients: allPatients ?? this.allPatients,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

final patientsControllerProvider =
    NotifierProvider<PatientsNotifier, PatientsState>(PatientsNotifier.new);

class PatientsNotifier extends Notifier<PatientsState> {
  late final PatientRepository _repository;

  @override
  PatientsState build() {
    _repository = ref.watch(patientRepositoryProvider);
    Future.microtask(() => loadPatients());
    return const PatientsState(isLoading: true);
  }

  Future<void> loadPatients() async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final patients = await _repository.getPatients();
      state = state.copyWith(
        isLoading: false,
        allPatients: patients,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void setFilter(String filter) {
    state = state.copyWith(selectedFilter: filter);
  }
}
