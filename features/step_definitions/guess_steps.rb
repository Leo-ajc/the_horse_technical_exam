Given "I am on the Github favorite language guess page" do
  visit root_url
end

When "I enter an arbitary Github username" do
  fill_in :github_username, with: 'leo-ajc'
  click_on 'Submit'
end

Then "I should see the username's favorite language" do
  expect(page).to have_content('Ruby')
end
