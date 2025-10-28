import 'package:go_router/go_router.dart';
import '../../features/prompt/presentation/prompt_screen.dart';
import '../../features/result/presentation/result_screen.dart';

/// Application router configuration
class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'prompt',
        builder: (context, state) => const PromptScreen(),
      ),
      GoRoute(
        path: '/result',
        name: 'result',
        builder: (context, state) {
          final prompt = state.uri.queryParameters['prompt'] ?? '';
          return ResultScreen(prompt: prompt);
        },
      ),
    ],
  );
}
