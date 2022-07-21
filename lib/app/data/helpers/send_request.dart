// ignore_for_file: unused_import

//Librerias de flutter
import 'dart:convert';
import 'dart:io';

//Servicios
import 'package:http/http.dart';
import 'http_method.dart';

Future<Response> sendRequest({
  required Uri url,
  required HttpMethod method,
  required Map<String,String> headers,
  required dynamic body,
  required Duration timeOut,
  }
  )
  {
    final client = Client();
    switch (method) {
      case HttpMethod.get:
        return client.get(url, headers: headers,).timeout(timeOut);
      case HttpMethod.post:
        return client.post(url, headers: headers, body: body,).timeout(timeOut);
      case HttpMethod.put:
        return client.put(url, headers: headers, body: body,).timeout(timeOut);
    }
  }