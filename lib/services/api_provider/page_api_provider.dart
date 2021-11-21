import 'dart:convert';

import '../../../services/network_service.dart';
import '../../../config/globals.dart' as globals;

class PageApiProvider {
  NetworkService net = NetworkService();

  Future<Map<String, dynamic>> getPossibilityList({queryParam = ""}) async {
    try {
      final response = await net.get(
          '${globals.apiLink}appeals/benefits?limit=100&offset=0$queryParam');
      if (response.statusCode == 200) {
        var res = json.decode(utf8.decode(response.bodyBytes));
        return res;
      } else {
        throw Exception("error fetching users");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> getShortPossibilityList() async {
    try {
      final response =
          await net.get('${globals.apiLink}appeals/benefits?limit=5&offset=0');
      if (response.statusCode == 200) {
        var res = json.decode(utf8.decode(response.bodyBytes));
        return res;
      } else {
        throw Exception("error fetching users");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<dynamic>> getAppealHighList() async {
    try {
      final response =
          await net.get('${globals.apiLink}pm-gov/authority-level-1');
      if (response.statusCode == 200) {
        var res = json.decode(utf8.decode(response.bodyBytes));
        return res;
      } else {
        throw Exception("error fetching users");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<dynamic>> getAppealLowList(id) async {
    try {
      final response =
          await net.get('${globals.apiLink}pm-gov/authority-level-2/${id}');
      if (response.statusCode == 200) {
        var res = json.decode(utf8.decode(response.bodyBytes));
        return res;
      } else {
        throw Exception("error fetching users");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> getEventList({queryParam = ""}) async {
    try {
      final response = await net
          .get('${globals.apiLink}events/event/?limit=100&offset=0$queryParam');
      if (response.statusCode == 200) {
        var res = json.decode(utf8.decode(response.bodyBytes));
        return res;
      } else {
        throw Exception("error fetching event");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> getEvent({id}) async {
    try {
      final response = await net.get('${globals.apiLink}events/event/$id');
      if (response.statusCode == 200) {
        var res = json.decode(utf8.decode(response.bodyBytes));
        return res;
      } else {
        throw Exception("error fetching event");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> getNewsList({queryParam = ""}) async {
    try {
      final response = await net.get(
          '${globals.apiLink}news/article/?limit=100&offset=0/$queryParam');
      if (response.statusCode == 200) {
        var res = json.decode(utf8.decode(response.bodyBytes));
        return res;
      } else {
        throw Exception("error fetching news");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> getNews({id}) async {
    try {
      final response = await net.get('${globals.apiLink}news/article/$id');
      if (response.statusCode == 200) {
        var res = json.decode(utf8.decode(response.bodyBytes));
        return res;
      } else {
        throw Exception("error fetching news");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> getRubric({id}) async {
    try {
      final response = await net.get('${globals.apiLink}news/category');
      if (response.statusCode == 200) {
        var res = json.decode(utf8.decode(response.bodyBytes));
        return res;
      } else {
        throw Exception("error fetching news");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> getGrantList({queryParam = ""}) async {
    try {
      final response = await net.get(
          '${globals.apiLink}grants/grant/?limit=100&offset=0/$queryParam');
      if (response.statusCode == 200) {
        var res = json.decode(utf8.decode(response.bodyBytes));
        return res;
      } else {
        throw Exception("error fetching news");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> getGrant({id}) async {
    try {
      final response = await net.get('${globals.apiLink}grants/grant/$id');
      if (response.statusCode == 200) {
        var res = json.decode(utf8.decode(response.bodyBytes));
        return res;
      } else {
        throw Exception("error fetching news");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> getCompetitionList({queryParam = ""}) async {
    try {
      final response = await net.get(
          '${globals.apiLink}contests/contest/?limit=100&offset=0/$queryParam');
      if (response.statusCode == 200) {
        var res = json.decode(utf8.decode(response.bodyBytes));
        return res;
      } else {
        throw Exception("error fetching Competition");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> getCompetition({id}) async {
    try {
      final response = await net.get('${globals.apiLink}contests/contest/$id');
      if (response.statusCode == 200) {
        var res = json.decode(utf8.decode(response.bodyBytes));
        return res;
      } else {
        throw Exception("error fetching Competition");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> getCoursesList({queryParam = ""}) async {
    try {
      final response = await net.get(
          '${globals.apiLink}courses/course/?limit=100&offset=0/$queryParam');
      if (response.statusCode == 200) {
        var res = json.decode(utf8.decode(response.bodyBytes));
        return res;
      } else {
        throw Exception("error fetching Competition");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> getCourses({id}) async {
    try {
      final response = await net.get('${globals.apiLink}courses/course/$id');
      if (response.statusCode == 200) {
        var res = json.decode(utf8.decode(response.bodyBytes));
        return res;
      } else {
        throw Exception("error fetching Competition");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> getVacancyList({queryParam = ""}) async {
    try {
      final response = await net.get(
          '${globals.apiLink}vacancies/all/?limit=100&offset=0/$queryParam');
      if (response.statusCode == 200) {
        var res = json.decode(utf8.decode(response.bodyBytes));
        return res;
      } else {
        throw Exception("error fetching Competition");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> getVacancy({id}) async {
    try {
      final response = await net.get('${globals.apiLink}vacancies/all/$id');
      if (response.statusCode == 200) {
        var res = json.decode(utf8.decode(response.bodyBytes));
        return res;
      } else {
        throw Exception("error fetching Competition");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> getProjectList() async {
    try {
      final response = await net.get('${globals.apiLink}our-projects/project/');
      if (response.statusCode == 200) {
        var res = json.decode(utf8.decode(response.bodyBytes));
        return res;
      } else {
        throw Exception("error fetching Competition");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> getProject({id}) async {
    try {
      final response =
          await net.get('${globals.apiLink}our-projects/project/$id');
      if (response.statusCode == 200) {
        var res = json.decode(utf8.decode(response.bodyBytes));
        return res;
      } else {
        throw Exception("error fetching Competition");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<dynamic>> getAbout() async {
    try {
      final response = await net.get('${globals.apiLink}about');
      if (response.statusCode == 200) {
        var res = json.decode(utf8.decode(response.bodyBytes));
        return res;
      } else {
        throw Exception("error fetching Competition");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> getAppeals({queryParam}) async {
    try {
      final response = await net.get(
          '${globals.apiLink}pm-gov/benefit-request-list?limit=100&offset=0&$queryParam');
      if (response.statusCode == 200) {
        var res = json.decode(utf8.decode(response.bodyBytes));
        return res;
      } else {
        throw Exception("error fetching Competition");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> getLibraryList({queryParam = ""}) async {
    try {
      final response = await net.get(
          '${globals.apiLink}library/book/?limit=100&offset=0/$queryParam');
      if (response.statusCode == 200) {
        var res = json.decode(utf8.decode(response.bodyBytes));
        return res;
      } else {
        throw Exception("error fetching news");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> getLibraryRubric({id}) async {
    try {
      final response = await net.get('${globals.apiLink}library/type/');
      if (response.statusCode == 200) {
        var res = json.decode(utf8.decode(response.bodyBytes));
        return res;
      } else {
        throw Exception("error fetching news");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> getDeskHonorList({queryParam = ""}) async {
    try {
      final response = await net
          .get('${globals.apiLink}achievements/achievement/$queryParam');
      if (response.statusCode == 200) {
        var res = json.decode(utf8.decode(response.bodyBytes));
        return res;
      } else {
        throw Exception("error fetching news");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> getDeskHonor({id}) async {
    try {
      final response =
          await net.get('${globals.apiLink}achievements/achievement/$id');
      if (response.statusCode == 200) {
        var res = json.decode(utf8.decode(response.bodyBytes));
        return res;
      } else {
        throw Exception("error fetching news");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> getDeskHonorRubric({id}) async {
    try {
      final response =
          await net.get('${globals.apiLink}achievements/category/');
      if (response.statusCode == 200) {
        var res = json.decode(utf8.decode(response.bodyBytes));
        return res;
      } else {
        throw Exception("error fetching news");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> getIdeaList({queryParam = ""}) async {
    try {
      final response = await net.get('${globals.apiLink}ideas/all');
      if (response.statusCode == 200) {
        var res = json.decode(utf8.decode(response.bodyBytes));
        return res;
      } else {
        throw Exception("error fetching news");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
