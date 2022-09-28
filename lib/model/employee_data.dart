class EmployeeData{
   String name;
   bool? gender;
   int workingYears;
   bool? active;
   String image;
   int salary;

  EmployeeData({
    required this.name,
    required this.gender,
    required this.workingYears,
    required this.active,
    required this.image,
    required this.salary
});

  Map<String, dynamic> toJson() {
    return ({
      'name' : name,
      'gender' : gender,
      'yearOfExperience' : workingYears,
      'active' : active,
      'image' : image,
      'salary' : salary,
      'timeStamp': DateTime.now(),
    });
  }


}