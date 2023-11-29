class EndPoints {
  static const baseUrl = 'http://10.0.2.2:3000';
  static const register = '$baseUrl/auth/register';
  static const login = '$baseUrl/auth/login';
  static const tutors = '$baseUrl/tutors';
  static const profile = '$baseUrl/auth/profile';
  static const request = '$baseUrl/student/request';
  static const teacherRequest = '$baseUrl/tutors/request';
  static const schedule = '$baseUrl/tutors/schedule';
  static const deactivate = '$baseUrl/auth/deactivate';
  static const report = '$baseUrl/student/report';
  static const sendEmail = '$baseUrl/auth/sendCode';
  static const sendCode = '$baseUrl/auth/confirmCode';
  static const forgotPassword = '$baseUrl/auth/forgotPassword';
  static const changePassword = '$baseUrl/auth/changePassword';
}
