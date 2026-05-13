import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holly_quran/features/hajj_tracker/data/hajj_tracker_steps.dart';
import 'package:holly_quran/features/hajj_tracker/presentation/cubit/hajj_tracker_cubit.dart';
import 'package:holly_quran/features/hajj_tracker/presentation/cubit/hajj_tracker_state.dart';
import 'package:holly_quran/features/hajj_tracker/presentation/views/hajj_tracker_congrats_view.dart';
import 'package:holly_quran/features/hajj_tracker/presentation/views/hajj_tracker_restart.dart';

/// Single long scroll: intro + sequential ritual cards.
///
/// Expects a parent [BlocProvider<HajjTrackerCubit>]. When all steps complete,
/// opens [HajjTrackerCongratsView].
class HajjTrackerScrollView extends StatefulWidget {
  const HajjTrackerScrollView({super.key});

  @override
  State<HajjTrackerScrollView> createState() => _HajjTrackerScrollViewState();
}

class _HajjTrackerScrollViewState extends State<HajjTrackerScrollView> {
  bool _congratsRouteScheduled = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _tryOpenCongrats());
  }

  void _tryOpenCongrats() {
    if (!mounted) return;
    final cubit = context.read<HajjTrackerCubit>();
    if (!cubit.state.allComplete) {
      _congratsRouteScheduled = false;
      return;
    }
    if (_congratsRouteScheduled) return;
    _congratsRouteScheduled = true;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const HajjTrackerCongratsView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HajjTrackerCubit, HajjTrackerState>(
      listenWhen: (p, c) => p.allComplete != c.allComplete,
      listener: (context, state) {
        if (!state.allComplete) {
          _congratsRouteScheduled = false;
          return;
        }
        _tryOpenCongrats();
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: const Color(0xFFF2F4F3),
          appBar: AppBar(
            backgroundColor: const Color(0xFF0F5847),
            foregroundColor: Colors.white,
            elevation: 0,
            title: BlocBuilder<HajjTrackerCubit, HajjTrackerState>(
              buildWhen: (a, b) => a.pilgrimName != b.pilgrimName,
              builder: (context, state) {
                final n = state.pilgrimName.trim();
                return Text(
                  n.isEmpty ? 'متابعة أعمال الحاج' : 'متابعة أعمال الحاج — $n',
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                );
              },
            ),
            actions: [
              TextButton(
                onPressed: () => confirmRestartHajjToWelcome(context),
                child: const Text(
                  'ابدأ من جديد',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          body: BlocBuilder<HajjTrackerCubit, HajjTrackerState>(
            builder: (context, state) {
              return CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    sliver: SliverToBoxAdapter(
                      child: _IntroHeader(pilgrimName: state.pilgrimName.trim()),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final def = kHajjTrackerSteps[index];
                          final showGroup = def.sideLabel != null;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                if (showGroup)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 6),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: def.background.withValues(alpha: 0.9),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          def.sideLabel!,
                                          style: TextStyle(
                                            color: _onStepCard(def.background),
                                            fontFamily: 'Cairo',
                                            fontWeight: FontWeight.w800,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                _HajjStepCard(
                                  definition: def,
                                  done: state.isDone(index),
                                  locked: !state.isDone(index) && !state.canTurnOn(index),
                                  onToggle: () => _onStepTap(context, index),
                                ),
                              ],
                            ),
                          );
                        },
                        childCount: kHajjTrackerStepCount,
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 32)),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  static Color _onStepCard(Color bg) {
    return bg.computeLuminance() > 0.62
        ? const Color(0xFF1A2421)
        : Colors.white;
  }

  Future<void> _onStepTap(BuildContext context, int index) async {
    final cubit = context.read<HajjTrackerCubit>();
    final state = cubit.state;
    if (!state.isDone(index) && !state.canTurnOn(index)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(
            'أكمل الخطوة السابقة أولاً',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      );
      return;
    }
    await cubit.toggleStep(index);
  }
}

class _IntroHeader extends StatelessWidget {
  const _IntroHeader({required this.pilgrimName});

  final String pilgrimName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF2D9596),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            pilgrimName.isEmpty
                ? 'رحلة الإيمان تبدأ من النية الصادقة وتنتهي بالمغفرة والرضوان'
                : 'اللهم بارك لك يا $pilgrimName — رحلة الإيمان تبدأ من النية الصادقة وتنتهي بالمغفرة والرضوان',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w800,
              fontSize: 15,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'هذه البطاقة تساعدك على متابعة أعمالك خطوة بخطوة لتؤدي نسكك على أكمل وجه. '
            '(البطاقة مخصّصة للحاج المتمتع.)',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.95),
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w600,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _HajjStepCard extends StatelessWidget {
  const _HajjStepCard({
    required this.definition,
    required this.done,
    required this.locked,
    required this.onToggle,
  });

  final HajjStepDefinition definition;
  final bool done;
  final bool locked;
  final VoidCallback onToggle;

  Color _onBg() {
    return definition.background.computeLuminance() > 0.62
        ? const Color(0xFF1A2421)
        : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    final onBg = _onBg();
    final border = done
        ? Border.all(color: Colors.white.withValues(alpha: 0.85), width: 2)
        : Border.all(color: Colors.black12);

    return Material(
      color: definition.background,
      borderRadius: BorderRadius.circular(18),
      elevation: locked ? 0 : 2,
      shadowColor: Colors.black26,
      child: InkWell(
        onTap: onToggle,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: border,
          ),
          padding: const EdgeInsets.fromLTRB(12, 14, 12, 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CheckColumn(done: done, locked: locked),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: onBg.withValues(alpha: 0.15),
                          foregroundColor: onBg,
                          radius: 22,
                          child: Icon(definition.icon, size: 24),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            definition.title,
                            style: TextStyle(
                              color: onBg,
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.w900,
                              fontSize: 15,
                              height: 1.25,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      definition.body,
                      style: TextStyle(
                        color: onBg.withValues(alpha: 0.92),
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CheckColumn extends StatelessWidget {
  const _CheckColumn({required this.done, required this.locked});

  final bool done;
  final bool locked;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      alignment: Alignment.topCenter,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 34,
        height: 52,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: locked ? 0.45 : 0.95),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: done ? const Color(0xFF0F5847) : Colors.black26,
            width: done ? 2.2 : 1,
          ),
        ),
        child: Icon(
          done ? Icons.check_rounded : Icons.circle_outlined,
          color: done
              ? const Color(0xFF0F5847)
              : (locked ? Colors.grey : Colors.black38),
          size: done ? 28 : 18,
        ),
      ),
    );
  }
}
