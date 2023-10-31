import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewsPage extends StatefulWidget {
  NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  TextEditingController searchInputController = TextEditingController();
  List<dynamic> NewsHeadlines = [
    {
      "author": "barrons.com",
      "title":
          "Stock in Tesla and Rivian Is Dropping. This Company Spooked Investors",
      "description":
          "Stock in Tesla, and other auto makers, was dropping early Monday. A disappointing forecast from the automotive chip maker ON Semiconductor appears to be the proximate cause.#tesla #onsemiconductor",
      "url": "https://biztoc.com/x/655524ffeab3fdba",
      "urlToImage": "https://c.biztoc.com/p/655524ffeab3fdba/s.webp",
      "publishedAt": "2023-10-30T16:52:08Z",
      "content":
          "Stock in Tesla, and other auto makers, was dropping early Monday. A disappointing forecast from the automotive chip maker ON Semiconductor appears to be the proximate cause.\r\n#tesla#onsemiconductor\r\n… [+36 chars]"
    }
  ];

  Future getUpdate(String news) async {
    http.Response response = await http.get(Uri.parse(
        'https://newsapi.org/v2/everything?q=tesla&from=2023-09-30&sortBy=publishedAt&apiKey=a6133ef667e941378c6b29ae4ca19e74'));
    setState(() {
      NewsHeadlines = jsonDecode(response.body) as List<dynamic>;
    });

    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            "Today's Headline",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
            child: Center(
                child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchInputController,
              decoration: InputDecoration(
                  hintText: 'Search',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
          SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  getUpdate(searchInputController.text);
                },
                child: SizedBox(
                  height: 600,
                  child: ListView.builder(
                      itemCount: NewsHeadlines.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title:
                              Image.network(NewsHeadlines[index]['urlToImage']),
                          subtitle: Text(NewsHeadlines[index]['description']),
                        );
                      }),
                ),
              )),
          SizedBox(
              width: 300,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.black),
                      minimumSize: MaterialStatePropertyAll(Size(290, 40))),
                  onPressed: () {
                    getUpdate(searchInputController.text);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.web_rounded),
                      Text('Get News'),
                    ],
                  ))),
        ]))),
      ),
    );
  }
}
