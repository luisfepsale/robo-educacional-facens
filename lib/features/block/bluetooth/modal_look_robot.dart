import 'package:flutter/material.dart';

class ModalLookRobot extends StatelessWidget {
  const ModalLookRobot({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: SizedBox(
        width: 242,
        height: 351,
        child: Column(
          children: [
            _buildRobotImage(),
            _buildTitle(),
            _buildDescription(),
            _buildButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildRobotImage() {
    return Container(
      width: 85,
      height: 85,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage("https://via.placeholder.com/85x85"),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return const Padding(
      padding: EdgeInsets.only(top: 16.0),
      child: Text(
        'Olhe para o robô!',
        style: TextStyle(
          color: Color(0xFF2580AF),
          fontSize: 22,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w700,
          height: 0,
        ),
      ),
    );
  }

  Widget _buildDescription() {
    return const Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: SizedBox(
        width: 181,
        child: Text(
          'Verifique se o robô fez sua sequência corretamente, você pode voltar fazer ajustes se desejar!',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF444444),
            fontSize: 10,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            height: 0,
          ),
        ),
      ),
    );
  }

  Widget _buildButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: SizedBox(
        width: 138,
        height: 38,
        child: ElevatedButton(
          onPressed: () {
            // Implement your button logic here
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF6767),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(width: 2, color: Color(0xFFA00000)),
            ),
          ),
          child: const Text(
            'Voltar',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              height: 0,
            ),
          ),
        ),
      ),
    );
  }
}
