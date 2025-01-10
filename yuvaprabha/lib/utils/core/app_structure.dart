import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yuvaprabha/screens/resume/resume_screen.dart';
import '/providers/theme_provider.dart';
import '/screens/home/home_screen.dart';
import '../../screens/internships/internship_screen.dart';
import '../../screens/courses/courses_screen.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import '/utils/core/export.dart';
import 'package:provider/provider.dart';

class AppStructure extends StatefulWidget {
  const AppStructure({super.key});

  @override
  State<AppStructure> createState() => _AppStructureState();
}
//best nav bars

//google_navbar
// water_drop_nav_bar
// sliding_clipped_nav_bar
// flashy_tab_bar2
// curved_navigation_bar
// dot_navigation
// custom_navigation_bar

class _AppStructureState extends State<AppStructure> {
  int _currentIndex = 0;
  List<Widget> screens = [
    HomeScreen(),
    CourcesScreen(),
    ResumeScreen(),
    InternshipScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) =>
          AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          systemNavigationBarColor:
              themeProvider.isDarkMode ? surfaceDark : surface,
          systemNavigationBarIconBrightness:
              themeProvider.isDarkMode ? Brightness.light : Brightness.dark,
        ),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Yuvaprabha App',
              style: titlelarge,
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Provider.of<ThemeProvider>(context, listen: false)
                        .changeTheme();
                  },
                  icon: Icon(Icons.dark_mode))
            ],
          ),
          body: IndexedStack(
            index: _currentIndex,
            children: screens,
          ),
          bottomNavigationBar: FlashyTabBar(
            animationCurve: Curves.linear,
            selectedIndex: _currentIndex,
            iconSize: 24,
            showElevation: true,
            onItemSelected: (index) => setState(() {
              _currentIndex = index;
            }),
            backgroundColor: themeProvider.isDarkMode ? surfaceDark : surface,
            animationDuration: Duration(milliseconds: 500),
            items: [
              FlashyTabBarItem(
                icon: Icon(Icons.home),
                title: Text('Home'),
                activeColor: themeProvider.isDarkMode ? onSecondary : onSurface,
                inactiveColor: themeProvider.isDarkMode ? secondary : primary,
              ),
              FlashyTabBarItem(
                icon: Icon(Icons.search),
                title: Text('Courses'),
                activeColor: themeProvider.isDarkMode ? onSecondary : onSurface,
                inactiveColor: themeProvider.isDarkMode ? secondary : primary,
              ),
              FlashyTabBarItem(
                icon: Icon(Icons.edit_note),
                title: Text('Resume'),
                activeColor: themeProvider.isDarkMode ? onSecondary : onSurface,
                inactiveColor: themeProvider.isDarkMode ? secondary : primary,
              ),
              FlashyTabBarItem(
                icon: Icon(Icons.business_center_outlined),
                title: Text('Internships'),
                activeColor: themeProvider.isDarkMode ? onSecondary : onSurface,
                inactiveColor: themeProvider.isDarkMode ? secondary : primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
