require 'uri'
begin require 'rspec/expectations'; rescue LoadError; require 'spec/expectations'; end

Допустим /^я на главной странице$/ do
  visit('/')
end

Допустим /^я на странице (.+)$/ do |page_name|
  visit path_to(page_name)
end

Если /^(?:|я )перехожу на страницу (.+)$/ do |page_name|
  visit path_to(page_name)
end

Если /^(?:|я )щелкаю кнопку "([^\"]*)"$/ do |button|
  click_button(button)
end

Если /^(?:|я )щелкаю ссылку "([^\"]*)"$/ do |link|
  click_link(link)
end

Если /^(?:|я )перехожу на страницу "([^\"]*)" within "([^\"]*)"$/ do |link, parent|
  click_link_within(parent, link)
end

Если /^(?:|я )ввожу в поле "([^\"]*)" значение "([^\"]*)"$/ do |field, value|
  fill_in(field, :with => value)
end

Если /^(?:|я )ввожу "([^\"]*)" в поле "([^\"]*)"$/ do |value, field|
  fill_in(field, :with => value)
end

# Use this to fill in an entire form with data from a table. Example:
#
#   When I fill in the following:
#     | Account Number | 5002       |
#     | Expiry date    | 2009-11-01 |
#     | Note           | Nice guy   |
#     | Wants Email?   |            |
#
# TODO: Add support for checkbox, select og option
# based on naming conventions.
#
Если /^(?:|я )ввожу следующие значения:$/ do |fields|
  fields.rows_hash.each do |name, value|
    When %{I fill in "#{name}" with "#{value}"}
  end
end

Если /^(?:|я )выбираю значение "([^\"]*)" из списка в поле "([^\"]*)"$/ do |value, field|
  select(value, :from => field)
end

# Use this step in conjunction with Rail's datetime_select helper. For example:
# When I select "December 25, 2008 10:00" as the date and time
Если /^(?:|я )выбираю дату и время "([^\"]*)"$/ do |time|
  select_datetime(time)
end

# Use this step when using multiple datetime_select helpers on a page or
# you want to specify which datetime to select. Given the following view:
#   <%= f.label :preferred %>

#   <%= f.datetime_select :preferred %>
#   <%= f.label :alternative %>

#   <%= f.datetime_select :alternative %>
# The following steps would fill out the form:
# When I select "November 23, 2004 11:20" as the "Preferred" date and time
# And I select "November 25, 2004 10:30" as the "Alternative" date and time
Если /^(?:|я )select "([^\"]*)" as the "([^\"]*)" date and time$/ do |datetime, datetime_label|
  select_datetime(datetime, :from => datetime_label)
end

# Use this step in conjunction with Rail's time_select helper. For example:
# When I select "2:20PM" as the time
# Note: Rail's default time helper provides 24-hour time-- not 12 hour time. Webrat
# will convert the 2:20PM to 14:20 and then select it.
Если /^(?:|я )выбираю время "([^\"]*)"$/ do |time|
  select_time(time)
end

# Use this step when using multiple time_select helpers on a page or you want to
# specify the name of the time on the form.  For example:
# When I select "7:30AM" as the "Gym" time
Если /^(?:|я )выбираю время "([^\"]*)" в поле "([^\"]*)"$/ do |time, time_label|
  select_time(time, :from => time_label)
end

# Use this step in conjunction with Rail's date_select helper.  For example:
# When I select "February 20, 1981" as the date
Если /^(?:|я )выбираю дату"([^\"]*)"$/ do |date|
  select_date(date)
end

# Use this step when using multiple date_select helpers on one page or
# you want to specify the name of the date on the form. For example:
# When I select "April 26, 1982" as the "Date of Birth" date
Если /^(?:|я )выбираю дату "([^\"]*)" в поле "([^\"]*)"$/ do |date, date_label|
  select_date(date, :from => date_label)
end

Если /^(?:|я )устанавливаю крестик в поле "([^\"]*)"$/ do |field|
  check(field)
end

Если /^(?:|я )убираю крестик в поле "([^\"]*)"$/ do |field|
  uncheck(field)
end

Если /^(?:|я )выбираю поле "([^\"]*)"$/ do |field|
  choose(field)
end

# Adds support for validates_attachment_content_type. Without the mime-type getting
# passed to attach_file() you will get a "Photo file is not one of the allowed file types."
# error message 
Если /^(?:|я )выбираю файл "([^\"]*)" в поле "([^\"]*)"$/ do |path, field|
  type = path.split(".")[1]

  case type
  when "jpg"
    type = "image/jpg" 
  when "jpeg"
    type = "image/jpeg" 
  when "png"
    type = "image/png" 
  when "gif"
    type = "image/gif"
  end
  
  attach_file(field, path, type)
end

То /^(?:|я )должен увидеть (?:|текст )"([^\"]*)"$/ do |text|
  page.should have_content(text)
end

То /^(?:|я )должен увидеть текст "([^\"]*)" в пределах "([^\"]*)"$/ do |text, selector|
  within(selector) do |content|
    content.should have_content(text)
  end
end

То /^(?:|я )должен увидеть текст \/([^\/]*)\/$/ do |regexp|
  regexp = Regexp.new(regexp)
  page.should have_content(regexp)
end

То /^(?:|я )должен увидеть текст \/([^\/]*)\/ в пределах "([^\"]*)"$/ do |regexp, selector|
  within(selector) do |content|
    regexp = Regexp.new(regexp)
    content.should have_content(regexp)
  end
end

То /^(?:|на странице )не должно быть текста "([^\"]*)"$/ do |text|
  page.should_not have_content(text)
end

То /^(?:|на странице )не должно быть текста "([^\"]*)" в пределах "([^\"]*)"$/ do |text, selector|
  within(selector) do |content|
    content.should_not have_content(text)
  end
end

То /^(?:|на странице )не должно быть текста \/([^\/]*)\/$/ do |regexp|
  regexp = Regexp.new(regexp)
  page.should_not have_content(regexp)
end

То /^(?:|на странице )не должно быть текста \/([^\/]*)\/ в пределах "([^\"]*)"$/ do |regexp, selector|
  within(selector) do |content|
    regexp = Regexp.new(regexp)
    content.should_not have_content(regexp)
  end
end

То /^поле "([^\"]*)" должно содержать "([^\"]*)"$/ do |field, value|
  field_labeled(field).value.should =~ /#{value}/
end

То /^поле "([^\"]*)" должно содержать "([^\"]*)"$/ do |field, value|
  field_labeled(field).value.should_not =~ /#{value}/
end

То /^в поле "([^\"]*)" должен быть крестик$/ do |label|
  field_labeled(label).should be_checked
end

То /^в поле "([^\"]*)" не должно быть крестика$/ do |label|
  field_labeled(label).should_not be_checked
end

То /^(?:|я )должен оказаться на странице (.+)$/ do |page_name|
  current_path = URI.parse(current_url).select(:path, :query).compact.join('?')
  #current_path.should == path_to(page_name)
  path_to(page_name) === current_path.should
end

То /^показать страницу$/ do
  save_and_open_page
end