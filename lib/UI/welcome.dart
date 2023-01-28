import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:weatherapp_starter_project/models/city.dart';
import 'package:weatherapp_starter_project/models/constants.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    List<City> cities =
        City.citiesList.where((city) => city.isDefault == false).toList();
    List<City> selectedCities = City.getSelectedCities();
    Constants myConstant = Constants();
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: myConstant.secondaryColor,
        title: Text(selectedCities.length.toString() + ' selected'),
      ),
      body: ListView.builder(
        itemCount: cities.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.only(left: 10, top: 20, right: 10),
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: size.height * .08,
            width: size.width,
            decoration: BoxDecoration(
                border: cities[index].isSelected == true
                    ? Border.all(
                        color: myConstant.secondaryColor.withOpacity(0.6),
                        width: 2,
                      )
                    : Border.all(color: Colors.white),
                borderRadius: const BorderRadius.all(
                  Radius.circular(12),
                ),
                boxShadow: [
                  BoxShadow(
                    color: myConstant.primaryColor.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  )
                ]),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      cities[index].isSelected = !cities[index].isSelected;
                    });
                  },
                  child: Image.asset(
                    cities[index].isSelected == true
                        ? 'assets/checked.png'
                        : 'assets/unchecked.png',
                    width: 30,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  cities[index].city,
                  style: TextStyle(
                    fontSize: 16,
                    color: cities[index].isSelected == true
                        ? myConstant.primaryColor
                        : Colors.black54,
                  ),
                )
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: myConstant.secondaryColor,
        child: const Icon(Icons.pin_drop),
        onPressed: () {
          print(cities);
        },
      ),
    );
  }
}
