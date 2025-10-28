import 'dart:math';

/// Mock API service for image generation
class MockApi {
  final Random _random = Random();

  /// Simulates image generation with 50% chance of failure
  /// Returns a URL to a placeholder image on success
  Future<String> generate(String prompt) async {
    // Simulate network delay (2-3 seconds)
    await Future.delayed(Duration(seconds: 2 + _random.nextInt(2)));

    // 50% chance of failure
    if (_random.nextBool()) {
      throw Exception('Generation failed. Please try again.');
    }

    // Return a unique placeholder image based on prompt
    // Using picsum.photos with seed to get consistent images for same prompts
    final seed = prompt.hashCode.abs();
    return 'https://picsum.photos/seed/$seed/600/600';
  }
}
