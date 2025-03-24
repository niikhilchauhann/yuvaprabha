import 'dart:io';

import 'package:flutter/services.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../core/provider/resume_data_provider.dart';
import 'package:pdf/pdf.dart';

class ResumePdfGenerator {
  static Future<void> generateAndShowPdf(
      ResumeDataProvider resumeData, int resumeId) async {
    final pdf = pw.Document();

    final regularFont =
        await rootBundle.load('assets/font/Montserrat-Regular.ttf');
    final boldFont = await rootBundle.load('assets/font/Montserrat-Bold.ttf');
    final lightFont = await rootBundle.load('assets/font/Montserrat-Light.ttf');

    final ttfRegular = pw.Font.ttf(regularFont);
    final ttfBold = pw.Font.ttf(boldFont);
    final ttfLight = pw.Font.ttf(lightFont);

    if (resumeId == 1) {
      pdf.addPage(
        pw.MultiPage(
          theme: pw.ThemeData(
              defaultTextStyle: pw.TextStyle(
                  letterSpacing: 0.5,
                  wordSpacing: 2,
                  lineSpacing: 5,
                  font: ttfRegular,
                  fontBold: ttfBold,
                  fontNormal: ttfRegular)),
          build: (pw.Context context) => [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: <pw.Widget>[
                pw.Align(
                  child: pw.Text(resumeData.fullName.toUpperCase(),
                      textScaleFactor: 2,
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold, letterSpacing: 6)),
                ),
                pw.SizedBox(height: 10),
                pw.Align(
                  child: pw.Text(resumeData.jobTitle,
                      textScaleFactor: 1.2,
                      style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold, letterSpacing: 3)),
                ),
                pw.SizedBox(height: 20),
                pw.Container(
                  width: double.infinity,
                  child: pw.Wrap(
                    alignment: pw.WrapAlignment.center,
                    runAlignment: pw.WrapAlignment.center,
                    children: <pw.Widget>[
                      pw.Text(resumeData.phone),
                      pw.Text(" / "),
                      pw.Text(resumeData.email),
                      if (resumeData.linkedIn != "") ...[
                        pw.Text(" / "),
                        pw.Text(resumeData.github),
                      ],
                    ],
                  ),
                ),
                pw.Divider(
                    height: 60,
                    thickness: 1,
                    color: const PdfColor(0.5, 0.5, 0.5)),
                Heading("Profile"),
                pw.SizedBox(height: 8),
                BodyText(resumeData.summary, ttfLight),
                pw.Divider(
                    height: 60,
                    thickness: 1,
                    color: const PdfColor(0.5, 0.5, 0.5)),
                if (resumeData.experience.isNotEmpty) ...[
                  Heading("Work Experience"),
                  ...resumeData.experience.map((e) {
                    return pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.SizedBox(height: 4),
                          pw.Text(e['title'].toString().toUpperCase(),
                              style:
                                  pw.TextStyle(font: ttfRegular, fontSize: 10)),
                          pw.SizedBox(height: 7),
                          pw.Text(e['company'].toString(),
                              style: pw.TextStyle(
                                  letterSpacing: 2,
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 10)),
                          pw.SizedBox(height: 10),
                          pw.Text('${e['start']} - ${e['end']}'),
                          pw.Padding(
                            padding:
                                const pw.EdgeInsets.symmetric(vertical: 3.0),
                            child: BulletPoint(
                                item: e['description'].toString(),
                                font: ttfLight),
                          ),
                          pw.SizedBox(height: 10)
                        ]);
                  })
                ],
                if (resumeData.education.isNotEmpty ||
                    resumeData.skills.isNotEmpty)
                  pw.Divider(
                      height: 10,
                      thickness: 1,
                      color: const PdfColor(0.5, 0.5, 0.5)),
                pw.SizedBox(height: 10),
                //START OF EDUCATION SECTION
                if (resumeData.education.isNotEmpty) ...[
                  Heading("Education"),
                  ...resumeData.education.map((e) {
                    return pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(e['college'].toString(),
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                          pw.SizedBox(height: 4),
                          BodyText("${e['start']} - ${e['end']}", ttfLight),
                          pw.SizedBox(height: 3),
                          BodyText(e['degree'].toString(), ttfLight),
                        ]);
                  })
                ],
                //END OF STUDY SECTION
                pw.SizedBox(height: 20),

                //SKILLS SECTION START

                if (resumeData.skills.isNotEmpty) ...[
                  pw.SizedBox(height: 6),
                  Heading("skills"),
                  pw.SizedBox(height: 6),
                  ...resumeData.skills.map((e) {
                    return BulletPoint(item: e, font: ttfLight);
                  })
                ]

                //SKILLS SECTION END
              ],
            ),
          ],
        ),
      );
    } else if (resumeId == 2) {
      final ByteData phoneData =
          await rootBundle.load('assets/icons/phone-call.png');
      final ByteData globeData =
          await rootBundle.load('assets/icons/global.png');

      final ByteData emailData =
          await rootBundle.load('assets/icons/email.png');

      final phoneBytes = phoneData.buffer.asUint8List();
      final emailBytes = emailData.buffer.asUint8List();
      final globeBytes = globeData.buffer.asUint8List();

      final phoneIcon = pw.MemoryImage(phoneBytes);
      final emailIcon = pw.MemoryImage(emailBytes);

      final globeIcon = pw.MemoryImage(globeBytes);

      pdf.addPage(
        pw.MultiPage(
          theme: pw.ThemeData(
              defaultTextStyle: pw.TextStyle(
                  font: ttfRegular, fontBold: ttfBold, fontNormal: ttfRegular)),
          build: (pw.Context context) => [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: <pw.Widget>[
                pw.Container(
                  width: 300,
                  padding: const pw.EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
                  decoration:
                      pw.BoxDecoration(color: PdfColor.fromHex("#F1F1ED")),
                  child: pw.Text(resumeData.fullName.toUpperCase(),
                      textScaleFactor: 2,
                      textAlign: pw.TextAlign.start,
                      style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold, letterSpacing: 6)),
                ),
                pw.SizedBox(height: 10),
                pw.Padding(
                  padding: const pw.EdgeInsets.only(left: 20),
                  child: pw.Text(resumeData.jobTitle,
                      textScaleFactor: 1.2,
                      style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold, letterSpacing: 3)),
                ),
                pw.SizedBox(height: 70),
                pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Expanded(
                          child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                            Heading("Contact"),
                            pw.SizedBox(height: 15),
                            pw.Row(
                              children: [
                                pw.Image(phoneIcon, height: 15, width: 15),
                                pw.SizedBox(width: 15),
                                pw.Flexible(
                                  child: pw.Text(
                                    resumeData.phone,
                                  ),
                                )
                              ],
                            ),
                            pw.SizedBox(height: 10),
                            pw.Row(
                              children: [
                                pw.Image(emailIcon, height: 15, width: 15),
                                pw.SizedBox(width: 15),
                                pw.Flexible(
                                  child: pw.Text(
                                    resumeData.email,
                                  ),
                                )
                              ],
                            ),
                            pw.SizedBox(height: 10),
                            if (resumeData.github != "")
                              pw.Row(
                                children: [
                                  pw.Image(globeIcon, height: 15, width: 15),
                                  pw.SizedBox(width: 15),
                                  pw.Flexible(
                                    child: pw.Text(
                                      resumeData.github,
                                    ),
                                  )
                                ],
                              ),
                          ])),
                      //START OF EDUCATION SECTION
                      if (resumeData.education.isNotEmpty) ...[
                        pw.Expanded(
                            child: pw.Padding(
                          padding: const pw.EdgeInsets.only(left: 20),
                          child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                Heading("Education"),
                                pw.SizedBox(height: 10),
                                ...resumeData.education.map((e) {
                                  return pw.Column(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.Text(e['college'].toString(),
                                            style: pw.TextStyle(
                                                fontWeight:
                                                    pw.FontWeight.bold)),
                                        pw.SizedBox(height: 10),
                                        BodyText("${e['start']} - ${e['end']}",
                                            ttfLight),
                                        pw.SizedBox(height: 10),
                                        BodyText(
                                            e['degree'].toString(), ttfLight),
                                      ]);
                                })
                              ]),
                        )),
                      ],
                      //END OF STUDY SECTION
                    ]),
                pw.SizedBox(height: 50),
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Expanded(
                        child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        //SUMMARY
                        Heading("Summary"),
                        pw.SizedBox(height: 12),
                        BodyText(resumeData.summary, ttfLight),
                        //END SUMMARY
                        pw.SizedBox(height: 20),

                        //SKILLS SECTION START

                        if (resumeData.skills.isNotEmpty) ...[
                          pw.SizedBox(height: 6),
                          Heading("skills"),
                          pw.SizedBox(height: 6),
                          ...resumeData.skills.map((e) {
                            return BulletPoint(item: e, font: ttfLight);
                          })
                        ]

                        //SKILLS SECTION END
                      ],
                    )),
                    if (resumeData.experience.isNotEmpty)
                      pw.Expanded(
                          child: pw.Padding(
                              padding: const pw.EdgeInsets.only(left: 20),
                              child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  Heading("Work Experience"),
                                  pw.SizedBox(height: 10),
                                  ...resumeData.experience.map((e) {
                                    return pw.Stack(
                                        fit: pw.StackFit.loose,
                                        overflow: pw.Overflow.visible,
                                        children: [
                                          pw.Container(
                                              padding: const pw.EdgeInsets.only(
                                                  left: 10),
                                              decoration: pw.BoxDecoration(
                                                  border: pw.Border(
                                                      left: pw.BorderSide(
                                                          color:
                                                              PdfColor.fromHex(
                                                                  "#000000"),
                                                          width: 2))),
                                              child: pw.Column(
                                                  crossAxisAlignment: pw
                                                      .CrossAxisAlignment.start,
                                                  children: [
                                                    pw.SizedBox(height: 4),
                                                    pw.Text(
                                                        e['company'].toString(),
                                                        style: pw.TextStyle(
                                                            letterSpacing: 2,
                                                            fontWeight: pw
                                                                .FontWeight
                                                                .bold,
                                                            fontSize: 10)),
                                                    pw.SizedBox(height: 7),
                                                    pw.Text(
                                                        e['title'].toString(),
                                                        style: pw.TextStyle(
                                                            font: ttfRegular,
                                                            fontSize: 10)),
                                                    pw.SizedBox(height: 10),
                                                    pw.Text(
                                                        '${e['start']} - ${e['end']}'),
                                                    pw.Padding(
                                                      padding: const pw
                                                          .EdgeInsets.symmetric(
                                                          vertical: 3.0),
                                                      child: BulletPoint(
                                                          item: e['description']
                                                              .toString(),
                                                          font: ttfLight),
                                                    ),
                                                    pw.SizedBox(height: 10)
                                                  ])),
                                          pw.Positioned(
                                              left: -4,
                                              top: 6,
                                              child: pw.Container(
                                                  width: 8,
                                                  height: 8,
                                                  decoration: pw.BoxDecoration(
                                                      color: PdfColor.fromHex(
                                                          "#000000"),
                                                      shape:
                                                          pw.BoxShape.circle)))
                                        ]);
                                  })
                                ],
                              )))
                  ],
                )
              ],
            ),
          ],
        ),
      );
    } else if (resumeId == 3) {
      final ByteData phoneData =
          await rootBundle.load('assets/icons/phone-call.png');
      final ByteData globeData =
          await rootBundle.load('assets/icons/global.png');

      final ByteData emailData =
          await rootBundle.load('assets/icons/email.png');

      final phoneBytes = phoneData.buffer.asUint8List();
      final emailBytes = emailData.buffer.asUint8List();
      final globeBytes = globeData.buffer.asUint8List();

      final phoneIcon = pw.MemoryImage(phoneBytes);
      final emailIcon = pw.MemoryImage(emailBytes);

      final globeIcon = pw.MemoryImage(globeBytes);

      pdf.addPage(
        pw.MultiPage(
          theme: pw.ThemeData(
              defaultTextStyle: pw.TextStyle(
                  font: ttfRegular, fontBold: ttfBold, fontNormal: ttfRegular)),
          build: (pw.Context context) => [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: <pw.Widget>[
                pw.Text(resumeData.fullName.toUpperCase(),
                    textScaleFactor: 2,
                    textAlign: pw.TextAlign.start,
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, letterSpacing: 6)),
                pw.SizedBox(height: 10),
                pw.Padding(
                  padding: const pw.EdgeInsets.only(left: 0),
                  child: pw.Text(resumeData.jobTitle,
                      textScaleFactor: 1.2,
                      style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold, letterSpacing: 3)),
                ),
                pw.SizedBox(height: 30),
                pw.Divider(color: PdfColor.fromHex("#000000"), thickness: 3),
                pw.SizedBox(height: 10),
                pw.Row(children: [
                  pw.Expanded(
                    flex: 3,
                    child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          //Contact Section START
                          pw.Container(
                            padding: const pw.EdgeInsets.only(
                                left: 10, right: 30, top: 20, bottom: 20),
                            decoration: pw.BoxDecoration(
                                borderRadius: pw.BorderRadius.circular(6),
                                color: PdfColor.fromHex("#F1F1ED")),
                            child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                mainAxisSize: pw.MainAxisSize.min,
                                children: [
                                  Heading("Contact"),
                                  pw.SizedBox(height: 20),
                                  pw.Row(
                                    mainAxisSize: pw.MainAxisSize.min,
                                    children: [
                                      pw.Image(phoneIcon,
                                          height: 15, width: 15),
                                      pw.SizedBox(width: 15),
                                      pw.Flexible(
                                        child: pw.Text(
                                          resumeData.phone,
                                        ),
                                      )
                                    ],
                                  ),
                                  pw.SizedBox(height: 10),
                                  pw.Row(
                                    mainAxisSize: pw.MainAxisSize.min,
                                    children: [
                                      pw.Image(emailIcon,
                                          height: 15, width: 15),
                                      pw.SizedBox(width: 15),
                                      pw.Flexible(
                                        child: pw.Text(
                                          resumeData.email,
                                        ),
                                      )
                                    ],
                                  ),
                                  pw.SizedBox(height: 10),
                                  if (resumeData.github != "")
                                    pw.Row(
                                      mainAxisSize: pw.MainAxisSize.min,
                                      children: [
                                        pw.Image(globeIcon,
                                            height: 15, width: 15),
                                        pw.SizedBox(width: 15),
                                        pw.Flexible(
                                          child: pw.Text(
                                            resumeData.github,
                                          ),
                                        )
                                      ],
                                    ),
                                ]),
                          ),

                          //Contact Section END
                          //SUMMARY
                          pw.SizedBox(height: 30),

                          GreyHeading("Profile"),
                          pw.SizedBox(height: 12),
                          BodyText(resumeData.summary, ttfLight),
                          //END SUMMARY
                          //START OF EDUCATION SECTION
                          if (resumeData.education.isNotEmpty) ...[
                            pw.SizedBox(height: 30),
                            pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  Heading("Education"),
                                  pw.SizedBox(height: 10),
                                  ...resumeData.education.map((e) {
                                    return pw.Column(
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.start,
                                        children: [
                                          pw.Text(e['college'].toString(),
                                              style: pw.TextStyle(
                                                  fontWeight:
                                                      pw.FontWeight.bold)),
                                          pw.SizedBox(height: 10),
                                          BodyText(
                                              "${e['start']} - ${e['end']}",
                                              ttfLight),
                                          pw.SizedBox(height: 10),
                                          BodyText(
                                              e['degree'].toString(), ttfLight),
                                        ]);
                                  })
                                ]),
                          ],
                        ]),
                  ),
                  pw.Expanded(
                      flex: 4,
                      child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.end,
                          children: [
                            //WORK EXP SECTION START
                            if (resumeData.experience.isNotEmpty)
                              pw.Padding(
                                  padding: const pw.EdgeInsets.only(left: 20),
                                  child: pw.Column(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      GreyHeading("Work Experience"),
                                      pw.SizedBox(height: 10),
                                      ...resumeData.experience.map((e) {
                                        return pw.Stack(
                                            fit: pw.StackFit.loose,
                                            overflow: pw.Overflow.visible,
                                            children: [
                                              pw.Container(
                                                  padding:
                                                      const pw.EdgeInsets.only(
                                                          left: 10),
                                                  decoration: pw.BoxDecoration(
                                                      border: pw.Border(
                                                          left: pw.BorderSide(
                                                              color: PdfColor
                                                                  .fromHex(
                                                                      "#000000"),
                                                              width: 2))),
                                                  child: pw.Column(
                                                      crossAxisAlignment: pw
                                                          .CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        pw.SizedBox(height: 4),
                                                        pw.Text(
                                                            e['company']
                                                                .toString(),
                                                            style: pw.TextStyle(
                                                                letterSpacing:
                                                                    2,
                                                                fontWeight: pw
                                                                    .FontWeight
                                                                    .bold,
                                                                fontSize: 10)),
                                                        pw.SizedBox(height: 7),
                                                        pw.Text(
                                                            e['title']
                                                                .toString(),
                                                            style: pw.TextStyle(
                                                                font:
                                                                    ttfRegular,
                                                                fontSize: 10)),
                                                        pw.SizedBox(height: 10),
                                                        pw.Text(
                                                            '${e['start']} - ${e['end']}'),
                                                        pw.Padding(
                                                          padding: const pw
                                                              .EdgeInsets.symmetric(
                                                              vertical: 3.0),
                                                          child: BulletPoint(
                                                              item: e['description']
                                                                  .toString(),
                                                              font: ttfLight),
                                                        ),
                                                        pw.SizedBox(height: 10)
                                                      ])),
                                              pw.Positioned(
                                                  left: -4,
                                                  top: 6,
                                                  child: pw.Container(
                                                      width: 8,
                                                      height: 8,
                                                      decoration:
                                                          pw.BoxDecoration(
                                                              color: PdfColor
                                                                  .fromHex(
                                                                      "#000000"),
                                                              shape: pw.BoxShape
                                                                  .circle)))
                                            ]);
                                      })
                                    ],
                                  ))

                            //WORK EXP SECTION END
                          ]))
                ]),
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Expanded(
                        child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        //SKILLS SECTION START

                        if (resumeData.skills.isNotEmpty) ...[
                          pw.SizedBox(height: 20),
                          GreyHeading("Skills"),
                          pw.SizedBox(height: 6),
                          ...resumeData.skills.map((e) {
                            return BulletPoint(item: e, font: ttfLight);
                          })
                        ]

                        //SKILLS SECTION END
                      ],
                    )),
                  ],
                )
              ],
            ),
          ],
        ),
      );
    } else if (resumeId == 5) {
      // pdf.addPage(
      //   pw.MultiPage(
      //     theme: pw.ThemeData(
      //       defaultTextStyle: pw.TextStyle(
      //         letterSpacing: 0.5,
      //         wordSpacing: 2,
      //         lineSpacing: 5,
      //         font: ttfRegular,
      //         fontBold: ttfBold,
      //         fontNormal: ttfRegular,
      //       ),
      //     ),
      //     build: (pw.Context context) => [
      //       pw.Container(
      //         padding:
      //             const pw.EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      //         child: pw.Column(
      //           crossAxisAlignment: pw.CrossAxisAlignment.start,
      //           children: <pw.Widget>[
      //             pw.Text(
      //               resumeData.fullName.toUpperCase(),
      //               textScaleFactor: 2,
      //               textAlign: pw.TextAlign.left,
      //               style: pw.TextStyle(
      //                 fontWeight: pw.FontWeight.bold,
      //                 letterSpacing: 3,
      //               ),
      //             ),
      //             pw.SizedBox(height: 10),
      //             pw.Text(
      //               resumeData.jobTitle,
      //               textScaleFactor: 1.2,
      //               style: pw.TextStyle(
      //                 fontWeight: pw.FontWeight.bold,
      //                 letterSpacing: 2,
      //               ),
      //             ),
      //             pw.SizedBox(height: 10),
      //             BodyText(resumeData.summary, ttfLight),
      //             pw.Divider(height: 30, thickness: 1, color: PdfColors.grey),
      //             _CustomHeading("Contact Information"),
      //             pw.SizedBox(height: 8),
      //             pw.Text("Phone: ${resumeData.phone}"),
      //             pw.Text("Email: ${resumeData.email}"),
      //             if (resumeData.github != "")
      //               pw.Text("Portfolio: ${resumeData.github}"),
      //             pw.Divider(height: 30, thickness: 1, color: PdfColors.grey),
      //             _CustomHeading("Work Experience"),
      //             pw.SizedBox(height: 8),
      //             for (var experience in resumeData.experience)
      //               pw.Column(
      //                 crossAxisAlignment: pw.CrossAxisAlignment.start,
      //                 children: [
      //                   pw.Text(
      //                     "${experience['title'].toString()} at ${experience['company'].toString()}",
      //                     style: pw.TextStyle(
      //                       fontWeight: pw.FontWeight.bold,
      //                       fontSize: 14,
      //                       color: PdfColors.blue,
      //                     ),
      //                   ),
      //                   pw.Text(
      //                       "${experience['start']} - ${experience['end']}"),
      //                   pw.Text("• ${experience['description']}"),
      //                   pw.SizedBox(height: 10),
      //                 ],
      //               ),
      //             pw.Divider(height: 30, thickness: 1, color: PdfColors.grey),
      //             _CustomHeading("Education"),
      //             pw.SizedBox(height: 8),
      //             for (var education in resumeData.education)
      //               pw.Column(
      //                 crossAxisAlignment: pw.CrossAxisAlignment.start,
      //                 children: [
      //                   pw.Text(
      //                     education.university,
      //                     style: pw.TextStyle(
      //                       fontWeight: pw.FontWeight.bold,
      //                       fontSize: 14,
      //                       color: PdfColors.blue,
      //                     ),
      //                   ),
      //                   pw.Text(
      //                       "${education.startDate} - ${education.endDate}"),
      //                   pw.Text(education.studyCourse),
      //                   pw.SizedBox(height: 10),
      //                 ],
      //               ),
      //             pw.Divider(height: 30, thickness: 1, color: PdfColors.grey),
      //             _CustomHeading("Skills"),
      //             pw.SizedBox(height: 8),
      //             for (var skill in resumeData.skills) pw.Text("• $skill"),
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      // );
    } else if (resumeId == 4) {
      pdf.addPage(
        pw.Page(
            margin: pw.EdgeInsets.zero,
            theme: pw.ThemeData(
              defaultTextStyle: pw.TextStyle(
                font: pw.Font.ttf(
                    await rootBundle.load("assets/font/Manrope-Regular.ttf")),
                color: PdfColors.black,
                fontSize: 12,
              ),
            ),
            build: (pw.Context context) => pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Container(
                          margin: const pw.EdgeInsets.all(8),
                          width: 200,
                          color: PdfColor.fromHex("#323B4C"),
                          child: pw.Padding(
                              padding: const pw.EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 20),
                              child: pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Column(
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.start,
                                        children: [
                                          pw.Text("Contact".toUpperCase(),
                                              style: pw.TextStyle(
                                                  color: PdfColors.white,
                                                  fontWeight:
                                                      pw.FontWeight.bold,
                                                  fontSize: 16,
                                                  letterSpacing: 2)),
                                          pw.Divider(
                                              color:
                                                  PdfColor.fromHex("#ffffff"),
                                              thickness: 3),
                                          pw.SizedBox(height: 15),
                                          pw.Column(
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: [
                                              pw.Text('Phone',
                                                  style: pw.TextStyle(
                                                    fontSize: 13,
                                                    color: PdfColors.white,
                                                    fontWeight:
                                                        pw.FontWeight.bold,
                                                  )),
                                              pw.SizedBox(width: 2),
                                              pw.Text(resumeData.phone,
                                                  style: const pw.TextStyle(
                                                      color: PdfColors.white))
                                            ],
                                          ),
                                          pw.SizedBox(height: 10),
                                          pw.Column(
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: [
                                              pw.Text('Email',
                                                  style: pw.TextStyle(
                                                    fontSize: 13,
                                                    color: PdfColors.white,
                                                    fontWeight:
                                                        pw.FontWeight.bold,
                                                  )),
                                              pw.SizedBox(width: 2),
                                              pw.Text(resumeData.email,
                                                  style: const pw.TextStyle(
                                                      color: PdfColors.white))
                                            ],
                                          ),
                                          pw.SizedBox(height: 10),
                                          pw.Column(
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: [
                                              pw.Text('Your Site',
                                                  style: pw.TextStyle(
                                                    fontSize: 13,
                                                    color: PdfColors.white,
                                                    fontWeight:
                                                        pw.FontWeight.bold,
                                                  )),
                                              pw.SizedBox(width: 2),
                                              if (resumeData.github != "")
                                                pw.Text(resumeData.github,
                                                    style: const pw.TextStyle(
                                                        color: PdfColors.white))
                                            ],
                                          ),
                                        ]),
                                    pw.SizedBox(height: 15),
                                    pw.Text("Education".toUpperCase(),
                                        style: pw.TextStyle(
                                            color: PdfColors.white,
                                            fontWeight: pw.FontWeight.bold,
                                            fontSize: 16,
                                            letterSpacing: 2)),
                                    pw.Divider(
                                        color: PdfColor.fromHex("#ffffff"),
                                        thickness: 3),
                                    pw.SizedBox(height: 15),
                                    ...resumeData.education.map((e) {
                                      return pw.Column(
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Text(e['college'].toString(),
                                                style: pw.TextStyle(
                                                  fontSize: 13,
                                                  color: PdfColors.white,
                                                  fontWeight:
                                                      pw.FontWeight.bold,
                                                )),
                                            pw.SizedBox(height: 10),
                                            pw.Text(
                                                "${e['start']} - ${e['end']}",
                                                style: pw.TextStyle(
                                                    fontSize: 10,
                                                    font: ttfRegular,
                                                    letterSpacing: 0.5,
                                                    color: PdfColors.white,
                                                    wordSpacing: 2,
                                                    lineSpacing: 5)),
                                            pw.SizedBox(height: 10),
                                            pw.Text(e['degree'].toString(),
                                                style: pw.TextStyle(
                                                    fontSize: 10,
                                                    font: ttfRegular,
                                                    color: PdfColors.white,
                                                    letterSpacing: 0.5,
                                                    wordSpacing: 2,
                                                    lineSpacing: 5)),
                                          ]);
                                    }),
                                    pw.SizedBox(height: 15),
                                    pw.Text("Skills".toUpperCase(),
                                        style: pw.TextStyle(
                                            color: PdfColors.white,
                                            fontWeight: pw.FontWeight.bold,
                                            fontSize: 16,
                                            letterSpacing: 2)),
                                    pw.Divider(
                                        color: PdfColor.fromHex("#ffffff"),
                                        thickness: 3),
                                    pw.SizedBox(height: 15),
                                    pw.SizedBox(height: 6),
                                    ...resumeData.skills.map((e) {
                                      return pw.Row(
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.start,
                                        children: [
                                          pw.Padding(
                                            padding: const pw.EdgeInsets.only(
                                                top: 4.0, right: 5.0),
                                            child: pw.Container(
                                              height: 4,
                                              width: 4,
                                              decoration: pw.BoxDecoration(
                                                color:
                                                    PdfColor.fromHex("#ffffff"),
                                                shape: pw.BoxShape.circle,
                                              ),
                                            ),
                                          ),
                                          pw.Expanded(
                                              child: pw.Text(e,
                                                  style: pw.TextStyle(
                                                      fontSize: 10,
                                                      font: ttfRegular,
                                                      color: PdfColors.white,
                                                      letterSpacing: 0.5,
                                                      wordSpacing: 2,
                                                      lineSpacing: 5))),
                                        ],
                                      );
                                    })
                                  ]))),

                      //RIGHT SIDE
                      pw.Flexible(
                          child: pw.Padding(
                              padding: const pw.EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text(resumeData.fullName.toUpperCase(),
                                      textScaleFactor: 2,
                                      textAlign: pw.TextAlign.start,
                                      style: pw.TextStyle(
                                          color: PdfColor.fromHex("#062A6D"),
                                          fontWeight: pw.FontWeight.bold,
                                          letterSpacing: 6)),
                                  pw.SizedBox(height: 10),
                                  pw.Text(resumeData.jobTitle,
                                      textScaleFactor: 1.2,
                                      style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold,
                                          letterSpacing: 3)),
                                  pw.SizedBox(height: 20),
                                  BodyText(resumeData.summary, ttfRegular),
                                  pw.SizedBox(height: 20),
                                  GreyHeading("Work Experience"),
                                  pw.SizedBox(height: 10),
                                  ...resumeData.experience.map((e) {
                                    return pw.Column(
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.start,
                                        children: [
                                          pw.SizedBox(height: 4),
                                          pw.Text(
                                              e['title']
                                                  .toString()
                                                  .toUpperCase(),
                                              style: pw.TextStyle(
                                                  font: ttfRegular,
                                                  fontSize: 10)),
                                          pw.SizedBox(height: 7),
                                          pw.Text(e['company'].toString(),
                                              style: pw.TextStyle(
                                                  letterSpacing: 2,
                                                  fontWeight:
                                                      pw.FontWeight.bold,
                                                  fontSize: 10)),
                                          pw.SizedBox(height: 10),
                                          pw.Text(
                                              '${e['start']} - ${e['end']}'),
                                          pw.Padding(
                                              padding:
                                                  const pw.EdgeInsets.symmetric(
                                                      vertical: 3.0),
                                              child: pw.Row(
                                                  crossAxisAlignment: pw
                                                      .CrossAxisAlignment.start,
                                                  children: [
                                                    pw.Padding(
                                                      padding: const pw
                                                          .EdgeInsets.only(
                                                          top: 4.0, right: 5.0),
                                                      child: pw.Container(
                                                        height: 4,
                                                        width: 4,
                                                        decoration: const pw
                                                            .BoxDecoration(
                                                          color:
                                                              PdfColor.fromInt(
                                                                  0x000000),
                                                          shape: pw
                                                              .BoxShape.circle,
                                                        ),
                                                      ),
                                                    ),
                                                    pw.Flexible(
                                                      child: BodyText(
                                                          e['description']
                                                              .toString(),
                                                          ttfRegular),
                                                    )
                                                  ])),
                                          pw.SizedBox(height: 10)
                                        ]);
                                  })
                                ],
                              )))
                    ])),
      );
    }

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/resume.pdf");
    await file.writeAsBytes(await pdf.save());
    OpenFilex.open(file.path);
  }
}

