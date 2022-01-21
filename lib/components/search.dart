import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../config/globals.dart' as globals;

class Search extends StatefulWidget {
  bool isSearch;
  var appbarSize;
  Search({required this.isSearch, required this.appbarSize, Key? key})
      : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  searchProducts(String value) async {
    // try {
    //   var response = await connect.get('search-prod?q=$value');
    //   orderScreenState!.setState(() {});
    //   globals.isServerConnection = true;
    //   if (response.statusCode == 200) {
    //     return json.decode(response.body);
    //   }
    // } catch (e) {
    //   print(e);
    // }
  }

  @override
  Widget build(BuildContext context) {
    var dHeight = MediaQuery.of(context).size.height;
    var dWidth = MediaQuery.of(context).size.width;
    return Positioned(
      top: 0,
      child: Container(
        color: Colors.white,
        width: dWidth - 40,
        height: dHeight - widget.appbarSize - 150,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: globals.mainColor,
                  ),
                  borderRadius: BorderRadius.circular(8)),
              child: TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                  // onSubmitted: (value) {
                  //   Navigator.pop(context, false);
                  // },
                  // controller: searchAddressController,

                  autofocus: true,
                  decoration: InputDecoration.collapsed(
                    hintText: "",
                    // hintStyle: Theme.of(context)
                    //     .textTheme
                    //     .display1
                    //     .copyWith(fontSize: 18),
                  ),
                ),

                suggestionsCallback: (pattern) async {
                  if (pattern.length >= 3) {
                    return await searchProducts(pattern);
                  } else
                    return {};
                },

                hideOnEmpty: true,
                // suggestionsBoxController:
                //     suggestionsBoxController,
                itemBuilder: (context, suggestion) {
                  return Column(
                    children: [
                      ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Text("${suggestion!['name']}"),
                            // Text("${suggestion['price']}"),
                          ],
                        ),
                      ),
                      Divider(
                        height: 0,
                      ),
                    ],
                  );
                },
                suggestionsBoxDecoration:
                    SuggestionsBoxDecoration(offsetX: -10.0),
                onSuggestionSelected: (suggestion) {
                  // addToOrder(suggestion);
                  // addToOrderChange(suggestion);
                  setState(() {
                    widget.isSearch = false;
                  });
                },
                noItemsFoundBuilder: (context) {
                  return Text("not_found");
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
