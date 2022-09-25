import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

const primaryColor = Color(0xFF24292f);

var options = BaseOptions(
  baseUrl: 'https://www.xx.com/api',
  connectTimeout: 5000,
  receiveTimeout: 3000,
);
Dio dio = Dio(options);
