abstract class GarageBlocEvent {
  const GarageBlocEvent([List props = const []]) : super();
}


class GarageUpdateTest extends GarageBlocEvent {
  final bool test;

  GarageUpdateTest({
    required this.test,
  }) : super([test]);
}
