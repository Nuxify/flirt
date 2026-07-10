import 'package:flirt/core/domain/live_activities_service.dart';
import 'package:flirt/core/module/home/application/service/cubit/home_dto.dart';
import 'package:flirt/core/module/live_activity/application/service/cubit/live_activity_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LiveActivityDemoPageScreen extends StatefulWidget {
  const LiveActivityDemoPageScreen({super.key});

  @override
  State<LiveActivityDemoPageScreen> createState() =>
      _LiveActivityDemoPageScreenState();
}

class _LiveActivityDemoPageScreenState
    extends State<LiveActivityDemoPageScreen> {
  final LiveActivitiesService _service = LiveActivitiesService.instance;
  bool _isFetching = false;

  final List<Map<String, String>> _presets = <Map<String, String>>[
    <String, String>{
      'bookTitle': 'The Great Gatsby',
      'author': 'F. Scott Fitzgerald',
      'coverUrl': 'https://picsum.photos/seed/gatsby/200/300',
    },
    <String, String>{
      'bookTitle': '1984',
      'author': 'George Orwell',
      'coverUrl': 'https://picsum.photos/seed/1984/200/300',
    },
    <String, String>{
      'bookTitle': 'To Kill a Mockingbird',
      'author': 'Harper Lee',
      'coverUrl': 'https://picsum.photos/seed/mockingbird/200/300',
    },
  ];

  Future<void> _createFromPreset(Map<String, dynamic> preset) async {
    final String notificationId =
        'book-${DateTime.now().millisecondsSinceEpoch}';
    final Map<String, dynamic> payload = <String, dynamic>{
      'activityId': notificationId,
      // Live-activity fields expected by native widgets
      'bookTitle': preset['bookTitle'],
      'author': preset['author'],
      'coverUrl': preset['coverUrl'],
      'page': preset['page'] ?? 1,
      // Additional "real" data to surface to native side from the start
      'metadata': <String, dynamic>{
        'pages': preset['pages'] ?? 300,
        'isbn': preset['isbn'] ?? '000-0-00-000000-0',
        'synopsis': preset['synopsis'] ?? 'Demo synopsis',
      },
      'reader': <String, dynamic>{'id': 'demo-user-1', 'name': 'Demo Reader'},
      'startedAt': DateTime.now().toIso8601String(),
      'source': 'demo',
    };

    final bool ok = await _service.startLiveActivity(payload);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(ok ? 'Activity created' : 'Failed to create')),
    );
    setState(() {});
  }

  Future<void> _updateActivity(
    Map<String, dynamic> newData,
    String activityId,
  ) async {
    final Map<String, dynamic> payload = <String, dynamic>{
      ...newData,
      'lastUpdated': DateTime.now().toIso8601String(),
      'source': 'demo',
    };
    await _service.updateActivity(activityId: activityId, data: payload);
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Activity update sent')));
    setState(() {});
  }

  Future<void> _endActivity(String activityId) async {
    await _service.endActivityById(activityId);
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Activity ended')));
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initLiveActivities();
  }

  Future<void> _initLiveActivities() async {
    await LiveActivitiesService.instance.init();
    await LiveActivitiesService.instance.start();
  }

  @override
  Widget build(BuildContext context) {
    final List<LiveActivityData> activities = _service.liveActivities;

    return BlocListener<LiveActivityCubit, LiveActivityState>(
      listener: (BuildContext context, LiveActivityState state) async {
        if (state is FetchQuoteOnceLoading) {
          setState(() => _isFetching = true);
        } else if (state is FetchQuoteOnceSuccess) {
          setState(() => _isFetching = false);

          final QuoteResponseDTO quote = state.quoteResponse;
          final Map<String, dynamic> initial = <String, dynamic>{
            'bookTitle': quote.content,
            'author': quote.author,
            'coverUrl':
                'https://picsum.photos/seed/custom-${DateTime.now().millisecondsSinceEpoch}/200/300',
            'page': 1,
          };

          final Map<String, dynamic>? result = await Navigator.of(context)
              .push<Map<String, dynamic>>(
                MaterialPageRoute<Map<String, dynamic>>(
                  builder: (BuildContext context) =>
                      _LiveActivityEditPage(initialData: initial),
                ),
              );

          if (result == null) return;

          final String notificationId =
              'book-${DateTime.now().millisecondsSinceEpoch}';
          final Map<String, dynamic> payload = <String, dynamic>{
            'activityId': notificationId,
            'bookTitle': result['bookTitle'],
            'author': result['author'],
            'coverUrl': result['coverUrl'],
            'page': result['page'] ?? 1,
            'metadata': <String, dynamic>{
              'pages': result['pages'] ?? 250,
              'isbn': result['isbn'] ?? '000-0-00-000000-0',
              'synopsis': result['synopsis'] ?? '',
            },
            'reader': <String, dynamic>{
              'id': 'demo-user-1',
              'name': 'Demo Reader',
            },
            'startedAt': DateTime.now().toIso8601String(),
            'source': 'demo',
          };

          final bool ok = await _service.startLiveActivity(payload);
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                ok ? 'Custom activity created' : 'Failed to create',
              ),
            ),
          );
          setState(() {});
        } else if (state is FetchQuoteOnceFailed) {
          setState(() => _isFetching = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to fetch quote: ${state.message}')),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Live Activity Demo')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text('Create sample activity:'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: _presets.map((Map<String, dynamic> p) {
                  return ElevatedButton(
                    onPressed: () => _createFromPreset(p),
                    child: Text(p['bookTitle'] as String),
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _isFetching
                    ? null
                    : () => context.read<LiveActivityCubit>().fetchQuoteOnce(),
                child: _isFetching
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Create Custom'),
              ),
              const Divider(height: 24),
              const Text('Active activities:'),
              const SizedBox(height: 8),
              Expanded(
                child: activities.isEmpty
                    ? const Center(child: Text('No active activities'))
                    : ListView.builder(
                        itemCount: activities.length,
                        itemBuilder: (BuildContext context, int index) {
                          final LiveActivityData a = activities[index];
                          final Map<String, dynamic> payload = a.payload;
                          final String titleText =
                              (payload['bookTitle'] as String?) ??
                              a.notificationId;
                          final String authorText =
                              (payload['author'] as String?) ?? '';
                          final int pageNum = (payload['page'] is int)
                              ? (payload['page'] as int)
                              : int.tryParse('${payload['page']}') ?? 1;

                          return ListTile(
                            title: Text(titleText),
                            subtitle:
                                defaultTargetPlatform == TargetPlatform.android
                                ? Text(
                                    'activityId: ${a.activityId}\nAuthor: $authorText\nPage: $pageNum',
                                  )
                                : Text(
                                    'activityId: ${a.activityId}\npushToken: ${a.pushToken}\nAuthor: $authorText\nPage: $pageNum',
                                  ),
                            isThreeLine: true,
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () async {
                                    final Map<String, dynamic>? edited =
                                        await Navigator.of(
                                          context,
                                        ).push<Map<String, dynamic>>(
                                          MaterialPageRoute<
                                            Map<String, dynamic>
                                          >(
                                            builder: (BuildContext context) =>
                                                _LiveActivityEditPage(
                                                  initialData: a.payload,
                                                ),
                                          ),
                                        );

                                    if (edited != null) {
                                      _updateActivity(edited, a.activityId);
                                    }
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.stop),
                                  onPressed: () => _endActivity(a.activityId),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LiveActivityEditPage extends StatefulWidget {
  const _LiveActivityEditPage({this.initialData});

  final Map<String, dynamic>? initialData;

  @override
  State<_LiveActivityEditPage> createState() => _LiveActivityEditPageState();
}

class _LiveActivityEditPageState extends State<_LiveActivityEditPage> {
  late final TextEditingController _titleController;
  late final TextEditingController _authorController;
  late final TextEditingController _coverController;
  late final TextEditingController _pageController;

  @override
  void initState() {
    super.initState();
    final Map<String, dynamic> init = widget.initialData ?? <String, dynamic>{};
    _titleController = TextEditingController(
      text: init['bookTitle'] as String? ?? 'Untitled',
    );
    _authorController = TextEditingController(
      text: init['author'] as String? ?? 'Unknown',
    );
    _coverController = TextEditingController(
      text: init['coverUrl'] as String? ?? '',
    );
    _pageController = TextEditingController(
      text: init['page']?.toString() ?? '1',
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _coverController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _submit() {
    final Map<String, dynamic> result = <String, dynamic>{
      'bookTitle': _titleController.text.trim(),
      'author': _authorController.text.trim(),
      'coverUrl': _coverController.text.trim(),
      'page': int.tryParse(_pageController.text.trim()) ?? 1,
    };
    Navigator.of(context).pop(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Activity')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Book Title'),
            ),
            TextField(
              controller: _authorController,
              decoration: const InputDecoration(labelText: 'Author'),
            ),
            TextField(
              controller: _coverController,
              decoration: const InputDecoration(labelText: 'Cover URL'),
            ),
            TextField(
              controller: _pageController,
              decoration: const InputDecoration(labelText: 'Page'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _submit, child: const Text('Save')),
          ],
        ),
      ),
    );
  }
}
