abstract class Failure {
  final String message;

  Failure(this.message);

  @override
  String toString() => message;
}

class PathFailure extends Failure {
  PathFailure(super.message);
}

class ServerFailure extends Failure {
  ServerFailure() : super('Server Failure');
}

class TrackingFailure extends Failure {
  TrackingFailure() : super('Tracking Failure');
}

class StorageFailure extends Failure {
  StorageFailure() : super('Storage Failure');
}

class CreateFailure extends Failure {
  CreateFailure() : super('Create Failure');
}

class JoinFailure extends Failure {
  JoinFailure() : super('Join Failure');
}
