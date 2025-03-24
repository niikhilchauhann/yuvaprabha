import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:yuvaprabha/core/provider/theme_provider.dart';
import 'package:yuvaprabha/features/courses/data/course_model.dart';

import '../../config/api/export.dart';

class CourcesScreen extends StatefulWidget {
  const CourcesScreen({super.key});

  @override
  State<CourcesScreen> createState() => _CourcesScreenState();
}

class _CourcesScreenState extends State<CourcesScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              h16,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: isDark ? surfaceDark : surface,
                  border: Border.all(
                    color: isDark
                        ? Colors.grey.shade800
                        : Colors.blueGrey.shade100,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(CupertinoIcons.search),
                    w12,
                    Text('Search courses and more...'),
                  ],
                ),
              ),
              h8,
              Div(
                isDark,
              ),
              h24,
              Column(
                children: [
                  Image.asset('assets/courses.png'),
                  h16,
                  Text(
                    'Online courses with free certificates',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                  ),
                  h4,
                  Text(
                    "100+ courses with free certificates from Harvard, Stanford, Google, Microsoft, Linkedin Learning, IBM and many more.",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  h16,
                ],
              ),
              h4,
              Div(
                isDark,
              ),
              h8,
              Column(
                children: coursesMap
                    .map(
                      (course) => _courseCard(course, isDark).pOnly(bottom: 8),
                    )
                    .toList(),
              ),
              h8,
            ],
          ).px(16),
        ),
      ),
    );
  }

  //   return Consumer<ThemeProvider>(
  //     builder: (context, themeProvider, child) =>
  //         AnnotatedRegion<SystemUiOverlayStyle>(
  //       value: SystemUiOverlayStyle(
  //         systemNavigationBarColor:
  //             themeProvider.isDarkMode ? surfaceDark : surface,
  //         systemNavigationBarIconBrightness:
  //             themeProvider.isDarkMode ? Brightness.light : Brightness.dark,
  //       ),
  //       child: Scaffold(
  //         body: Stack(
  //           children: [
  //             WebViewWidget(controller: _controller),
  //             ValueListenableBuilder<bool>(
  //               valueListenable: _isLoading,
  //               builder: (context, isLoading, child) {
  //                 return isLoading
  //                     ? Center(
  //                         child: CircularProgressIndicator(),
  //                       )
  //                     : SizedBox.shrink();
  //               },
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _courseCard(CourseModel course, bool isDark) {
    return GestureDetector(
      onTap: () {
        launchUrlString(course.url, mode: LaunchMode.externalApplication);
      },
      child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: isDark ? surfaceDark : surface,
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 2),
                color: Colors.black26,
                blurRadius: 4,
              )
            ],
            border: Border.all(
                color: isDark ? Colors.transparent : Colors.grey[300]!),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 190,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                        course.imageUrl,
                      ),
                    ),
                  ),
                ),
              ),
              h4,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'By:',
                      ),
                      h4,
                      CachedNetworkImage(
                        imageUrl: course.sourceLogo,
                        height: 18,
                        alignment: Alignment.center,
                      ),
                    ],
                  ),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     h4,
                  //     Text(
                  //       'Type: ',
                  //     ),
                  //     Text(
                  //       '${course.type} (${course.level})',
                  //       style: TextStyle(
                  //         fontSize: 16,
                  //         fontWeight: FontWeight.w600,
                  //       ),
                  //     ),
                  //   ],
                  // )
                ],
              ),
              h8,
              Text(
                course.name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  decoration: TextDecoration.underline,
                ),
              ),
              h8,
              Text(
                course.desc,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              h8,
              Div(
                isDark,
              ),
              _buildCourseDetails(
                  Icons.stacked_line_chart_rounded, course.skills.join(', ')),
              Div(
                isDark,
              ),
              _buildCourseDetails(CupertinoIcons.money_dollar,
                  '${course.type} (${course.level})'),
              Div(
                isDark,
              ),
              _buildCourseDetails(CupertinoIcons.time, course.time),
              Div(
                isDark,
              ),
              _buildCourseDetails(CupertinoIcons.gift, course.reward),
              h8,
            ],
          )),
    ).pOnly(bottom: 8);
  }
}

