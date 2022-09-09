import 'package:flutter/material.dart';

// Search Page
class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // const SearchPage({Key? key}) : super(key: key);

  final searchTextFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchTextFieldController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    searchTextFieldController.dispose();
    super.dispose();
  }

  void _printLatestValue() {
    print("Second text field: ${searchTextFieldController.text}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // The search area here
          title: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: TextField(
            controller: searchTextFieldController,
            textInputAction: TextInputAction.go,
            onSubmitted: (value) {
              print("asdasd : " + searchTextFieldController.text);
            },
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    /* Clear the search field */
                    searchTextFieldController.clear();
                  },
                ),
                hintText: 'Search...',
                border: InputBorder.none),
          ),
        ),
      )),
    );
  }
}

class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  String selectedResult = "";

  @override
  Widget buildResults(BuildContext context) {
    (element) => element.contains(query);
    String ss = query;
    print(ss);
    return Container(
      child: Center(
        child: Text(ss),
      ),
    );
  }

  final List<String> listExample;
  Search(this.listExample);

  List<String> recentList = ["Text 4", "Text 3"];

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList = [];
    query.isEmpty
        ? suggestionList = recentList //In the true case
        : suggestionList.addAll(listExample.where(
            // In the false case
            (element) => element.contains(query),
          ));

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            suggestionList[index],
          ),
          leading: query.isEmpty ? Icon(Icons.access_time) : SizedBox(),
          onTap: () {
            selectedResult = suggestionList[index];
            showResults(context);
          },
        );
      },
    );
  }
}
