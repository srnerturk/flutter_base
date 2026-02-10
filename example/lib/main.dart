import 'package:flutter/material.dart';
import 'package:mbvn_flutter_base/mbvn_flutter_base.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      home: const ExampleHome(),
    );
  }
}

class ExampleHome extends StatefulWidget {
  const ExampleHome({super.key});

  @override
  State<ExampleHome> createState() => _ExampleHomeState();
}

class _ExampleHomeState extends State<ExampleHome> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('mbvn_flutter_base Example')),
      body: Padding(
        padding: const EdgeInsets.all(Spacing.md),
        child: _selectedIndex == 0
            ? const _DesignDemo()
            : _selectedIndex == 1
                ? const _ResultDemo()
                : const _StateDemo(),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (i) => setState(() => _selectedIndex = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.palette_outlined),
            selectedIcon: Icon(Icons.palette),
            label: 'Design',
          ),
          NavigationDestination(
            icon: Icon(Icons.api_outlined),
            selectedIcon: Icon(Icons.api),
            label: 'Result',
          ),
          NavigationDestination(
            icon: Icon(Icons.widgets_outlined),
            selectedIcon: Icon(Icons.widgets),
            label: 'States',
          ),
        ],
      ),
    );
  }
}

class _DesignDemo extends StatelessWidget {
  const _DesignDemo();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Heading', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: Spacing.lg),
          const AppTextField(
            label: 'Email',
            hint: 'Enter email',
          ),
          const SizedBox(height: Spacing.md),
          PrimaryButton(
            label: 'Submit',
            onPressed: () {},
          ),
          const SizedBox(height: Spacing.lg),
          Text('Spacing: 8.horizontal', style: Theme.of(context).textTheme.bodyMedium),
          Padding(padding: 8.horizontal, child: const Text('Padded with 8.horizontal')),
        ],
      ),
    );
  }
}

class _ResultDemo extends StatefulWidget {
  const _ResultDemo();

  @override
  State<_ResultDemo> createState() => _ResultDemoState();
}

class _ResultDemoState extends State<_ResultDemo> {
  Result<String> _result = const Success('Initial');
  bool _loading = false;

  Future<void> _fetch() async {
    setState(() {
      _loading = true;
      _result = const Success('Initial');
    });
    final client = AppHttpClient(baseUrl: 'https://httpstat.us');
    final result = await client.get('/200');
    setState(() {
      _loading = false;
      _result = result.fold(
        (r) => Success('Status: ${r.statusCode}'),
        (e) => Failure(e),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PrimaryButton(
          label: _loading ? 'Loading...' : 'Call API (httpstat.us/200)',
          onPressed: _loading ? null : _fetch,
          isLoading: _loading,
        ),
        const SizedBox(height: Spacing.lg),
        _result.fold(
          (value) => Card(
            child: Padding(
              padding: const EdgeInsets.all(Spacing.md),
              child: Text(value),
            ),
          ),
          (AppError error) => ErrorState(
            message: error.displayMessage,
            onRetry: _fetch,
          ),
        ),
      ],
    );
  }
}

class _StateDemo extends StatelessWidget {
  const _StateDemo();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const EmptyState(
          title: 'No items yet',
          subtitle: 'This is the empty state widget.',
          action: Text('Add action button here'),
        ),
        const SizedBox(height: Spacing.xl),
        ErrorState(
          message: 'Something went wrong.',
          onRetry: () {},
        ),
        const SizedBox(height: Spacing.xl),
        const AppLoadingIndicator(),
      ],
    );
  }
}
