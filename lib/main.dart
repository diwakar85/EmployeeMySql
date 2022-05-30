import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqlemplyee/screnns/insterRecord.dart';
import 'helperClass/db_helper.dart';
import 'modelClass/employeeModel.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home:DashBord(),
    )
  );
}
class DashBord extends StatefulWidget {
  const DashBord({Key? key}) : super(key: key);

  @override
  State<DashBord> createState() => _DashBordState();
}

class _DashBordState extends State<DashBord> {
  late Future<List> fetchdata;

  @override
  void initState() {
    super.initState();
    createDB();
    fetchAllData();
  }
  createDB() async {
    DBHelper.dbHelper.initDB();
    print("table create");
  }
  fetchAllData() async {
    fetchdata = DBHelper.dbHelper.fetchAllData();
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Employee Record"),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: fetchdata,
          builder: (context, snapshot){
            if(snapshot.hasError){
              return Center(
                child: Text("${snapshot.error}"),
              );
            }
            else if(snapshot.hasData){
              List<Employee> data=snapshot.data as List<Employee>;
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context,index){
                    Employee empData=data[index];
                    return Padding(
                      padding: const EdgeInsets.only(left:70),
                      child: ListTile(
                        leading: const Text(""),
                        title: Column(
                          children: [
                            Row(
                              children: [
                                Text("${empData.name}",style:const TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                              ],
                            ),
                            Row(
                              children: [
                                Text("${empData.lastName}",style:const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                              ],
                            ),
                            Row(
                              children: [
                                Text("${empData.companyName}",style:const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                              ],
                            ),
                            Row(
                              children: [
                                Text("${empData.designation}",style:const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                              ],
                            ),
                            const  SizedBox(height: 30,),
                            Row(
                              children: [
                                const Image(image: NetworkImage("https://upload.wikimedia.org/wikipedia/commons/thumb/4/4f/Twitter-logo.svg/584px-Twitter-logo.svg.png"),height: 60,width: 60,),
                                const SizedBox(width: 10,),
                                Text("${empData.twitterId}",style:const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                              ],
                            ),
                            Row(
                              children: [
                                const  Image(image: NetworkImage("https://image.shutterstock.com/image-photo/kiev-ukraine-march-8-2015whatsapp-260nw-271338881.jpg"),height: 60,width: 60,),
                                const SizedBox(width: 10,),
                                Text("${empData.whatsAppNumber}",style:const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }
              );
            }
            return const Center(child:CircularProgressIndicator(),);
          }
      ),
      floatingActionButton: FloatingActionButton(
        child:const Icon(Icons.add),
        onPressed: (){
          Get.to(const InsertData());
        },
      ),
    );
  }
}


