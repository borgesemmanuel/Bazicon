require 'clockwork'

# Require the full rails environment if needed
require './config/boot'
require './config/environment'

include Clockwork

# Define the jobs
handler do |job|
  if job.eql?('list new open people')
    Sync.new.get_new_people_from_expa
  elsif job.eql?('list new open applications and update people')
    Sync.new.update_status('open',[1])
  elsif job.eql?('list new accepted applications and update people')
    Sync.new.update_status('accepted',[1])
  elsif job.eql?('list new in progress applications and update people')
    Sync.new.update_status('in_progress',[1])
  elsif job.eql?('list new approved applications and update people')
    Sync.new.update_status('approved',[1])
  elsif job.eql?('list new realized applications and update people')
    Sync.new.update_status('realized',[1])
  elsif job.eql?('list new completed applications and update people')
    Sync.new.update_status('completed',[1])
  elsif job.eql?('send data to OD')
    Sync.new.send_to_od
  elsif job.eql?('list all applications and update people')
    Sync.new.search_problematic_applications(Date.new(2016,7,1),Date.new(2016,8,26))
  end
  puts "Running EXPA #{job} starting #{Time.now}"
end

# Define the schedule
every(20.minutes, 'list new open people')
every(4.hours, 'list new open applications and update people')
every(3.hours, 'list new accepted applications and update people')
every(3.hours, 'list new in progress applications and update people')
every(3.hours, 'list new approved applications and update people')
every(3.hours, 'list new realized applications and update people')
every(3.hours, 'list new completed applications and update people')
every(1.day, 'send data to OD', :at => '03:00')
#every(1.day, 'list all applications and update people', :at => '16:48')