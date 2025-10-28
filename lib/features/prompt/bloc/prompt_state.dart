import 'package:equatable/equatable.dart';

/// Base class for prompt states
abstract class PromptState extends Equatable {
  final String prompt;

  const PromptState({required this.prompt});

  @override
  List<Object?> get props => [prompt];
}

/// Initial state
class PromptInitial extends PromptState {
  const PromptInitial({required super.prompt});
}

/// State when prompt is valid (not empty)
class PromptValid extends PromptState {
  const PromptValid({required super.prompt});
}

/// State when prompt is invalid (empty)
class PromptInvalid extends PromptState {
  const PromptInvalid({required super.prompt});
}
