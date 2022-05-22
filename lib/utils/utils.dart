import 'package:aluno_mobile_flutter/enums/enums.dart';
import 'package:flutter/material.dart';

class Utils {
  static IconData activeInactiveIcon(bool isActive) {
    return isActive ? Icons.blur_off : Icons.blur_on;
  }

  static String activeInactiveLabel(bool isActive) {
    return isActive ? 'Inativar' : 'Ativar';
  }

  static Color activeInactiveColor(bool isActive) {
    return isActive ? Colors.red : Colors.green;
  }

  static Future<DateTime?> datePicker(BuildContext context) {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(3000),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).primaryColor, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.grey.shade700, // body text color
            ),
          ),
          child: child!,
        );
      }
    );
  }

  static AcademicDegree? academicDegreeByInt(int value) {
    switch (value) {
      case 1:
        return AcademicDegree.bachelor;
      case 2:
        return AcademicDegree.technological;
      case 3:
        return AcademicDegree.graduation;
      case 4:
        return AcademicDegree.specialization;
      case 5:
        return AcademicDegree.master;
      case 6:
        return AcademicDegree.doctorate;
      default:
        return null;
    }
  }

  static AcademicRegime? academicRegimeByInt(int value) {
    switch (value) {
      case 1:
        return AcademicRegime.semiannual;
      case 2:
        return AcademicRegime.yearly;
      default:
        return null;
    }
  }

  static AcademicYear? academicYearByInt(int value) {
    switch (value) {
      case 1:
        return AcademicYear.first;
      case 2:
        return AcademicYear.second;
      case 3:
        return AcademicYear.third;
      case 4:
        return AcademicYear.fourth;
      case 5:
        return AcademicYear.fifth;
      default:
        return null;
    }
  }

  static Bimester? bimesterByInt(int value) {
    switch (value) {
      case 1:
        return Bimester.first;
      case 2:
        return Bimester.second;
      case 3:
        return Bimester.third;
      case 4:
        return Bimester.fourth;
      default:
        return null;
    }
  }

  static SemesterPeriod? semesterPeriodByInt(int value) {
    switch (value) {
      case 1:
        return SemesterPeriod.first;
      case 2:
        return SemesterPeriod.second;
      default:
        return null;
    }
  }

  static UserType? userTypeByInt(int value) {
    switch (value) {
      case 1:
        return UserType.student;
      case 2:
        return UserType.teacher;
      case 3:
        return UserType.admin;
      default:
        return null;
    }
  }
}
