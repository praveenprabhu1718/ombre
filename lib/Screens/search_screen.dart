import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ombre/Constants/constants.dart';
import 'package:ombre/Model/event.dart';
import 'package:ombre/Services/fetch_events.dart';
import 'package:shimmer/shimmer.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _hintText = 'Search for events, artists, or fans';
  String query = '';
  TextEditingController textEditingController;
  FetchEvents fetchEvents = FetchEvents();
  List<Event> events;

  @override
  void initState() {
    super.initState();

    fetching();
  }

  fetching() async {
    await Firebase.initializeApp();
    fetchEvents.fetechEvents().then((List<Event> list) {
      setState(() {
        events = list;
      });
    });
  }

  buildSuggestion(String query) {
    final List<Event> suggestionList = query.isEmpty
        ? []
        : events.where((Event event) {
            String eventName = event.name.toLowerCase();
            String _query = query.toLowerCase();
            bool matchEvent = eventName.contains(_query);
            return matchEvent;
          }).toList();
    return query.isEmpty
        ? Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.35),
            child: Center(
              child: Text(
                'Start typing to find awesome content',
                style: GoogleFonts.nunitoSans(
                    fontWeight: FontWeight.bold, fontSize: 10),
              ),
            ))
        : ListView.builder(
            shrinkWrap: true,
            itemCount: suggestionList.length,
            itemBuilder: (context, index) {
              Event searchedEvent = Event(
                  name: suggestionList[index].name,
                  categories: suggestionList[index].categories,
                  imageUrl: suggestionList[index].imageUrl);
              int _length = searchedEvent.categories.length;
              String _categories = '';
              if (_length == 1) {
                _categories = searchedEvent.categories[0];
              } else if (_length == 2) {
                _categories = searchedEvent.categories[0] +
                    ' | ' +
                    searchedEvent.categories[1];
              } else if (_length == 3) {
                _categories = searchedEvent.categories[0] +
                    ' | ' +
                    searchedEvent.categories[1] +
                    ' | ' +
                    searchedEvent.categories[2];
              }
              return Padding(
                padding: EdgeInsets.fromLTRB(40, 4, 20, 20),
                child: Container(
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Image.network(searchedEvent.imageUrl,
                            width: 75, height: 55, fit: BoxFit.fill,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Shimmer.fromColors(
                              baseColor: Colors.white12,
                              highlightColor: Colors.grey[700],
                              child: Container(
                                color: Colors.black87,
                                height: 55,
                                width: 75,
                              ));
                        }),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Text(
                              _categories,
                              maxLines: 1,
                              style: GoogleFonts.nunitoSans(
                                  color: selectedIconBgColor, fontSize: 14),
                            ),
                          ),
                          Text(
                            searchedEvent.name,
                            style: GoogleFonts.nunitoSans(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(15),
            child: Container(
              height: 45,
              child: Row(
                children: [
                  Expanded(
                      flex: 15,
                      child: TextField(
                        controller: textEditingController,
                        onChanged: (value) {
                          setState(() {
                            query = value;
                          });
                        },
                        cursorColor: selectedIconBgColor,
                        decoration: InputDecoration(
                            hintStyle: GoogleFonts.nunitoSans(fontSize: 14),
                            hintText: _hintText,
                            hintMaxLines: 1,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            filled: true,
                            contentPadding: EdgeInsets.all(16),
                            fillColor: searchBgColor),
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: searchBgColor),
                      child: Center(
                        child: IconButton(
                          icon: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          onPressed: null,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          buildSuggestion(query)
        ],
      ),
    );
  }
}

// Container(
//                           height: 55,
//                           width: 75,
//                           decoration: BoxDecoration(
//                               image: DecorationImage(
//                                   image: NetworkImage(
//                                     searchedEvent.imageUrl,
//                                   ),
//                                   fit: BoxFit.fill)),
//                         )
