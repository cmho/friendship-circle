require 'highline/import'

namespace :admin do
  desc "Creates the administrator account via user prompts."
  task setup: :environment do
    Setting.ring_name = ask "Webring Name: "
    Setting.ring_description = ask "Webring Description: "
    name = ask "Admin Name: "
    email = ask "Admin Email: "
    password = ask("Admin Password:") { |q| q.echo = false }
    site_name = ask "Site Name: "
    site_url = ask "Site URL: "
    site_description = ask "Site Description: "
    @u = User.new({
      email: email,
      is_admin: true,
      display_name: name,
      site_name: site_name,
      site_url: site_url,
      site_description: site_description
    })
    @u.password = password
    if @u.save!
      puts "Admin user created."
    else
      puts "There was an error creating the admin user; try again."
    end
  end

end
