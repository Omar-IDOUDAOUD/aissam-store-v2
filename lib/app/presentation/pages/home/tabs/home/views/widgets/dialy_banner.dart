import 'package:aissam_store_v2/app/presentation/core/constants.dart';
import 'package:aissam_store_v2/utils/extensions.dart';
import 'package:flutter/material.dart';

class DialyBanner extends StatefulWidget {
  const DialyBanner({super.key});

  @override
  State<DialyBanner> createState() => _DialyBannerState();
}

const _cardPadding = 4.5;

class _DialyBannerState extends State<DialyBanner> {
  late final PageController _pageController;

  bool _init = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_init) return;
    _init = true;

    final w = MediaQuery.of(context).size.width;
    final w2 = w - ViewConsts.pagePadding * 2 + _cardPadding * 2;
    final p = w2 / w;
    _pageController = PageController(viewportFraction: p)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  double _buildRadius(int i, int length) {
    final diff = (i - (_pageController.hasClients ? _pageController.page! : 0))
        .abs()
        .round();
    if (diff > 1 && (i == 0 || i == length - 1)) return 1;
    if (diff > 1 && (i == 1 || i == length - 2)) return 2;
    return 3;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 150,
          child: PageView(
            controller: _pageController,
            children: const [
              _Card(color: Colors.green),
              _Card(color: Colors.pink),
              _Card(color: Colors.blue),
              _Card(color: Colors.brown),
              _Card(color: Colors.purple),
            ],
          ),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            5,
            (i) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: CircleAvatar(
                  radius: _buildRadius(i, 5),
                  backgroundColor: i ==
                          (_pageController.hasClients
                                  ? _pageController.page!
                                  : 0)
                              .round()
                      ? context.theme.colors.d
                      : context.theme.colors.s,
                ),
              );
            },
          ),
        )
      ],
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({super.key, required this.color});
  final MaterialColor color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: _cardPadding),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ViewConsts.radius),
          color: color.shade100,
          // image: image
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Get special discount',
                style: context.textTheme.bodyLarge,
              ),
              Text(
                'Up to 50 %',
                style: context.textTheme.titleSmall!.copyWith(
                  color: color.shade800,
                  height: 1,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                '15 March',
                style: context.textTheme.bodySmall!
                    .copyWith(color: context.theme.colors.s),
              ),
              const Spacer(),
              MaterialButton(
                onPressed: () {},
                height: 35,
                color: color.shade50,
                elevation: 0,
                highlightColor: color.shade700,
                splashColor: color.shade600,
                textColor: WidgetStateColor.resolveWith(
                  (states) {
                    final state = states.lastOrNull;
                    if (state == WidgetState.pressed)
                      return context.theme.colors.a;
                    return context.theme.colors.s;
                  },
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Text('Claim now'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
