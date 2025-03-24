import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yuvaprabha/core/provider/theme_provider.dart';
import 'package:yuvaprabha/features/chat_bot/chat_screen.dart';
import 'package:yuvaprabha/config/extensions/webview_base.dart';
import 'package:yuvaprabha/config/api/export.dart';
import 'package:yuvaprabha/core/global/custom_route.dart';
import 'package:yuvaprabha/features/roadmaps/presentation/roadmaps_screen.dart';

import '../../core/global/custom_round_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(AppConstants.defPadInner),
        children: [
          h24,
          Text(
            "Hello!",
            style: headlinesmall.copyWith(fontSize: 28),
          ),
          Text(
            "Make your career easy with us!",
            style: headlinesmall,
          ),
          h20,
          SizedBox(
            height: size.height / 2.8,
            width: size.width,
            child: Row(
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(AppConstants.defRad),
                  overlayColor:
                      WidgetStatePropertyAll(isDark ? onSurface : secondary),
                  onTap: () => Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => ChatPage(
                        newChat: false,
                        imageSearch: false,
                      ),
                    ),
                  ),
                  child: Ink(
                    width: (size.width / 2) - (AppConstants.defPadInner) - 6,
                    padding: EdgeInsets.all(AppConstants.defPadOuter),
                    decoration: BoxDecoration(
                      color: isDark ? surfaceDark : Color(0xffd6d0fd),
                      borderRadius: BorderRadius.circular(AppConstants.defRad),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomRoundButton(
                          color: isDark
                              ? backgroundDark
                              : background.withOpacity(0.85),
                          size: 16,
                          child: Icon(
                            CupertinoIcons.mic,
                            size: 24,
                            color: isDark ? onSurfaceDark : onSurface,
                          ),
                        ),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Talk to\nYuvaPrabhaAI',
                              style: title.copyWith(
                                fontSize: 18,
                                color: isDark ? onSurfaceDark : onSurface,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Text(
                          " Let's try it now",
                          style: bodylarge.copyWith(
                            fontSize: 16,
                            color: isDark ? Colors.white60 : onSurface,
                          ),
                        ),
                        SizedBox(height: 4),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RoundWidget(
                      ontap: () => Navigator.push(
                        context,
                        createRoute(
                          ChatPage(
                            newChat: true,
                            imageSearch: false,
                          ),
                        ),
                      ),
                      heading: 'New Chat',
                      icon: CupertinoIcons.chat_bubble,
                      color: Color(0xfffeedbb),
                      widgetColor: background.withOpacity(0.85),
                    ),
                    RoundWidget(
                      ontap: () => Navigator.push(
                        context,
                        createRoute(
                          ChatPage(
                            imageSearch: true,
                          ),
                        ),
                      ),
                      heading: 'Search by\nimage',
                      icon: Icons.document_scanner_outlined,
                      iconColor: surface,
                      color: Color(0xff24252a),
                      textColor: surface,
                    ),
                  ],
                ),
              ],
            ),
          ),
          h24,
          Text(
            'Our Recommendations',
            style: title,
          ),
          h16,
          RoundWidget(
            ontap: () => Navigator.push(
              context,
              createRoute(
              RoadmapsScreen()
              ),
            ),
            heading: 'Search for Roadmaps',
            icon: CupertinoIcons.map,
            color: isDark ? surfaceDark : surface,
            widgetColor: background,
          ),
          h16,
          RoundWidget(
            ontap: () => Navigator.push(
              context,
              createRoute(
                WebViewBaseScreen(
                    heading: 'Web Development',
                    url: 'https://fullstackopen.com/en/'),
              ),
            ),
            heading: 'Learn Web Development',
            icon: CupertinoIcons.book,
            color: isDark ? surfaceDark : surface,
            widgetColor: background,
          ),
          h24
        ],
      ),
    );
  }
}

class RoundWidget extends StatelessWidget {
  final String heading;
  final IconData icon;
  final Color color;
  final Color? widgetColor;
  final VoidCallback? ontap;
  final Color? iconColor;
  final Color? textColor;

  const RoundWidget(
      {super.key,
      required this.heading,
      required this.icon,
      required this.color,
      this.ontap,
      this.widgetColor,
      this.textColor,
      this.iconColor});

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;
    final size = MediaQuery.of(context).size;

    return InkWell(
      borderRadius: BorderRadius.circular(AppConstants.defRad),
      overlayColor: WidgetStatePropertyAll(isDark ? onSurface : secondary),
      onTap: ontap,
      child: Ink(
        width: (size.width / 2) - (AppConstants.defPadInner) - 6,
        height: ((size.height / 2.8) / 2) - 6,
        padding: EdgeInsets.all(AppConstants.defPadOuter),
        decoration: BoxDecoration(
          color: isDark ? surfaceDark : color,
          borderRadius: BorderRadius.circular(AppConstants.defRad),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomRoundButton(
              color: isDark
                  ? backgroundDark
                  : (widgetColor ?? background.withOpacity(0.12)),
              size: 16,
              child: Icon(
                icon,
                size: 24,
                color: isDark ? onSurfaceDark : (iconColor ?? onSurface),
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  heading,
                  style: title.copyWith(
                    fontSize: 16,
                    color: isDark ? onSurfaceDark : (textColor ?? surfaceDark),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
