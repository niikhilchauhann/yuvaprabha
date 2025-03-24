import '../../../core/provider/resume_data_provider.dart';

ResumeDataProvider dummyData = ResumeDataProvider()
    ..updateBasicInfo(
      'John Doe',
      'Software Engineer',
      'johndoe@example.com',
      '+1 234 567 890',
      '1234 Elm Street, New York, USA',
    )
    ..updatePersonalDetails(
      '01-01-1995',
      'American',
      'linkedin.com/in/johndoe',
      'github.com/johndoe',
      'dribbble.com/johndoe',
      'behance.net/johndoe',
      'johndoe.com',
    )
    ..addEducation(
      'Bachelor of Science in Computer Science',
      'MIT',
      '2015',
      '2019',
      'Specialized in AI and Machine Learning.',
    )
    ..addEducation(
      'Master of Science in Data Science',
      'Stanford University',
      '2019',
      '2021',
      'Thesis on deep learning techniques in NLP.',
    )
    ..addExperience(
      'Software Engineer',
      'Google',
      'Mountain View, CA',
      '2021',
      'Present',
      'Developed and optimized search algorithms.',
    )
    ..addExperience(
      'Intern',
      'Facebook',
      'Menlo Park, CA',
      '2020',
      '2021',
      'Worked on the recommendation system for news feed.',
    )
    ..updateSkills(
      'Flutter, Dart, Python, Java, AI, Machine Learning, SQL, Firebase',
    )
    ..updateCoursework(
      'Data Structures, Algorithms, Machine Learning, Cloud Computing',
    );
