FactoryGirl.define do
  factory :pull_request_storage do
    link  "http://example.com"
    title "Example"
    org   "Alliants"
    repo  "some/repository"
    owner "some_owner"
    number_of_comments 5
    created_at Time.zone.now
  end
end
