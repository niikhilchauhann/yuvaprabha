import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yuvaprabha/core/provider/theme_provider.dart';
import 'package:yuvaprabha/config/api/export.dart';

import '../../core/global/custom_route.dart';
import 'widgets/job_confirmation_screen.dart';

class InternshipScreen extends StatefulWidget {
  const InternshipScreen({super.key});

  @override
  State<InternshipScreen> createState() => _InternshipScreenState();
}

class _InternshipScreenState extends State<InternshipScreen> {
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;

    jobs(String job) {
      return Container(
        height: 300,
        width: 300,
        decoration: BoxDecoration(
            color: isDark ? backgroundDark : Colors.white,
            borderRadius: BorderRadius.circular(25.0)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: isDark
                            ? surfaceDark
                            : Colors.blue.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Image.asset(
                        "assets/images/google.png",
                        height: 18,
                        width: 18,
                      ),
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.favorite_border,
                    color: isDark ? onSurfaceDark : Colors.grey,
                    size: 24,
                  )
                ],
              ),
              h16,
              Text(
                "Google LLC",
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                    fontSize: 13),
              ),
              Text(
                job,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                    fontSize: 18),
              ),
              h16,
              Text(
                "Mountain View, California\nUnited States",
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                    fontSize: 13),
              ),
            ],
          ),
        ),
      );
    }

    jobCategory(String category, Color? color1, Color color2) {
      return Container(
        decoration: BoxDecoration(
            color: color1, borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Center(
            child: Text(
              category,
              style: TextStyle(
                  color: color2,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                  fontSize: 13),
            ),
          ),
        ),
      );
    }

    void openBottomSheet() {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(top: AppConstants.defPadOuter),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.85,
              decoration: BoxDecoration(
                  color: isDark ? backgroundDark : background,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: AppConstants.defPadInner,
                        horizontal: AppConstants.defPadOuter),
                    child: Row(
                      children: [
                        Spacer(),
                        IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(Icons.close)),
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                          color: isDark
                              ? surfaceDark
                              : Colors.blue.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Image.asset(
                          "assets/images/google.png",
                          height: 45,
                          width: 45,
                        ),
                      ),
                    ),
                  ),
                  h16,
                  Center(
                    child: Text(
                      "Visual Designer",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                    ),
                  ),
                  Center(
                    child: Text(
                      "Google LLC/Mountain View",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                  ),
                  h24,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 45,
                        decoration: BoxDecoration(
                            color: isDark ? surfaceDark : Colors.blue[50],
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: AppConstants.defPadInner),
                          child: Center(
                            child: Text(
                              "Description",
                              style: TextStyle(
                                  color: Colors.lightBlue,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                  fontSize: 13),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 45,
                        decoration: BoxDecoration(
                            color: isDark ? surfaceDark : Colors.grey[100],
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: AppConstants.defPadInner),
                          child: Center(
                            child: Text(
                              "Company",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                  fontSize: 13),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 45,
                        decoration: BoxDecoration(
                            color: isDark ? surfaceDark : Colors.grey[100],
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: AppConstants.defPadOuter),
                          child: Center(
                            child: Text(
                              "Reviews",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                  fontSize: 13),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  h24,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4 * 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Minimum Qualifications",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                              fontSize: 20),
                        ),
                        SizedBox(
                          height: 2 * 8,
                        ),
                        bulletPoints(
                            "Bachelor's degree in design or equivalent practical experience"),
                        SizedBox(height: 6),
                        bulletPoints(
                            "Experience designing across multiple platforms"),
                        SizedBox(height: 6),
                        bulletPoints(
                            "Experience in working as a team implementing CI/CD and Kubernetes")
                      ],
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    height: 80,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4 * 5),
                      child: Row(
                        children: [
                          Container(
                            height: 7.5 * 8,
                            width: 15 * 5,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.blue, width: 2)),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Icon(
                                Icons.favorite_border,
                                color: Colors.blue,
                                size: 7 * 4,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 2 * 5,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () => Navigator.push(context,
                                  createRoute(JobConfirmationScreen())),
                              child: Container(
                                height: 7.5 * 8,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: Center(
                                  child: Text(
                                    "Apply Here",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.5,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  h24,
                ],
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            h20,
            Padding(
              padding: EdgeInsets.only(
                  top: AppConstants.defPadOuter,
                  left: AppConstants.defPadOuter),
              child: Text(
                "Hey there! Let's find a\njob for you",
                style: headlinesmall.copyWith(fontSize: 28),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(AppConstants.defPadOuter),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: isDark
                              ? surfaceDark
                              : Colors.blue.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppConstants.defPadInner,
                            vertical: AppConstants.defPadInner),
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
                                controller: search,
                                keyboardType: TextInputType.text,
                                cursorColor: Colors.blue,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                                decoration: InputDecoration.collapsed(
                                  hintText: "Search job profile",
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  w16,
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isDark
                            ? surfaceDark
                            : Colors.blue.withOpacity(0.05)),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Icon(
                        Icons.sort,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            h16,
            Container(
              decoration: BoxDecoration(
                  color: isDark ? surfaceDark : Colors.blue.withOpacity(0.05),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      bottomLeft: Radius.circular(40))),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppConstants.defPadOuter,
                        vertical: 2 * AppConstants.defPadInner),
                    child: Row(
                      children: [
                        Text(
                          "Popular Jobs",
                          style: title.copyWith(fontSize: 18),
                        ),
                        Spacer(),
                        Text(
                          "View all",
                          style: TextStyle(
                              color: isDark ? Colors.grey : Colors.blueGrey,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                              fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 215,
                    child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(
                          horizontal: AppConstants.defPadOuter),
                      scrollDirection: Axis.horizontal,
                      children: [
                        GestureDetector(
                          onTap: () {
                            openBottomSheet();
                          },
                          child: jobs("SDE III (Backend)"),
                        ),
                        w16,
                        GestureDetector(
                          onTap: () {
                            openBottomSheet();
                          },
                          child: jobs("UI/UX Designer"),
                        ),
                        w16,
                        GestureDetector(
                          onTap: () {
                            openBottomSheet();
                          },
                          child: jobs("Design System Developer"),
                        ),
                      ],
                    ),
                  ),
                  h24,
                  h24,
                ],
              ),
            ),
            h24,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5 * 5),
              child: Row(
                children: [
                  Text(
                    "Job Categories",
                    style: title.copyWith(fontSize: 18),
                  ),
                  Spacer(),
                  Text(
                    "View all",
                    style: TextStyle(
                        color: isDark ? Colors.grey : Colors.blueGrey,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                        fontSize: 14),
                  ),
                ],
              ),
            ),
            h20,
            SizedBox(
              height: 48,
              child: ListView(
                padding:
                    EdgeInsets.symmetric(horizontal: AppConstants.defPadOuter),
                scrollDirection: Axis.horizontal,
                children: [
                  jobCategory("Design Job", Colors.blue[50], Colors.blue),
                  w12,
                  jobCategory("Development", Colors.red[50], Colors.red),
                  w12,
                  jobCategory(
                      "Sales", Colors.orange[50], Colors.orange.shade800),
                  w12,
                  jobCategory("Marketing", Colors.purple[50], Colors.purple),
                  w12,
                  jobCategory("Engineer", Colors.teal[50], Colors.teal),
                ],
              ),
            ),
            h24,
            Container(
              decoration: BoxDecoration(
                  color: isDark ? surfaceDark : Colors.blue.withOpacity(0.05),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      bottomLeft: Radius.circular(40))),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppConstants.defPadOuter,
                        vertical: 2 * AppConstants.defPadInner),
                    child: Row(
                      children: [
                        Text(
                          "Recommended for you",
                          style: title.copyWith(fontSize: 18),
                        ),
                        Spacer(),
                        Text(
                          "View all",
                          style: TextStyle(
                              color: isDark ? Colors.grey : Colors.blueGrey,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                              fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 215,
                    child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(
                          horizontal: AppConstants.defPadOuter),
                      scrollDirection: Axis.horizontal,
                      children: [
                        GestureDetector(
                          onTap: () {
                            openBottomSheet();
                          },
                          child: jobs("SDE III (Frontend)"),
                        ),
                        w16,
                        GestureDetector(
                          onTap: () {
                            openBottomSheet();
                          },
                          child: jobs("App Developer"),
                        ),
                        w16,
                        GestureDetector(
                          onTap: () {
                            openBottomSheet();
                          },
                          child: jobs("Quality Analyst"),
                        ),
                      ],
                    ),
                  ),
                  h24,
                  h24,
                ],
              ),
            ),
            h24,
            h24,
          ],
        ),
      ),
    );
  }

  Row bulletPoints(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 3.0,
            backgroundColor: Colors.grey,
          ),
        ),
        SizedBox(
          width: 2 * 5,
        ),
        Expanded(
          child: Text(
            text,
            maxLines: 2,
            style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
                fontSize: 14),
          ),
        ),
      ],
    );
  }
}
