import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:yuvaprabha/features/resume/presentation/fill_details_screen.dart';
import 'package:yuvaprabha/features/resume/presentation/widgets/personal_details_widget.dart';

import '../../../core/provider/theme_provider.dart';
import '../../../config/api/export.dart';

import '../domain/dummy_data.dart';
import 'widgets/basic_info_widget.dart';
import 'widgets/education_widget.dart';
import 'widgets/experience_widget.dart';
import 'widgets/resume_app_bar.dart';
import 'widgets/skills_widget.dart';

class UseTemplateScreen extends StatelessWidget {
  final int id;
  const UseTemplateScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: isDark ? surfaceDark : surface,
        systemNavigationBarColor: isDark ? surfaceDark : surface,
        systemNavigationBarIconBrightness:
            isDark ? Brightness.light : Brightness.dark,
      ),
      child: Scaffold(
        // backgroundColor: Colors.blueGrey.shade50,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ResumeAppBar(id: id),
                h12,
                Center(
                  child: TextButton(
                      onPressed: () async {
                        await ResumePdfGenerator.generateAndShowPdf(
                            dummyData, id);
                      },
                      child: Text(
                        'Generate Dummy PDF',
                        style: TextStyle(
                          color: isDark ? onSurfaceDark : primary,
                        ),
                      )),
                ),
                h12,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => FillDetailsScreen(
                                screen: BasicInfoPage(), id: id),
                          ),
                        );
                      },
                      child: Ink(
                        width: size.width,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: isDark ? surfaceDark : surface,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            h8,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  radius: 56,
                                  backgroundColor: Colors.blueGrey.shade50,
                                  child: Icon(
                                    CupertinoIcons.camera_fill,
                                    color: isDark ? surfaceDark : Colors.white,
                                    size: 48,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                      CupertinoIcons.pencil_ellipsis_rectangle,
                                      color: Colors.pink),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                            h16,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Your name",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                h16,
                                Row(
                                  children: [
                                    Icon(
                                      CupertinoIcons.mail,
                                      size: 20,
                                    ),
                                    w12,
                                    Text("Email"),
                                  ],
                                ),
                                h8,
                                Row(
                                  children: [
                                    Icon(
                                      CupertinoIcons.phone,
                                      size: 20,
                                    ),
                                    w12,
                                    Text("Phone"),
                                  ],
                                ),
                                h8,
                                Row(
                                  children: [
                                    Icon(
                                      CupertinoIcons.location,
                                      size: 20,
                                    ),
                                    w12,
                                    Text("Address"),
                                  ],
                                ),
                                h16,
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    buildSection(context, "Personal Details",
                        CupertinoIcons.person, PersonalDetailsPage(), isDark),
                    buildSection(context, "Education", Icons.book,
                        EducationPage(), isDark),
                    buildSection(context, "Professional Experience", Icons.work,
                        ExperiencePage(), isDark),
                    buildSection(context, "Your Skills", Icons.add,
                        SkillsPage(), isDark),
                  ],
                ).px(16),
                h12,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSection(BuildContext context, String title, IconData icon,
      Widget page, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => FillDetailsScreen(screen: page, id: id),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: isDark ? surfaceDark : surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
                color: isDark ? Colors.transparent : Colors.grey[300]!),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    color: isDark ? onSurfaceDark : Colors.black,
                    size: 22,
                  ),
                  w12,
                  Text(
                    title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.add, color: Colors.white),
                    onPressed: () {},
                    style: IconButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      backgroundColor: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
