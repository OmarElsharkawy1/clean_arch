
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/bloc_observer.dart';
import 'injection_container.dart' as di;

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  BlocOverrides.runZoned(
          () {
            runApp(const QuoteApp());
          },
  blocObserver: AppBlocObserver(),
  );

}


