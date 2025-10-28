import 'package:equatable/equatable.dart';

/// Base class for result events
abstract class ResultEvent extends Equatable {
  const ResultEvent();

  @override
  List<Object?> get props => [];
}

/// Event when generation is started
class GenerationStarted extends ResultEvent {
  final String prompt;

  const GenerationStarted(this.prompt);

  @override
  List<Object?> get props => [prompt];
}

/// Event when regenerate button is pressed
class RegeneratePressed extends ResultEvent {
  const RegeneratePressed();
}
