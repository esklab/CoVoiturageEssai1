import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';

import '../global/global.dart';
import '../infoHandler/app_info.dart';

class RatingsTabPage extends StatefulWidget
{
  const RatingsTabPage({Key? key}) : super(key: key);
  @override
  State<RatingsTabPage> createState() => _RatingsTabPageState();
}

class _RatingsTabPageState extends State<RatingsTabPage>
{
  double ratingsNumber = 0;

  @override
  void initState() {
    super.initState();
    getRatingsNumber();
  }

  getRatingsNumber()
  {
    setState(() {
      ratingsNumber = double.parse(Provider.of<AppInfo>(context, listen: false).driverAverageRatings);
    });
    setupRatingsTitle();
  }

  setupRatingsTitle()
  {
    if(ratingsNumber ==1)
    {
      setState(() {
        titleStarsRating ="Tres mauvais";
      });
    }
    if(ratingsNumber ==2)
    {
      setState(() {
        titleStarsRating ="Mauvais";
      });
    }
    if(ratingsNumber ==3)
    {
      setState(() {
        titleStarsRating ="Bon";
      });
    }
    if(ratingsNumber ==4)
    {
      setState(() {
        titleStarsRating ="Tres bon";
      });
    }
    if(ratingsNumber ==5) {
      setState(() {
        titleStarsRating = "Excellent";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        backgroundColor: Colors.white54,
        child: Container(
          margin: const EdgeInsets.all(8),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white60,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 22.0,),
              const Text(
                "Vos Etoiles :",
                style: TextStyle(
                  fontWeight:FontWeight.bold,
                  fontSize: 22,
                  letterSpacing: 2,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 22.0,),
              const Divider(height: 4.0,thickness: 4.0,),
              const SizedBox(height: 22.0,),
              SmoothStarRating(
                rating:  ratingsNumber,
                allowHalfRating: false,
                starCount: 5,
                color: Colors.green,
                borderColor: Colors.green,
                size: 46,
              ),
              const SizedBox(height: 12.0,),
              Text(
                titleStarsRating,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 12.0,),
            ],
          ),
        ),
      ),
    );
  }
}
