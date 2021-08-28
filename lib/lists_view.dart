import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class lists_view extends StatefulWidget {
  const lists_view({Key? key}) : super(key: key);

  @override
  _lists_viewState createState() => _lists_viewState();
}

class _lists_viewState extends State<lists_view> {
  List users = [];
  bool isLoading = false;

  void initState() {
    super.initState();
    this.fetchUser();
  }

  fetchUser() async {
    setState(() {
      isLoading = true;
    });

    var Url =
        "https://run.mocky.io/v3/d53400a3-6126-495e-9d16-0b4414b537b3/?clients=3";
    var response = await http.get(Uri.parse(Url));
    print(response.statusCode);
    if (response.statusCode == 200) {
      var items = json.decode(response.body)['clients'];
      setState(() {
        users = items;
        isLoading = false;
      });
    } else {
      setState(() {
        users = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('ListExample'),
      ),
      body: list_body(),
    );
  }

  Widget list_body() {
    if (users.contains(null) || users.length < 0 || isLoading) {
      return CircularProgressIndicator();
    }
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return card(users[index]);
        });
  }

  Widget card(item) {
    var name = item["name"];
    var company_name = item["company"];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(
          title: Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name.toString(),
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    company_name.toString(),
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
