import 'dart:ui';

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
                      child: Container(
                        padding: EdgeInsets.all(24),
                        child: Column(
                          children: [
                            JobTile(
                                snapshot.data.documents[index].data["Venue"],
                                snapshot
                                    .data.documents[index].data["Description"],
                                snapshot
                                    .data.documents[index].data["NameOfOrg"],
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
      appBar: AppBar(
        backgroundColor: Colors.black54,
        toolbarHeight: 70,
        title: Text(
          "Jobs & Opportunities",
          style: TextStyle(color: Colors.white, fontSize: 20,fontFamily: 'Pacifico'),
        ),
      ),
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/Images/borderFlower.jpeg"), fit: BoxFit.cover),
          ),
          child: getAllJobs()),
    );
  }
}

class JobTile extends StatelessWidget {
  final String venue;
  final String Description;
  final String NameOfOrg;
  final String Poc;
  final String Skills;
  final Time;

  JobTile(this.venue, this.Description, this.NameOfOrg, this.Poc, this.Skills,
      this.Time);
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.pink.shade50,
        ),
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
              //filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              Description,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.amberAccent.shade50,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              NameOfOrg,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 17),
            ),
            SizedBox(
              height: 20,
            ),
            //Text("--------------------------"),
            Row(
              children: [
                Icon(
                  Icons.email,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  Poc,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 17),
                ),
              ],
            ),
            //SizedBox(height: 10,),
            //Text(Skills, style: simpleTextStyle(),),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(
                  Icons.event,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  Time,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 17),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  venue,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 17),
                ),
              ],
            ),
          ],
        ));
  }
}
