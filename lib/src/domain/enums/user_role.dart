enum UserRole {
  admin,
  customer,
}

extension UserRoleParser on UserRole {
  bool get isAdmin => this == UserRole.admin;
  bool get isCustomer => this == UserRole.customer;
  static UserRole fromName(String? name, [UserRole value = UserRole.customer]) {
    if (name == null) return value;
    try {
      return UserRole.values.byName(name);
    } catch (err) {
      return value;
    }
  }
}
