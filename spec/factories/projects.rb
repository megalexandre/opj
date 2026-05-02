FactoryBot.define do
  factory :project do
    client { nil }
    address { nil }
    utility_company { "MyString" }
    utility_protocol { "MyString" }
    customer_class { "MyString" }
    integrator { "MyString" }
    modality { "MyString" }
    framework { "MyString" }
    status { "MyString" }
    amount { "9.99" }
    dc_protection { "MyString" }
    system_power { 1.5 }
    unit_control { "MyString" }
    description { "MyString" }
    project_type { "MyString" }
    fast_track { false }
    coordinates { "" }
  end
end
