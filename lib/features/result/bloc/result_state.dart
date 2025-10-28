import 'package:equatable/equatable.dart';

/// Base class for result states
abstract class ResultState extends Equatable {
  const ResultState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class ResultInitial extends ResultState {
  const ResultInitial();
}

/// State when generation is in progress
class GenerationLoading extends ResultState {
  const GenerationLoading();
}

/// State when generation is successful
class GenerationSuccess extends ResultState {
  final String imageUrl;

  const GenerationSuccess(this.imageUrl);

  @override
  List<Object?> get props => [imageUrl];
}

/// State when generation fails
class GenerationError extends ResultState {
  final String message;

  const GenerationError(this.message);

  @override
  List<Object?> get props => [message];
}
