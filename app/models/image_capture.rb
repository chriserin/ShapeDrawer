require 'capybara'
require 'capybara/dsl'
require 'capybara/poltergeist'

Capybara.javascript_driver = :poltergeist
Capybara.run_server = false
Capybara.app_host = 'http://localhost:8080'
Capybara.current_driver = :poltergeist

class ImageCapture
  include Capybara::DSL

  attr_accessor :id

  def initialize(id)
    @id = id
  end

  def capture
    visit "/words/#{id}/output/20"
    page.driver.render_base64(:png, {selector: '#letter0'})
  end
end
