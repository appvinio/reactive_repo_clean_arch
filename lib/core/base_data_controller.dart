import 'package:rxdart/rxdart.dart';

typedef SingleElementReadPrediction<Type> = bool Function(
  Type element,
);

abstract class BaseDataController<Type> {
  final List<Type> data = [];

  final BehaviorSubject<List<Type>> valuesSubject = BehaviorSubject();

  List<Type> readAll() => List.of(data);

  Type readSingle(SingleElementReadPrediction<Type> prediction) => data.firstWhere(prediction);

  Stream<List<Type>> observeAll() => valuesSubject.stream;

  Stream<Type> observeSingle(SingleElementReadPrediction<Type> prediction) =>
      valuesSubject.stream.map((event) => event.firstWhere(prediction));

  void clear() async {
    data.clear();
    _refreshData();
  }

  void dispose() async {
    await valuesSubject.close();
  }

  void add(Type element) {
    data.add(element);
    _refreshData();
  }

  void addAll(Iterable<Type> elements) {
    data.addAll(elements);
    _refreshData();
  }

  void set(Iterable<Type> elements) {
    data.clear();
    data.addAll(elements);
    _refreshData();
  }

  void setAt(int index, Type element) {
    data[index] = element;
    _refreshData();
  }

  void update(Type element, SingleElementReadPrediction<Type> prediction) {
    final index = data.indexWhere(prediction);
    data[index] = element;
    _refreshData();
  }

  void remove(Type element) {
    data.remove(element);
    _refreshData();
  }

  void _refreshData() {
    final newMap = List.of(data);
    valuesSubject.add(newMap);
  }
}
