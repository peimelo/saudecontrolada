FactoryGirl.define do
  factory :erro do
    erro_status_id {create(:erro_status).id}
    recurso_id {create(:recurso).id}
  end
end