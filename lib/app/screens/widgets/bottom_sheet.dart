import 'package:coronavirus_covid19_tracker/app/utils/app_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef SelectedCountry(String country);

class BottomSheetWidget extends StatefulWidget {
  final SelectedCountry selectedCountry;
  final List<dynamic> countries;
  const BottomSheetWidget({Key key, this.countries, this.selectedCountry})
      : super(key: key);

  @override
  _BottomSheetWidgetState createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  List<dynamic> _filteredCountries;
  TextEditingController _countrySearchCtrl = TextEditingController();

  @override
  void initState() {
    _filteredCountries = widget.countries;
    super.initState();
  }

  void _filterCountries(value) {
    setState(() {
      _filteredCountries = widget.countries
          .where((country) =>
              country['name'].toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _countrySearchCtrl,
            onChanged: (value) {
              _filterCountries(value);
            },
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.0),
                  borderSide: const BorderSide(
                      color: Color.fromRGBO(225, 225, 225, .5), width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.0),
                  borderSide: const BorderSide(
                      color: Color.fromRGBO(225, 225, 225, 1), width: 1.0),
                ),
                hintText: "Search for country",
                contentPadding: const EdgeInsets.only(
                    top: 20, left: 20, right: 20, bottom: 10)),
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: _filteredCountries.length,
              itemBuilder: (context, index) {
                final country = _filteredCountries[index]['name'];
                final iso2 = _filteredCountries[index]["iso2"];
                final iso3 = _filteredCountries[index]["iso3"];
                final subtitle = iso3 != null
                    ? Text(iso3)
                    : (iso2 != null
                        ? Text(iso2)
                        : Text('Not available'));
                return ListTile(
                  onTap: () {
                    widget.selectedCountry(country);
                    // popping out bottom sheet
                    Navigator.pop(context);
                  },
                  leading: CircleAvatar(
                      backgroundColor: primaryColor,
                      child: Text('${index + 1}'),),
                  title: Text(country),
                  subtitle: subtitle,
                  // trailing: Icon(Icons.favorite_border),
                );
              }),
        ),
      ],
    );
  }
}

Future<void> showCountriesList(
    {@required BuildContext context,
    @required List<dynamic> countries,
    @required Function selectedCountry}) async {
  return await showModalBottomSheet(
      context: context,
      builder: (context) => BottomSheetWidget(
            countries: countries,
            selectedCountry: selectedCountry,
          ));
}
