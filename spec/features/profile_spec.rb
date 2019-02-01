require 'rails_helper'

RSpec.feature 'Profile', type: :feature do
  let(:last_email) { ActionMailer::Base.deliveries.last }
  path_regex = /(?:"https?\:\/\/.*?)(\/.*?)(?:")/    

  it 'add number', js: true do
    login_user_and_visit_profile
    number = '380123456789'
    find('#add_number_btn').click
    sleep 1
    find('#user_phone_number').set(number)
    find('#ok_btn').click
    sleep 1
    find('#user_phone_code').set('1111')
    find('#submit_code_btn').click
    sleep 1
    expect(page.body).to include(number)
  end

  it 'remove number', js: true do
    login_user_and_visit_profile
    find('#remove_number_button').click
    sleep 1
    expect(page.body).to have_no_content('380631111111')
  end

  it 'edit email', js: true do
    login_user_and_visit_profile
    find('#user_email').set('user@gmail.com')
    find('input[type="submit"]').click
    sleep 1
    expect(last_email.to).to eq ['user@gmail.com']
    path = last_email.body.match(path_regex)[1]
    visit path
    sleep 1
    expect(page.body).to include('user@gmail.com')
  end
  
  it 'remove account', js: true do
    login_user_and_visit_profile
    find('#remove_account_btn').click
    sleep 1
    expect(page.body).to include('LOG IN')
  end
end
