import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/prompt_bloc.dart';
import '../bloc/prompt_event.dart';
import '../bloc/prompt_state.dart';
import '../../../core/theme/app_theme.dart';

/// Prompt input screen where user describes what they want to generate
class PromptScreen extends StatelessWidget {
  const PromptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PromptBloc(),
      child: const _PromptView(),
    );
  }
}

class _PromptView extends StatefulWidget {
  const _PromptView();

  @override
  State<_PromptView> createState() => _PromptViewState();
}

class _PromptViewState extends State<_PromptView>
    with SingleTickerProviderStateMixin {
  late final TextEditingController _controller;
  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _animationController.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.promptGradient),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Spacer(),
                          FadeTransition(
                            opacity: _fadeAnimation,
                            child: SlideTransition(
                              position: _slideAnimation,
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.auto_awesome,
                                    size: 80,
                                    color: Colors.white.withValues(alpha: 0.9),
                                  ),
                                  const SizedBox(height: 24),
                                  Text(
                                    'AI Image Generator',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium
                                        ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    'Describe your imagination',
                                    style: Theme.of(context).textTheme.bodyLarge
                                        ?.copyWith(
                                          color: Colors.white.withValues(
                                            alpha: 0.8,
                                          ),
                                        ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 48),
                          FadeTransition(
                            opacity: _fadeAnimation,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: AppTheme.promptTextBackGround,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.1),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    TextField(
                                      controller: _controller,
                                      decoration: InputDecoration(
                                        hintText:
                                            'Describe what you want to see...',
                                        hintStyle: TextStyle(
                                          color: Colors.grey.shade400,
                                        ),
                                        prefixIcon: Icon(
                                          Icons.edit_outlined,
                                          color: Colors.grey.shade400,
                                        ),
                                      ),
                                      maxLines: 2,
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      onChanged: (value) {
                                        context.read<PromptBloc>().add(
                                          PromptChanged(value),
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 20),
                                    BlocBuilder<PromptBloc, PromptState>(
                                      builder: (context, state) {
                                        final isValid = state is PromptValid;
                                        return ElevatedButton(
                                          onPressed: isValid
                                              ? () {
                                                  context.pushNamed(
                                                    'result',
                                                    queryParameters: {
                                                      'prompt': state.prompt,
                                                    },
                                                  );
                                                }
                                              : null,
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(
                                              0xFF6366F1,
                                            ),
                                            foregroundColor: Colors.white,
                                            disabledBackgroundColor:
                                                Colors.grey.shade300,
                                            disabledForegroundColor:
                                                Colors.grey.shade500,
                                            minimumSize: const Size.fromHeight(
                                              56,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Text('Generate'),
                                              const SizedBox(width: 8),
                                              Icon(
                                                Icons.arrow_forward_rounded,
                                                size: 20,
                                                color: isValid
                                                    ? Colors.white
                                                    : Colors.grey.shade500,
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const Spacer(flex: 2),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
