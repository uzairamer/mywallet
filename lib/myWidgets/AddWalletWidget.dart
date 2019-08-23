import 'package:flutter/material.dart';

class AddWalletWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 4.0, 8.0),
      child: SizedBox(
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_circle_outline,
                  size: 40,
                  color: Theme.of(context).primaryColor,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Text(
                    'Add Wallet',
                    style: TextStyle(color: Theme.of(context).primaryColorDark, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor, width: 2.0),
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
        ),
        width: 100,
        height: 100,
      ),
      // ),
    );
  }
}
