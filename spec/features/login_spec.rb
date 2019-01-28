require 'rails_helper'

RSpec.feature 'Login', type: :feature do

  it 'loggins user', js: true do
    visit root_path
    find('#user_phone_number').set('+380636086045')
    find('input[type="submit"]').click
    # wait_for_ajax
    sleep 1
    expect(page.body).to include('Code')
    find('#code').set('1111')
    find('input[value="CONFIRM"]').click
    sleep 1
    expect(page.body).to include('DASHBOARD')
  end
end
