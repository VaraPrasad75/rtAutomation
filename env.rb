require "Capybara"
require "Capybara/cucumber"
require "capybara-screenshot/cucumber"
require "rspec"
# Gemfile
gem "chromedriver-helper"
require File.expand_path("../Common_Lib",__FILE__) #require
 
include RSpec::Matchers
include Common_functions
 
$timeout = 50
Capybara.configure do |capybara|
 
  Capybara.register_driver :firefox do |app|
    Capybara::Selenium::Driver.new(app, :browser => :firefox)
  end
  capybara.default_driver = :firefox #set the browser you want to run the test on
  capybara.run_server = false
  #capybara.app_host ="https://www.youtube.com" #if you have your own project, you can set your own app_host here.
    
  Capybara.page.driver.browser.manage.window.maximize
  
end

After do |scenario|
    if scenario.respond_to?('scenario_outline') then
        scenario = scenario.scenario_outline
        take_screenshot(scenario)
  	end	
end

def take_screenshot(scenario)
  if scenario.failed?
    scenario_name = scenario.name.gsub(/[^\w\-]/, '_')
	time = Time.now.strftime("%Y-%m-%d %H%M")
    screenshot_path = 'C:/Ruby24-x64/bin/RT_Locations/failed_png/'+time+'-'+scenario_name+'.png'
  else
    scenario_name = scenario.name.gsub(/[^\w\-]/, '_')
    time = Time.now.strftime("%Y-%m-%d %H%M")
    screenshot_path = 'C:/Ruby24-x64/bin/RT_Locations/success_png/'+time+'-'+scenario_name+'.png'
  end
  page.save_screenshot(screenshot_path, full: true)
end
 
RSpec.configure do |config|
  config.include Capybara::DSL
end