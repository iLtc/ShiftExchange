Role.create!([
  {title: "Student"},
  {title: "Manager"},
  {title: "Robot"}
])
User.create!([
  {first_name: "System Robot", last_name: nil, prefer_name: nil, credits: 0, level: 0},
  {first_name: "Demo Student", last_name: "1", prefer_name: nil, credits: 0, level: 0},
  {first_name: "Demo Student", last_name: "2", prefer_name: nil, credits: 0, level: 0},
  {first_name: "Demo Manager", last_name: nil, prefer_name: nil, credits: 0, level: 0}
])
LoginCredential.create!([
  {credential: "tZ3DZfVBjOtTorr83ERrdLQJaRXLitNq", platform: "Demo", user_id: 2},
  {credential: "67GcaiPYyDKFcC6MY4fFg5rXUvptDyU6", platform: "Demo", user_id: 3},
  {credential: "krYtpOeIQSbMgMan_DmtO0D_YaUddkI8", platform: "Demo", user_id: 4}
])