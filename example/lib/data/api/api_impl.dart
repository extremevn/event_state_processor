import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:example_event_state_processor/domain/pojo/pokemon.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;

import 'api.dart';
import 'api_exception.dart';

typedef ParseDataFunction<T> = T Function(http.Response response);

class ApiImpl implements Api {
  static const int httpStatusOk = 200;
  static const int httpStatusUnauthenticated = 401;

  final Connectivity connectivity = Connectivity();

  Future<bool> isConnected() async {
    final connectivityResult = await connectivity.checkConnectivity();
    return connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi;
  }

  Future<T> callApi<T>(Future<http.Response> apiResponse,
      ParseDataFunction<T> parseDataFunction) async {
    if (!await isConnected()) {
      throw ApiException.noInternet();
    }
    final respond = await apiResponse.catchError((error) {
      throw ApiException.withMessage(message: error.toString());
    });
    return handleRespond(respond, parseDataFunction);
  }

  T handleRespond<T>(
      http.Response response, ParseDataFunction<T> parseDataFunction) {
    switch (response.statusCode) {
      case httpStatusOk:
        try {
          return parseDataFunction.call(response);
        } catch (error) {
          throw ApiException.withMessage(message: error.toString());
        }
      default:
        throw ApiException.unknown();
    }
  }

  @override
  Future<List<Pokemon>> getPokemons(int offset, int limit) async {
    //Todo : example call data from api
    // final url = "$webApiBaseUrl/pokemon?offset=$offset&limit=$limit";
    // final apiResponse = http.get(url);
    // return callApi(
    //     apiResponse,
    //     (response) => ((jsonDecode(response.body) as Map<String, dynamic>)['results'] as List)
    //         ?.map((pokemonData) => Pokemon.fromJson(pokemonData as Map<String, dynamic>))
    //         ?.toList());

    final data = await rootBundle.loadString('asset/pokemons.json');
    final jsonResult = jsonDecode(data) as List;
    final listPokemons = jsonResult
        .map((e) => Pokemon.fromJson(e as Map<String, dynamic>))
        .toList();
    return listPokemons;
  }
}