// Future<void> generateResume(ResumeDataProvider resumeData) async {
//   final pdf = pw.Document();

//   // Load custom fonts
//   final robotoRegular = pw.Font.ttf(
//       await rootBundle.load("assets/fonts/gilroy/Gilroy-Regular.ttf"));
//   final robotoBold =
//       pw.Font.ttf(await rootBundle.load("assets/fonts/gilroy/Gilroy-Bold.ttf"));
//   final notoEmoji = pw.Font.ttf(
//       await rootBundle.load("assets/fonts/notoemoji/NotoEmoji-Regular.ttf"));

//   // pdf.addPage(
//   //   pw.MultiPage(
//   //     pageFormat: PdfPageFormat.a4,
//   //     build: (pw.Context context) => [
//   //       // Header Section
//   //       pw.Column(
//   //         crossAxisAlignment: pw.CrossAxisAlignment.start,
//   //         children: [
//   //           pw.Text(
//   //               resumeData.fullName.isNotEmpty
//   //                   ? resumeData.fullName
//   //                   : "First Last",
//   //               style: pw.TextStyle(font: robotoBold, fontSize: 22)),
//   //           pw.SizedBox(height: 5),
//   //           pw.Text(
//   //               resumeData.jobTitle.isNotEmpty
//   //                   ? resumeData.jobTitle
//   //                   : "Job Title",
//   //               style: pw.TextStyle(font: robotoRegular, fontSize: 14)),
//   //           pw.SizedBox(height: 10),
//   //           pw.Row(
//   //             mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//   //             children: [
//   //               _contactRow("📞", resumeData.phone, notoEmoji),
//   //               _contactRow("✉", resumeData.email, notoEmoji),
//   //               _contactRow("🔗", resumeData.linkedIn, notoEmoji),
//   //               _contactRow("🐱", resumeData.github, notoEmoji),
//   //             ],
//   //           ),
//   //           pw.Divider(thickness: 1),
//   //         ],
//   //       ),

