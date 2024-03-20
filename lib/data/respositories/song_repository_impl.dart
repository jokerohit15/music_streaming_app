import 'package:music_streaming_app/data/data_sources/song_remote_data_source.dart';
import 'package:music_streaming_app/data/models/song_model.dart';
import 'package:music_streaming_app/domain/repositories/song_repository.dart';


class SongRepositoryImpl implements SongRepository {
  final SongRemoteDataSource remoteDataSource;

  SongRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<SongModel>> fetchSongs() async {
    return await remoteDataSource.fetchSongs();
  }

  @override
  Future<List<SongModel>> fetchMonthlyHits() async{
    return await remoteDataSource.fetchMonthlyHits();
  }




}