class Div extends StatelessWidget {
  final bool isDark;
  const Div(
    this.isDark, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: isDark ? Colors.grey.shade800 : Colors.blueGrey.shade100,
    );
  }
}

_buildCourseDetails(IconData icon, String text) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      w12,
      Icon(
        icon,
        size: 18,
      ),
      w12,
      Expanded(child: Text(text)),
    ],
  );
}

List<CourseModel> coursesMap = [
  CourseModel.fromMap(
    {
      'name': 'JavaScript Algorithms and Data Structures',
      'desc':
          "You'll learn the fundamentals of JavaScript including variables, arrays, objects, loops, and functions. You'll also learn: Object Oriented Programming (OOP) and Functional Programming (FP).",
      'level': 'Beginner',
      'time': '4 hours',
      'imageUrl':
          'https://d3f1iyfxxz8i1e.cloudfront.net/courses/course_image/35bcbdb482fb.png',
      'url':
          'https://www.freecodecamp.org/learn/javascript-algorithms-and-data-structures',
      'source': 'freeCodeCamp',
      'sourceLogo':
          'https://ccweb.imgix.net/https%3A%2F%2Fwww.classcentral.com%2Fimages%2Flogos%2Fproviders%2Ffreecodecamp-hz.png?auto=format&h=40&ixlib=php-4.1.0&s=e78a2cf5210dbbd8137ee21b4a03ead4',
      'type': 'Free',
      'reward': 'Free Certificate',
      'skills': [
        'JavaScript',
        'DSA',
      ],
    },
  ),
  CourseModel.fromMap(
    {
      'name': 'Introduction to JavaScript',
      'desc':
          "This is an introductory level microlearning course aimed at explaining what Generative AI is, how it is used, and how it differs from traditional machine learning methods. It also covers Google Tools to help you develop your own Gen AI apps.",
      'level': 'Beginner',
      'time': '4 hours',
      'imageUrl':
          'https://d3f1iyfxxz8i1e.cloudfront.net/courses/course_image_variant/8bee0d1a527b_w480.webp',
      'url':
          'http://learn.codesignal.com/preview/course-paths/14/fullstack-engineering-with-javascript',
      'source': 'Code Signal',
      'sourceLogo': 'https://www.classcentral.com/provider/codesignal',
      'type': 'Free',
      'reward': 'Free Certificate',
      'skills': [
        'GenAI',
        'Deep Learning',
        'ResAI',
      ],
    },
  ),
  CourseModel.fromMap(
    {
      'name': 'Introduction to Generative AI',
      'desc':
          "This is an introductory level microlearning course aimed at explaining what Generative AI is, how it is used, and how it differs from traditional machine learning methods. It also covers Google Tools to help you develop your own Gen AI apps.",
      'level': 'Beginner',
      'time': '4 hours',
      'imageUrl':
          'https://d3f1iyfxxz8i1e.cloudfront.net/courses/course_image_variant/d1d31ada5da1_w240.webp',
      'url': 'https://www.cloudskillsboost.google/course_templates/536',
      'source': 'freeCodeCamp',
      'sourceLogo':
          'https://ccweb.imgix.net/https%3A%2F%2Fwww.classcentral.com%2Fimages%2Flogos%2Finstitutions%2Fgoogle-hz.png?auto=format&h=60&ixlib=php-4.1.0&s=7a257ee53b1181c183bdfacf0679931a',
      'type': 'Free',
      'reward': 'Free Certificate',
      'skills': [
        'GenAI',
        'Deep Learning',
        'ResAI',
      ],
    },
  ),
];
