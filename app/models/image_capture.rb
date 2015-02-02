require 'capybara'
require 'capybara/dsl'
require 'capybara/poltergeist'

Capybara.javascript_driver = :poltergeist
Capybara.run_server = false
Capybara.app_host = ENV.fetch("PHANTOM_HOST")
Capybara.current_driver = :poltergeist

class ImageCapture
  include Capybara::DSL

  attr_accessor :id

  def initialize(id)
    @id = id
  end

  def capture(size)
    visit "/words/#{id}/output/#{size}"
    page.driver.render_base64(:png, {selector: '#letter0'})
  end
end
