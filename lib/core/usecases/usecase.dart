abstract class Usecase<Type, Params> {
  const Usecase();

  Type call(Params params);
}

abstract class UsecaseWithoutParams<Type> {
  const UsecaseWithoutParams();

  Type call();
}
