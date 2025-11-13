import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex_app/ui/cubit/onboarding.cubit.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({
    super.key
  });

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final List<Widget> _tabs = const [
    _OnboardingTab(
      icon: Icons.rocket_launch,
      title: 'Découvrir les lancements',
      description: 'Parcourez la liste des lancements SpaceX et découvrez les détails de chaque mission.',
    ),
    _OnboardingTab(
      icon: Icons.star,
      title: 'Favoris',
      description: 'Mettez en favoris vos lancements préférés pour y accéder rapidement.',
    ),
    _OnboardingTab(
      icon: Icons.play_circle_fill,
      title: 'Liens et ressources',
      description: 'Accédez aux webcasts, articles et pages Wikipédia directement depuis l\'application.',
    ),
  ];

  Future<void> _completeOnboarding() async {
    if (!mounted) return;
    context.read<OnboardingCubit>().setSeen(true);
  }

  void _onNext() {
    if (_currentIndex < _tabs.length - 1) {
      _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      _completeOnboarding();
    }
  }

  void _onSkip() {
    _completeOnboarding();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          TextButton(
            onPressed: _onSkip,
            child: const Text('Passer'),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (idx) => setState(() => _currentIndex = idx),
                children: _tabs,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: List.generate(_tabs.length, (i) {
                      final active = i == _currentIndex;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: active ? 20 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: active ? Theme.of(context).colorScheme.primary : Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                      );
                    }),
                  ),
                  ElevatedButton(
                    onPressed: _onNext,
                    child: Text(_currentIndex == _tabs.length - 1 ? 'Terminé' : 'Suivant'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingTab extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _OnboardingTab({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 96, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 24),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
