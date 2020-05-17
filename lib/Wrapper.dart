import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:review_my_school/Auth.dart';
import 'package:review_my_school/Authenticate.dart';

import 'HomePage.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null)
      return Authenticate();
    else
      return HomePage(user:user);
  }
}
