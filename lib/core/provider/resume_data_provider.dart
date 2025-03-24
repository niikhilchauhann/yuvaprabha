
import 'package:flutter/material.dart';

class ResumeDataProvider extends ChangeNotifier {
  String fullName = '';
  String jobTitle = '';
  String email = '';
  String phone = '';
  String address = '';
  String summary = '';

  String dob = '';
  String nationality = '';
  String linkedIn = '';
  String github = '';
  String dribbble = '';
  String behance = '';
  String other = '';

  List<Map<String, String>> education = [];
  List<Map<String, String>> experience = [];
  List<String> skills = [];
  List<String> courses = [];

  void updateBasicInfo(String name, String title, String email, String phone, String address) {
    fullName = name;
    jobTitle = title;
    this.email = email;
    this.phone = phone;
    this.address = address;
    notifyListeners();
  }

  void updatePersonalDetails(String dob, String nationality, String linkedIn, String github, String dribbble, String behance, String other) {
    this.dob = dob;
    this.nationality = nationality;
    this.linkedIn = linkedIn;
    this.github = github;
    this.dribbble = dribbble;
    this.behance = behance;
    this.other = other;
    notifyListeners();
  }

  void addEducation(String degree, String college,  String start, String end, String description) {
    education.add({
      'degree': degree,
      'college': college,
      'start': start,
      'end': end,
      'description': description,
    });
    notifyListeners();
  }

  void addExperience(String title, String company, String city, String start, String end, String description) {
    experience.add({
      'title': title,
      'company': company,
      'city': city,
      'start': start,
      'end': end,
      'description': description,
    });
    notifyListeners();
  }

  void updateSkills(String skillsList) {
    skills = skillsList.split(',').map((e) => e.trim()).toList();
    notifyListeners();
  }
   void updateCoursework(String courseworkList) {
    courses = courseworkList.split(',').map((e) => e.trim()).toList();
    notifyListeners();
  }
}