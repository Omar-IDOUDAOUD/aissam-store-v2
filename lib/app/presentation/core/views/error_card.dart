import 'package:aissam_store_v2/core/failure.dart';
import 'package:aissam_store_v2/app/presentation/core/constants.dart';
import 'package:aissam_store_v2/app/presentation/core/views/buttons/tertiary.dart';
import 'package:aissam_store_v2/utils/extentions/theme.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ErrorCard extends StatelessWidget {
  const ErrorCard({
    super.key,
    required this.error,
    this.horizontalPadding,
    this.onRety,
    this.addPageMargine = false,
    this.height,
    this.width,
    this.showDescription = false,
  });

  final double? horizontalPadding;
  final bool addPageMargine;
  final Object error;
  final VoidCallback? onRety;
  final double? height;
  final double? width;
  final bool showDescription;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal:
              addPageMargine ? ViewConsts.pagePadding : horizontalPadding ?? 0),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: height ?? 300,
          maxWidth: width ?? MediaQuery.sizeOf(context).width,
        ),
        child: error is NetworkFailure
            ? _NoInternetConnErrorCard(
                onRety: onRety, showDescription: showDescription)
            : _UnknownErrorCard(
                error: error, onRety: onRety, showDescription: showDescription),
      ),
    );
  }
}

class _UnknownErrorCard extends StatelessWidget {
  const _UnknownErrorCard({
    super.key,
    required this.error,
    required this.onRety,
    this.showDescription = true,
  });

  final Object error;
  final VoidCallback? onRety;
  final bool showDescription;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxHeight < 150 && constraints.maxWidth > 180)
        return _HorizontalLayoutCard(
          icon: FluentIcons.error_circle_20_regular,
          iconColor: Colors.redAccent.shade100,
          title: 'Error occurred!',
          description: showDescription ? error.toString() : null,
          onRety: onRety,
        );
      else
        return _VerticalLayoutCard(
          icon: FluentIcons.error_circle_20_regular,
          iconColor: Colors.redAccent.shade100,
          title: 'Error occurred!',
          description: showDescription ? error.toString() : null,
          onRety: onRety,
        );
    });
  }
}

class _NoInternetConnErrorCard extends StatelessWidget {
  const _NoInternetConnErrorCard({
    super.key,
    required this.onRety,
    this.showDescription = true,
  });
  final VoidCallback? onRety;
  final bool showDescription;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxHeight < 150 && constraints.maxWidth > 180)
        return _HorizontalLayoutCard(
          icon: FluentIcons.wifi_off_24_regular,
          iconColor: Colors.redAccent.shade100,
          title: 'No connection!',
          description:
              showDescription ? 'Check you connection and try again' : null,
          onRety: onRety,
        );
      else
        return _VerticalLayoutCard(
          icon: FluentIcons.wifi_off_24_regular,
          iconColor: Colors.redAccent.shade100,
          title: 'No connection!',
          description:
              showDescription ? 'Check you connection and try again' : null,
          onRety: onRety,
        );
    });
  }
}

class _HorizontalLayoutCard extends StatelessWidget {
  const _HorizontalLayoutCard(
      {super.key,
      required this.icon,
      required this.iconColor,
      required this.title,
      this.description,
      this.onRety});
  final IconData icon;
  final Color iconColor;
  final String title;
  final String? description;
  final VoidCallback? onRety;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 30,
          // color: Colors.redAccent.shade100,
          color: iconColor,
        ),
        const SizedBox(width: 10),

        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: context.textTheme.bodyMedium,
              ),
              const SizedBox(height: 2),
              if (description != null)
                Text(
                  description!,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.bodyMedium,
                ),
            ],
          ),
        ),

        if (onRety != null) ...[
          const SizedBox(width: 5),
          Center(
            child: TertiaryRoundedButton(
              label: 'Rety',
              onPressed: onRety,
            ),
          ),
        ],

        // const SizedBox(width: ViewConsts.pagePadding),
      ],
    );
  }
}

class _VerticalLayoutCard extends StatelessWidget {
  const _VerticalLayoutCard(
      {super.key,
      required this.icon,
      required this.iconColor,
      required this.title,
      this.description,
      this.onRety});
  final IconData icon;
  final Color iconColor;
  final String title;
  final String? description;
  final VoidCallback? onRety;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Spacer(flex: 2),
        Icon(
          icon,
          size: 30,
          color: iconColor,
        ),
        const SizedBox(height: 10),
        Text(
          title,
          textAlign: TextAlign.center,
          style: context.textTheme.bodyMedium,
        ),
        const SizedBox(height: 2),
        if (description != null)
          Text(
            description!,
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium,
          ),
        if (onRety != null) ...[
          const Spacer(),
          Center(
            child: TertiaryRoundedButton(
              label: 'Rety',
              onPressed: onRety,
            ),
          ),
        ],
        const Spacer(flex: 2),
      ],
    );
  }
}
