class AppValidator {
  // Validate rỗng (bắt buộc nhập)
  static String? required(
    String? value, {
    String message = "Trường này không được để trống",
  }) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }
    return null;
  }

  // Validate số (giá, số lượng...)
  static String? positiveNumber(
    String? value, {
    String message = "Phải là số lớn hơn 0",
  }) {
    if (value == null || value.trim().isEmpty) return message;
    final number = double.tryParse(value.trim());
    if (number == null || number <= 0) return message;
    return null;
  }

  // Validate email
  static String? email(String? value, {String message = "Email không hợp lệ"}) {
    if (value == null || value.trim().isEmpty) return null;
    final regex = RegExp(r'^[\w\-.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(value.trim())) return message;
    return null;
  }

  // Validate password
  static String? password(
    String? value, {
    String message = "Mật khẩu phải từ 6 ký tự",
  }) {
    if (value == null || value.trim().length < 6) return message;
    return null;
  }

  static String? url(String? value, {String message = "Link không hợp lệ"}) {
    if (value == null || value.trim().isEmpty) return null;
    final regex = RegExp(
      r"^(https?:\/\/)?([\w\-]+\.)+[\w\-]+(\/[\w\-._~:/?#\[\]@!\$&'()*+,;=]*)?$",
    );
    if (!regex.hasMatch(value.trim())) return message;
    return null;
  }

  // Validate image URL (chỉ nhận file ảnh)
  static String? imageUrl(
    String? value, {
    String message = "Link ảnh không hợp lệ",
    bool required = false,
  }) {
    if ((value == null || value.trim().isEmpty)) {
      if (required) return "Trường này không được để trống";
      return null; // cho phép bỏ trống nếu không required
    }
    final regex = RegExp(
      r'^(https?:\/\/.*\.(?:png|jpg|jpeg|gif|webp|svg))$',
      caseSensitive: false,
    );
    if (!regex.hasMatch(value.trim())) return message;
    return null;
  }

  // Validate chọn dropdown (ví dụ: danh mục)
  static String? requiredDropdown(
    String? value, {
    String message = "Vui lòng chọn trường này",
  }) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }
    return null;
  }

  // Validate số điện thoại Việt Nam
  static String? phone(
    String? value, {
    String message = "Số điện thoại không hợp lệ",
  }) {
    if (value == null || value.trim().isEmpty) return null;
    final regex = RegExp(r'^(0[3|5|7|8|9])[0-9]{8}$');
    if (!regex.hasMatch(value.trim())) return message;
    return null;
  }
}
