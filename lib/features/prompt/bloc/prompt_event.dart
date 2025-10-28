import 'package:equatable/equatable.dart';

/// Base class for prompt events
abstract class PromptEvent extends Equatable {
  const PromptEvent();

  @override
  List<Object?> get props => [];
}

/// Event when prompt text is changed
class PromptChanged extends PromptEvent {
  final String prompt;

  const PromptChanged(this.prompt);

  @override
  List<Object?> get props => [prompt];
}

/// Event when generate button is pressed
class GeneratePressed extends PromptEvent {
  const GeneratePressed();
}
