FactoryGirl.define do
  factory :github_pull_request do
    original_id 12_345
    link "http://example.com"
    number_of_comments 5
    created_at Time.zone.now

    initialize_with { new(attributes) }
  end
end
