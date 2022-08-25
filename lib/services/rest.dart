import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:RapidRecruits/main.dart';

class ResponseDto {
  Response? data;
  DioError? dioError;
  dynamic error;

  ResponseDto({
    this.data,
    this.dioError,
    this.error,
  });

  bool get hasData => data != null;

  bool get hasDioError => dioError != null;

  bool get hasError => error != null || dioError != null;
  bool get isSuccess =>
      (data?.statusCode ?? 0) >= 200 || (data?.statusCode ?? 0) < 300;
}

class ApiEndpoints {
  static const applicantAuth = 'applicant/';
  static const instituteAuth = 'college/';
  static const employee = 'employee/';
  static const userQualification = 'qualification/';
  static const vacancy = 'vacancies/';
  static const matchingVacancies = 'getmatchingvacancies/';
  static const userExperience = 'experience';
  static const applyVacancy = "applyvacancy/";
  static const getVacancyApplicatonHistory = "getuservacancies/";
  static const searchEmployee = "get_employee_by_empid/";
  static const applicantsApplied = 'getvacancyapplicants/';
  static const matchingApplicants = 'getmatchingapplicants/';
  static const recruitmentCommittee = 'recruitmentcommittee/';
  static const approachApplicant = 'approachapplicant/';
  static const dashboard = 'home/';
  static const changeStatus = 'changestatus/';
  static const vacancyById='get_vacancy_by_id/';
}

class ApiBaseHelper {
  var baseURL = 'http://RapidRecruits.pythonanywhere.com/api/';

  Dio baseAPI = Dio();

  // ApiBaseHelper() {
  //   createDio();
  // }
  //
  // void createDio() {
  //   BaseOptions opts = BaseOptions(
  //     responseType: ResponseType.json,
  //     connectTimeout: 30000,
  //     receiveTimeout: 30000,
  //   );
  //   dio = addInterceptors(Dio(opts));
  //   baseAPI = addInterceptors(dio);
  // }

  // Dio addInterceptors(Dio dio) {
  //   return dio
  //     ..interceptors.add(
  //       InterceptorsWrapper(
  //         onRequest: (options, _) => requestInterceptor(options),
  //         onError: (DioError e, _) {
  //           print(e);
  //         },
  //         onResponse: (r, _) {
  //           print(r);
  //         },
  //       ),
  //     );
  // }

  // dynamic requestInterceptor(RequestOptions options) async {
  //   // Get your JWT token
  //   var token = await FirebaseAuth.instance.currentUser!.getIdToken();
  //   options.headers.addAll({"Authorization": token});
  //   return options;
  // }

  Future<ResponseDto> getHTTP(
    String url, {
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      logger.d(
          'API Call: ${baseURL + url}\n\n${jsonEncode(queryParams ?? {})}\n\n');
      final response = await baseAPI.get(
        baseURL + url,
        queryParameters: queryParams ?? {},
      );
      logger.d(response.data);
      return ResponseDto(data: response);
    } on DioError catch (e) {
      logger.d(e);
      logger.d(e.response);
      return ResponseDto(dioError: e);
    } catch (e) {
      logger.e(e);
      return ResponseDto(error: e);
    }
  }

  Future<ResponseDto> postHTTP(String url, dynamic data) async {
    try {
      logger.d('API Call: ${baseURL + url}\n\n${jsonEncode(data)}\n\n');
      Response response = await baseAPI.post(
        baseURL + url,
        data: data,
      );
      logger.d(response.data);
      return ResponseDto(data: response);
    } on DioError catch (e) {
      logger.d(e);
      logger.d(e.response);
      return ResponseDto(dioError: e);
    } catch (e) {
      logger.e(e);
      return ResponseDto(error: e);
    }
  }

  Future<ResponseDto> putHTTP(String url, dynamic data) async {
    try {
      logger.d('API Call: ${baseURL + url}\n\n${jsonEncode(data)}\n\n');
      Response response = await baseAPI.put(
        baseURL + url,
        data: data,
      );
      logger.d(response.data);
      return ResponseDto(data: response);
    } on DioError catch (e) {
      logger.d(e);
      logger.d(e.response);
      return ResponseDto(dioError: e);
    } catch (e) {
      logger.e(e);
      return ResponseDto(error: e);
    }
  }

  Future<ResponseDto> deleteHTTP(String url) async {
    try {
      Response response = await baseAPI.delete(url);
      return ResponseDto(data: response);
    } on DioError catch (e) {
      logger.d(e);
      logger.d(e.response);
      return ResponseDto(dioError: e);
    } catch (e) {
      logger.e(e);
      return ResponseDto(error: e);
    }
  }
}
