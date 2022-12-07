import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weathermodel.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String city = 'kathmandu';

  TextEditingController cityController = TextEditingController();

  Future<Weatherdatamodel> _getweather(city) async {
    final response = await http.get(Uri.parse(
        "https://api.weatherapi.com/v1/current.json?key=1bc0383d81444b58b1432929200711&q=$city&fbclid=IwAR3od4x7WRZno0agHDy2Ti0_Jq188qOS2YhQMuWlkTMFGT_Pt9eR8eh8MfQ"));
    Weatherdatamodel weatherModel = weatherdatamodelFromJson(response.body);
    print(response.body);
    if (response.statusCode == 200) {
      return weatherModel;
    }
    throw const Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getweather(city);
  }

  @override
  void dispose() {
    _getweather(city);
    super.dispose();
  }

  bool isTextFieldContains = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Weather",
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: GestureDetector(
                  child: Icon(Icons.help),
                  onTap: () {
                    Navigator.pop(context);
                  }),
            )
          ],
          centerTitle: true,
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter your Location"),
                controller: cityController,
                onChanged: (value) {
                  setState(() {
                    isTextFieldContains = true;
                  });
                },
              ),
              ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      city = cityController.text;
                    });
                  },
                  child: isTextFieldContains ? Text("Update") : Text("Save")),
              Center(
                child: FutureBuilder<Weatherdatamodel>(
                  future: _getweather(cityController.text),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final _data = snapshot.data;
                      return Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          // height: double.infinity,
                          height: 530,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white10.withOpacity(0.9),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: Offset(0, 3),
                                ),
                              ],
                              border: Border.all(
                                  color: Colors.black12.withOpacity(0.1))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _customText("Latitude"),
                              _customContainer(
                                  "${snapshot.data!.location.lat}"),
                              _customText("Long"),
                              _customContainer(
                                  "${snapshot.data!.location.lon}"),
                              _customText("Country"),
                              _customContainer(
                                  "${snapshot.data!.location.country}"),
                              _customText("Name  "),
                              _customContainer(
                                  "${snapshot.data!.location.name}"),
                              _customText("Time "),
                              _customContainer(
                                  "${snapshot.data!.location.localtime}"),
                              _customText("Region "),
                              _customContainer(
                                  "${snapshot.data!.location.tzId}"),
                              _customText("Weather Condition "),
                              _customContainer(
                                  "${snapshot.data!.current.condition.text}"),
                              _customText("Temperature In Celcius "),
                              _customContainer(
                                  "${snapshot.data!.current.tempC}"),
                              _customText("Icon "),
                              // ignore: unnecessary_new
                              new ClipRRect(
                                  borderRadius: new BorderRadius.circular(30.0),
                                  child: Image.network(
                                      'https://cdn.weatherapi.com/weather/64x64/day/116.png',
                                      fit: BoxFit.cover,
                                      height: 60.0,
                                      width: 60.0))
                            ],
                          ),
                        ),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              )
            ])));
  }

  Container _customContainer(String textName) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          color: Colors.grey.shade400,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          border: Border.all(color: Colors.black12.withOpacity(0.1))),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Text(
          textName,
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
        ),
      ),
    );
  }

  Text _customText(String text) {
    return Text(text,
        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15));
  }
}
