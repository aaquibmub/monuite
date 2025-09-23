import 'package:flutter/material.dart';
import 'package:monuite/screens/products/product_list_screen.dart';

class LandingGlobalSearchButtonWidget extends StatelessWidget {
  const LandingGlobalSearchButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // height: 50,
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductListScreen(
                      '',
                    )),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.search, color: Color.fromRGBO(0, 0, 0, 0.2)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Search the entire shop',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
