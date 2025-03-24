import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../../../core/provider/resume_data_provider.dart';

class LatexGenerator {
  static Future<File> generateLatexFile(ResumeDataProvider resumeData) async {
    String latexContent = '''
\\documentclass[letterpaper,11pt]{article}
\\usepackage{latexsym}
\\usepackage[empty]{fullpage}
\\usepackage{titlesec}
\\usepackage{hyperref}
\\usepackage{fancyhdr}
\\usepackage{tabularx}
\\usepackage{fontawesome5}
\\usepackage{multicol}
\\setlength{\\multicolsep}{-3.0pt}
\\setlength{\\columnsep}{-1pt}

\\begin{document}

%----------HEADING----------
\\begin{center}
    {\\Huge \\scshape ${resumeData.fullName}} \\\\ \\vspace{1pt}
    ${resumeData.address} \\\\ \\vspace{1pt}
    \\small \\raisebox{-0.1\\height}\\faPhone\\ ${resumeData.phone} ~ \\href{mailto:${resumeData.email}}{\\raisebox{-0.2\\height}\\faEnvelope\\ \\underline{${resumeData.email}}} ~ 
\\end{center}

%-----------EDUCATION-----------
\\section{Education}
  \\begin{itemize}
    ${resumeData.education.map((edu) => '''
      \\item {\\textbf{${edu['degree']}} at ${edu['college']} (${edu['startYear']} - ${edu['endYear']})}
    ''').join('')}
  \\end{itemize}

%-----------EXPERIENCE-----------
\\section{Experience}
  \\begin{itemize}
    ${resumeData.experience.map((exp) => '''
      \\item {\\textbf{${exp['title']}} at ${exp['company']} (${exp['startDate']} - ${exp['endDate']})}
    ''').join('')}
  \\end{itemize}

%-----------SKILLS-----------
\\section{Skills}
  \\begin{itemize}
    ${resumeData.skills.map((skill) => '\\item $skill').join('\n')}
  \\end{itemize}

\\end{document}
    ''';

    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/resume.tex';
    final file = File(filePath);
    await file.writeAsString(latexContent);

    return file;
  }
}
