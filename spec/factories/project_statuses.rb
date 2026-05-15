FactoryBot.define do
  factory :project_status do
    association :project
    name { "pendente" }
  end
end
