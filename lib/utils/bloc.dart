import 'dart:async';


class bloc {
  final _themeController = StreamController<bool>();

  get changeTheme => _themeController.sink.add;

  get darkThemeEnabled => _themeController.stream;
}

final Bloc = bloc();