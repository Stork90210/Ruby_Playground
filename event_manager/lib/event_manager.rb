require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials
  rescue
    "You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials"
  end
end

def save_thank_you_letter(id,form_letter)
  Dir.mkdir("output") unless Dir.exists?("output")

  filename = "output/thanks_#{id}.html"

  File.open(filename,'w') do |file|
    file.puts form_letter
  end
end

def clean_phone_number(phone)
  phone.gsub!(/[^0-9]/, '')
  
  if phone.length < 10 || phone.length > 11 
    'Bad Number'
  elsif phone.length == 11
    if phone[0] == 1
      phone[1..10]
    else
      phone[0] = ''
      phone
    end
  else
    phone
  end
end

def convert_date(unformatted_date)
  DateTime.strptime(unformatted_date, '%m/%d/%y %H:%M')
end

def tally_hours(date)
  p date.hour
  $hours_tally[date.hour] ? $hours_tally[date.hour] += 1 : $hours_tally[date.hour] = 1
  p $hours_tally
end



puts "EventManager initialized."

contents = CSV.open 'event_attendees_full.csv', headers: true, header_converters: :symbol

template_letter = File.read "form_letter.erb"
erb_template = ERB.new template_letter
$hours_tally = {}



contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  phone = row[:homephone]
  #legislators = legislators_by_zipcode(zipcode)
  registration_date = row[:regdate]

  #form_letter = erb_template.result(binding)
  p clean_phone_number(phone)

  reg_date = convert_date(registration_date)
  tally_hours(reg_date)
  p $hours_tally.sort
  
end