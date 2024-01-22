import 'package:app/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:app/homepage.dart';
import 'package:app/gestion_budget.dart';

class MySplash extends StatefulWidget {
  const MySplash({Key? key});

  @override
  _MySplashState createState() => _MySplashState();
}

class CustomBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Color(0xFF8f9fed); // Couleur du demi-cercle

    double radius = size.height / 8;

       // Demi-cercle supérieur gauche
    canvas.drawArc(
      Rect.fromCircle(center: Offset(0, 0), radius: radius),
      0,
      3.14,
      true,
      paint,
    );

    // Demi-cercle supérieur droit
    canvas.drawArc(
      Rect.fromCircle(center: Offset(size.width, 0), radius: radius),
      -6,
      3.14,
      true,
      paint,
    );

    // Demi-cercle inférieur gauche
    canvas.drawArc(
      Rect.fromCircle(center: Offset(0, size.height), radius: radius),
      0,
      -3.14,
      true,
      paint,
    );

    // Demi-cercle inférieur droit
    canvas.drawArc(
      Rect.fromCircle(center: Offset(size.width, size.height), radius: radius),
      6,
      -3.14,
      true,
      paint,
    );
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class _MySplashState extends State<MySplash> {
   void _navigateToHomePage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyLoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // CustomPainter pour les demi-cercles
          CustomPaint(
            painter: CustomBackgroundPainter(),
            child: Container(),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'CashFlow Manager',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20.0),
              SizedBox(
                width: 100.0,
                height: 100.0,
                child: Image.asset('images/puurple-yellow.jpg'),
              ),
              SizedBox(height: 20.0),
              Text(
                'Votre Compagnon Financier Personnel.',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
         // SizedBox(height: 10,)
          // Get Started Button
          Positioned(
            bottom: 100.0,
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                width: 215,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    _navigateToHomePage(); 
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF5f75cb),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                  ),
                  child: Text(
                    'Get Started',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
