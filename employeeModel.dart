class Employee{
  String? image;
  String? name;
  String? lastName;
  String? designation;
  String? companyName;
  String? twitterId;
  String? whatsAppNumber;

  Employee({this.image,this.name,this.lastName,this.designation,this.companyName,this.twitterId,this.whatsAppNumber});

  factory Employee.formSql(Map<String,dynamic>json){
    return Employee(
      image: json['image'],
      name: json['name'],
      lastName: json['lastName'],
      designation: json['designation'],
      companyName: json['companyName'],
      twitterId: json['twitterId'],
      whatsAppNumber: json['whatsAppNumber']
    );
  }
}