import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yuvaprabha/features/resume/presentation/use_template_screen.dart';

import '../../../config/api/export.dart';
import '../../../core/provider/theme_provider.dart';

// class ResumeScreen extends StatefulWidget {
//   const ResumeScreen({super.key});

//   @override
//   State<ResumeScreen> createState() => _ResumeScreenState();
// }

// class _ResumeScreenState extends State<ResumeScreen> {
//   late final WebViewController _controller;
//   final ValueNotifier<bool> _isLoading = ValueNotifier(true);

//   @override
//   void initState() {
//     super.initState();
//     _controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setNavigationDelegate(NavigationDelegate(
//         onPageStarted: (url) {
//           _isLoading.value = true;
//         },
//         onPageFinished: (url) {
//           _isLoading.value = false;
//         },
//       ))
//       ..loadRequest(Uri.parse('https://app.flowcv.com/resumes'));
//   }

//   @override
//   void dispose() {
//     _isLoading.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ThemeProvider>(
//       builder: (context, themeProvider, child) =>
//           AnnotatedRegion<SystemUiOverlayStyle>(
//         value: SystemUiOverlayStyle(
//           systemNavigationBarColor:
//               themeProvider.isDarkMode ? surfaceDark : surface,
//           systemNavigationBarIconBrightness:
//               themeProvider.isDarkMode ? Brightness.light : Brightness.dark,
//         ),
//         child:
//           Scaffold(
//             body:
//             Stack(
//               children: [
//                 WebViewWidget(controller: _controller),
//                 ValueListenableBuilder<bool>(
//                   valueListenable: _isLoading,
//                   builder: (context, isLoading, child) {
//                     return isLoading
//                         ? Center(
//                             child: CircularProgressIndicator(),
//                           )
//                         : SizedBox.shrink();
//                   },
//                 ),
//               ],
//             ),
//           ),

//       ),
//     );
//   }
// }

class ResumeScreen extends StatelessWidget {
  const ResumeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // _buildHeader(),
            h12,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  _tabButton("Resume", isSelected: true, isDark: isDark),
                  _tabButton("Cover Letter", isDark: isDark),
                  // _tabButton("Job Tracker"),
                ],
              ),
            ),
            _buildResumeSection(context, isDark),
          ],
        ),
      ),
    );
  }

  Widget _tabButton(String text,
      {bool isSelected = false, bool isDark = false}) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected
            ? primary
            : isDark
                ? surfaceDark
                : Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected
                ? Colors.grey.shade200
                : isDark
                    ? onSurfaceDark
                    : Colors.black),
      ),
    );
  }

  Widget _buildResumeSection(BuildContext context, bool isDark) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Start building your resume",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              "Your first resume – 100% free, all design features, unlimited downloads – yes really.",
              style: TextStyle(
                  fontSize: 14,
                  color: isDark ? onSurfaceDark : Colors.grey[700]),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 0.72,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _resumeTemplate(
                    isDark,
                    context,
                    id: 1,
                    isBlank: true,
                    label: "New blank",
                  ),
                  _resumeTemplate(
                    isDark,
                    context,
                    id: 2,
                    imagePath: "assets/resume1.png",
                    label: "Anna Garfield",
                  ),
                  _resumeTemplate(
                    isDark,
                    context,
                    id: 4,
                    imagePath: "assets/resume2.png",
                    label: "Single Page Jack's CV",
                  ),
                  _resumeTemplate(
                    isDark,
                    context,
                    id: 3,
                    imagePath: "assets/resume3.png",
                    label: "Deedy CV",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _resumeTemplate(bool isDark, BuildContext context,
      {String? imagePath,
      bool isBlank = false,
      required String label,
      int id = 1}) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => UseTemplateScreen(
              id: id,
            ),
          )),
      borderRadius: BorderRadius.circular(12),
      child: Ink(
        decoration: BoxDecoration(
          color: isDark ? surfaceDark : surface,
          boxShadow: [cardshadow],
          border: Border.all(
              color: isDark ? Colors.transparent : Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Expanded(
              child: isBlank
                  ? Center(child: Icon(Icons.add, size: 40, color: Colors.grey))
                  : Image.asset(imagePath!, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
