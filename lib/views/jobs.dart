import 'package:flutter/material.dart';
import 'package:hackon/services/database.dart';
import 'package:hackon/widgets/widget.dart';

class JobsPage extends StatefulWidget {
  @override
  _JobsPageState createState() => _JobsPageState();
}

class _JobsPageState extends State<JobsPage> {
  @override

  DataBaseMethods dataBaseMethods = new DataBaseMethods();
  Stream allJobsStream;


  Widget getAllJobs() {
    return StreamBuilder(
        stream: allJobsStream,
        builder: (context, snapshot) {
          return (snapshot.hasData)
              ? ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                return SingleChildScrollView(
                  child: Container(padding: EdgeInsets.all(24),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        JobTile(
                            snapshot.data.documents[index].data["Venue"],
                            snapshot.data.documents[index].data["Description"],
                            snapshot.data.documents[index].data["NameOfOrg"],
                            snapshot.data.documents[index].data["Poc"],
                            snapshot.data.documents[index].data["Skills"],
                            snapshot.data.documents[index].data["Time"]),
                      ],
                    ),
                  ),
                );
              })
              : Container();
        });
  }
  getJobs() async {
    dataBaseMethods.getAllJobs().then((value) {
      allJobsStream = value;
    });
  }
  void initState() {
    getJobs();
    setState(() {});
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Jobs", style: simpleTextStyle(),),),
        body: getAllJobs(),
      );

  }

}

class JobTile extends StatelessWidget {
  final String venue;
  final String Description;
  final String NameOfOrg;
  final String Poc;
  final String Skills;
  final  Time;

  JobTile(this.venue, this.Description,this.NameOfOrg, this.Poc, this.Skills, this.Time );
  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.grey,
      ),
      padding: EdgeInsets.all(24),
      child: Column(
        children: [
          Text(Description, style: simpleTextStyle(),),
          SizedBox(height: 10,),
          Text(NameOfOrg, style: simpleTextStyle(),),
          SizedBox(height: 10,),
          Text(Poc, style: simpleTextStyle(),),
          SizedBox(height: 10,),
          Text(Skills, style: simpleTextStyle(),),
          SizedBox(height: 10,),
          Text(Time.toString(), style: simpleTextStyle(),),
          SizedBox(height: 10,),
          Text(venue, style: simpleTextStyle(),),
          SizedBox(height: 10,),
        ],
      )
    );
  }
}



