abstract class Failure {
  final String message;

  Failure(this.message);

  @override
  String toString() => message;
}

class PathFailure extends Failure {
  PathFailure(super.message);
}