//   //       // Education Section
//   //       _sectionTitle("Education", robotoBold),
//   //       for (var edu in resumeData.education) _educationRow(edu, robotoRegular),

//   //       // Experience Section
//   //       _sectionTitle("Experience", robotoBold),
//   //       for (var exp in resumeData.experience)
//   //         _experienceRow(exp, robotoRegular),

//   //       // Technical Skills
//   //       _sectionTitle("Technical Skills", robotoBold),
//   //       _bulletList(resumeData.skills, robotoRegular),

//   //       // Relevant Coursework
//   //       _sectionTitle("Relevant Coursework", robotoBold),
//   //       _bulletList(resumeData.courses, robotoRegular),
//   //     ],
//   //   ),
//   // );

//   // Save PDF
//   final output = await getTemporaryDirectory();
//   final file = File("${output.path}/resume.pdf");
//   await file.writeAsBytes(await pdf.save());
// }

// Helper Widgets

class BulletPoint extends pw.StatelessWidget {
  final String item;
  pw.Font font;

  BulletPoint({required this.item, required this.font});

  @override
  pw.Widget build(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.only(top: 4.0, right: 5.0),
          child: pw.Container(
            height: 4,
            width: 4,
            decoration: const pw.BoxDecoration(
              color: PdfColor.fromInt(0x000000),
              shape: pw.BoxShape.circle,
            ),
          ),
        ),
        pw.Expanded(
          child: BodyText(item, font),
        ),
      ],
    );
  }
}

