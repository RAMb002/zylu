import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zylu/model/employee_data.dart';

class FirebaseApi {

  static setEmployeeData(EmployeeData employeeData) async {
    var path = FirebaseFirestore.instance.collection('employeeData').doc();
    await path.set(employeeData.toJson());
  }

  static Stream getEmployeeData() {
    return FirebaseFirestore.instance
        .collection('employeeData')
        .orderBy("timeStamp",descending: false)
        .snapshots();
  }

  static EmployeeData fromJson(var data){
    return EmployeeData(
        name: data['name'],
        gender: data['gender'],
        workingYears:  data['yearOfExperience'],
        active: data['active'],
        image:  data['image'],
        salary: data['salary']);

  }
  
  static void updateEmployeeName(String id,String name)async{
    await FirebaseFirestore.instance.collection('employeeData').doc(id).update({
      'name' : name
    });
    
  }

  static void updateEmployeeSalary(String id,int salary)async{
    await FirebaseFirestore.instance.collection('employeeData').doc(id).update({
      'salary' : salary
    });

  }
  static void updateEmployeeWorkYear(String id,int year)async{
    await FirebaseFirestore.instance.collection('employeeData').doc(id).update({
      'yearOfExperience' : year
    });

  }
  static void updateEmployeeGender(String id,bool? gender)async{
    await FirebaseFirestore.instance.collection('employeeData').doc(id).update({
      'gender' : gender
    });

  }
  static void updateEmployeeActive(String id,bool? active)async{
    await FirebaseFirestore.instance.collection('employeeData').doc(id).update({
      'active' : active
    });

  }
  static void updateEmployeeImage(String id,String image)async{
    await FirebaseFirestore.instance.collection('employeeData').doc(id).update({
      'image' : image
    });

  }
}