// ignore_for_file: file_names
// // ignore_for_file: library_private_types_in_public_api, sized_box_for_whitespace, file_names
// import 'package:flutter/material.dart';
// import 'package:map_location_picker/map_location_picker.dart';

// class ChooseCountry extends StatefulWidget {
//   const ChooseCountry({Key? key}) : super(key: key);
//   @override
//   _ChooseCountryState createState() => _ChooseCountryState();
// }

// class _ChooseCountryState extends State<ChooseCountry> {
//   // String googleApikey = "AIzaSyB_k7NaX_zJsYGSndy9Ty70qeJtsYxagog";
//   String address = "null";
//   String autocompletePlace = "null";
//   Prediction? initialValue;

//   final TextEditingController _controller = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text('Check Out'),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           PlacesAutocomplete(
//             searchController: _controller,
//             apiKey: "AIzaSyB_k7NaX_zJsYGSndy9Ty70qeJtsYxagog",
//             mounted: mounted,
//             hideBackButton: true,
//             onGetDetailsByPlaceId: (PlacesDetailsResponse? result) {
//               if (result != null) {
//                 setState(() {
//                   autocompletePlace = result.result.formattedAddress ?? "";
//                 });
//               }
//             },
//           ),
//           const Spacer(),
//           ListTile(
//             title: Text("Geocoded Address: $address"),
//           ),
//           ListTile(
//             title: Text("Autocomplete Address: $autocompletePlace"),
//           ),
//           const Spacer(
//             flex: 3,
//           ),
//         ],
//       ),
//     );
//   }
// }