class Heading extends pw.StatelessWidget {
  String title;

  Heading(this.title);
  @override
  pw.Widget build(pw.Context context) {
    return pw.Text(title.toUpperCase(),
        style: pw.TextStyle(
            fontWeight: pw.FontWeight.bold, fontSize: 13, letterSpacing: 3));
  }
}

class BodyText extends pw.StatelessWidget {
  String text;
  pw.Font font;
  BodyText(this.text, this.font);
  @override
  pw.Widget build(pw.Context context) {
    return pw.Text(text,
        style: pw.TextStyle(
            fontSize: 10,
            font: font,
            letterSpacing: 0.5,
            wordSpacing: 2,
            lineSpacing: 5));
  }
}

class GreyHeading extends pw.StatelessWidget {
  String title;

  GreyHeading(this.title);
  @override
  pw.Widget build(pw.Context context) {
    return pw.Container(
        padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: pw.BoxDecoration(
            borderRadius: pw.BorderRadius.circular(6),
            color: PdfColor.fromHex("#F1F1ED")),
        child: pw.Text(title.toUpperCase(),
            style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                fontSize: 13,
                letterSpacing: 3)));
  }
}

// pw.Widget _contactRow(String icon, String text, pw.Font font) {
//   return pw.Row(
//     children: [
//       pw.Text(icon, style: pw.TextStyle(font: font, fontSize: 14)),
//       pw.SizedBox(width: 5),
//       pw.Text(text.isNotEmpty ? text : "N/A",
//           style: pw.TextStyle(fontSize: 12)),
//     ],
//   );
// }

