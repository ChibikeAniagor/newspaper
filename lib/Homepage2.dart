import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewsWidget extends StatefulWidget {
  const NewsWidget({super.key});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  TextEditingController searchInputController = TextEditingController();
  List<dynamic> updateList = [
    {
      "author": "Hugo Engström",
      "title": "Samsung visar upp Galaxy Z Flip 5 Retro",
      "description":
          "Inspirerad av gamla telefonen Samsung E700\n\n\n\n\n\n\n\n\n\n\n\n\nSamsung hyllar sin historia inom vikbara telefoner genom att släppa en begränsad upplaga av Galaxy Z Flip5 Retro, som är inspirerad av Samsung E700, som släpptes för 20 år sedan. Flip5 Retro har samma ind…",
      "url":
          "https://feber.se/mobil/samsung-visar-upp-galaxy-z-flip-5-retro/457618/",
      "urlToImage":
          "https://static.feber.se/article_images/57/46/80/574680.jpg",
      "publishedAt": "2023-10-30T08:40:00Z",
      "content":
          "+\r\nLäs artiklar före alla andra\r\nKommentera före alla andra\r\nVälj periodJu längre period, desto bättre pris. Du bestämmer! \r\nMånad\r\n39 kr/mån\r\nKvartal\r\n33 kr/mån\r\nÅr\r\n25 kr/mån\r\nVälj hur du vill beta… [+14297 chars]"
    },
  ];

  Future getUpdate(String country) async {
    http.Response response = await http.get(Uri.parse(
        'https://newsapi.org/v2/everything?q=tesla&from=2023-09-30&sortBy=publishedAt&apiKey=a6133ef667e941378c6b29ae4ca19e74'));
    setState(() {
      updateList = jsonDecode(response.body) as List<dynamic>;
    });

    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'News Network',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchInputController,
                decoration: InputDecoration(
                    hintText: 'search',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
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
                        Icon(Icons.newspaper),
                        Text('Update'),
                      ],
                    ))),
            SizedBox(
              height: 800,
              child: ListView.builder(
                  itemCount: updateList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Image.network(updateList[index]['urlToImage']),
                      subtitle: Text(updateList[index]['description']),
                    );
                  }),
            )
          ]),
        ),
      ),
    );
  }
}
