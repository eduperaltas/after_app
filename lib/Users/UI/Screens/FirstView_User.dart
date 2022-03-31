import 'package:after_app/Widgets/sidebar/navigation_bloc.dart';
import 'package:after_app/Widgets/sidebar/sidebar_layout.dart';
import 'package:flutter/material.dart';


class FirstView extends StatelessWidget with NavigationStates {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SideBarLayout(),
    );
  }
}