// pw.Widget _sectionTitle(String title, pw.Font font) {
//   return pw.Padding(
//     padding: const pw.EdgeInsets.only(top: 10, bottom: 5),
//     child: pw.Text(title, style: pw.TextStyle(font: font, fontSize: 16)),
//   );
// }

// pw.Widget _educationRow(Map<String, String> edu, pw.Font font) {
//   return pw.Padding(
//     padding: const pw.EdgeInsets.only(bottom: 5),
//     child: pw.Column(
//       crossAxisAlignment: pw.CrossAxisAlignment.start,
//       children: [
//         pw.Text("${edu['degree']} - ${edu['college']}",
//             style: pw.TextStyle(font: font, fontSize: 14)),
//         pw.Text("${edu['start']} - ${edu['end']}",
//             style: pw.TextStyle(fontSize: 12, color: PdfColors.grey600)),
//         if (edu['description']!.isNotEmpty)
//           pw.Text(edu['description']!, style: pw.TextStyle(fontSize: 12)),
//       ],
//     ),
//   );
// }

// pw.Widget _experienceRow(Map<String, String> exp, pw.Font font) {
//   return pw.Padding(
//     padding: const pw.EdgeInsets.only(bottom: 5),
//     child: pw.Column(
//       crossAxisAlignment: pw.CrossAxisAlignment.start,
//       children: [
//         pw.Text("${exp['title']} - ${exp['company']}, ${exp['city']}",
//             style: pw.TextStyle(font: font, fontSize: 14)),
//         pw.Text("${exp['start']} - ${exp['end']}",
//             style: pw.TextStyle(fontSize: 12, color: PdfColors.grey600)),
//         if (exp['description']!.isNotEmpty)
//           pw.Text(exp['description']!, style: pw.TextStyle(fontSize: 12)),
//       ],
//     ),
//   );
// }

// pw.Widget _bulletList(List<String> items, pw.Font font) {
//   return pw.Column(
//     crossAxisAlignment: pw.CrossAxisAlignment.start,
//     children: items
//         .map((item) => pw.Row(
//               children: [
//                 pw.Text("• ", style: pw.TextStyle(font: font, fontSize: 12)),
//                 pw.Text(item, style: pw.TextStyle(fontSize: 12)),
//               ],
//             ))
//         .toList(),
//   );
// }
