import 'package:cafe_mostbyte/bloc/filial/filial_repository.dart';
import 'package:cafe_mostbyte/models/filial.dart';
import 'package:rxdart/rxdart.dart';

class FilialBloc {
  FilialRepository repo = FilialRepository();
  final _filialFetcher = PublishSubject<List<Filial>>();

  Stream<List<Filial>> get filialList => _filialFetcher.stream;

  fetchFilial() async {
    List<Filial> response = await repo.filialList();
    _filialFetcher.sink.add(response);
  }

  dispose() async {
    await _filialFetcher.close();
  }
}

final filialBloc = FilialBloc();
