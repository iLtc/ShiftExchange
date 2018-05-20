Role::HABTM_Users.create!([
  {role_id: 1, user_id: 1},
  {role_id: 1, user_id: 2},
  {role_id: 2, user_id: 3}
])
User::HABTM_Roles.create!([
  {role_id: 1, user_id: 1},
  {role_id: 1, user_id: 2},
  {role_id: 2, user_id: 3}
])
LoginCredential.create!([
  {credential: "tZ3DZfVBjOtTorr83ERrdLQJaRXLitNq", platform: "Demo", user_id: 1},
  {credential: "67GcaiPYyDKFcC6MY4fFg5rXUvptDyU6", platform: "Demo", user_id: 2},
  {credential: "krYtpOeIQSbMgMan_DmtO0D_YaUddkI8", platform: "Demo", user_id: 3}
])
Role.create!([
  {title: "Student"},
  {title: "Manager"}
])
User.create!([
  {first_name: "Demo Student", last_name: "1", prefer_name: nil, credits: 0, level: 0},
  {first_name: "Demo Student", last_name: "2", prefer_name: nil, credits: 0, level: 0},
  {first_name: "Demo", last_name: "Manager", prefer_name: nil, credits: 0, level: 0}
])
