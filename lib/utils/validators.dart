// String? validateEmail(String? value) {
//   if (value == null || value.isEmpty) {
//     return 'Email is required';
//   }
//   final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
//   if (!emailRegex.hasMatch(value)) {
//     return 'Enter a valid email';
//   }
//   return null;
// }

// String? validatePhoneNumber(String? value) {
//   if (value == null || value.isEmpty) {
//     return 'Phone number is required';
//   }
//   final phoneRegex = RegExp(r'^\d{10}$');
//   if (!phoneRegex.hasMatch(value)) {
//     return 'Enter a valid phone number';
//   }
//   return null;
// }

// String? validateCountryCode(String? value) {
//   if (value == null || value.isEmpty) {
//     return 'Country code is required';
//   }
//   final countryCodeRegex = RegExp(r'^\+\d{1,3}$');
//   if (!countryCodeRegex.hasMatch(value)) {
//     return 'Enter a valid country code';
//   }
//   return null;
// }

// String? validateUsername(String? value) {
//   if (value == null || value.isEmpty) {
//     return 'Username is required';
//   }
//   if (value.length < 3) {
//     return 'Username must be at least 3 characters';
//   }
//   return null;
// }

// String? validatePassword(String? value) {
//   if (value == null || value.isEmpty) {
//     return 'Password is required';
//   }
//   if (value.length < 6) {
//     return 'Password must be at least 6 characters';
//   }
//   return null;
// }

// String? validateEmailOrUsername(String? value) {
//   if (value == null || value.isEmpty) {
//     return 'This field cannot be empty';
//   }
//   // Validate email
//   const emailPattern = r'^[^@]+@[^@]+\.[^@]+';
//   final emailRegExp = RegExp(emailPattern);

//   // Validate username (alphanumeric, at least 3 characters)
//   const usernamePattern = r'^[a-zA-Z0-9_]{3,}$';
//   final usernameRegExp = RegExp(usernamePattern);

//   if (emailRegExp.hasMatch(value) || usernameRegExp.hasMatch(value)) {
//     return null;
//   }
//   return 'Enter a valid email or username';
// }

