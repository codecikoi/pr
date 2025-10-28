import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/api/mock_api.dart';
import 'result_event.dart';
import 'result_state.dart';

/// Bloc for managing result screen state
class ResultBloc extends Bloc<ResultEvent, ResultState> {
  final MockApi _api;
  String _currentPrompt = '';

  ResultBloc({MockApi? api})
    : _api = api ?? MockApi(),
      super(const ResultInitial()) {
    on<GenerationStarted>(_onGenerationStarted);
    on<RegeneratePressed>(_onRegeneratePressed);
  }

  Future<void> _onGenerationStarted(
    GenerationStarted event,
    Emitter<ResultState> emit,
  ) async {
    _currentPrompt = event.prompt;
    emit(const GenerationLoading());

    try {
      final imageUrl = await _api.generate(event.prompt);
      emit(GenerationSuccess(imageUrl));
    } catch (e) {
      emit(GenerationError(e.toString()));
    }
  }

  Future<void> _onRegeneratePressed(
    RegeneratePressed event,
    Emitter<ResultState> emit,
  ) async {
    emit(const GenerationLoading());

    try {
      final imageUrl = await _api.generate(_currentPrompt);
      emit(GenerationSuccess(imageUrl));
    } catch (e) {
      emit(GenerationError(e.toString()));
    }
  }
}
