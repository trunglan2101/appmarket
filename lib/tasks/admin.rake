namespace :admin do
  desc "TODO"
  task create: :environment do
    User.last.update(admin:true)
  end

end
