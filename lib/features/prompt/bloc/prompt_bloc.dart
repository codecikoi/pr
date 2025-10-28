import 'package:flutter_bloc/flutter_bloc.dart';
import 'prompt_event.dart';
import 'prompt_state.dart';

/// Bloc for managing prompt screen state
class PromptBloc extends Bloc<PromptEvent, PromptState> {
  PromptBloc() : super(const PromptInitial(prompt: '')) {
    on<PromptChanged>(_onPromptChanged);
    on<GeneratePressed>(_onGeneratePressed);
  }

  void _onPromptChanged(PromptChanged event, Emitter<PromptState> emit) {
    final trimmedPrompt = event.prompt.trim();
    if (trimmedPrompt.isEmpty) {
      emit(PromptInvalid(prompt: event.prompt));
    } else {
      emit(PromptValid(prompt: event.prompt));
    }
  }

  void _onGeneratePressed(GeneratePressed event, Emitter<PromptState> emit) {
    // Navigation will be handled in the UI layer
    // This event is just to confirm the action
  }
}
