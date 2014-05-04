require 'gmail'

File.readlines('users.txt').each do |user_pass|
    user, pass = user_pass.split(' ')
    gmail = Gmail.new(user, pass)
    if gmail.inbox.count(:unread, :from => 'hit-reply@linkedin.com') > 0
        file = File.open('log.txt', 'a')
        `notify-send -t 5000 "New recruiter blacklist emails are available!"`
        gmail.inbox.emails(:unread, :from => 'hit-reply@linkedin.com').each do |email|
            email.mark(:read)
            file.write("#{user}\n")
            file.write("#{email.from.first[:name]}\n")
            file.write("#{email.subject}\n")
            body = email.body.to_s
            body.each_line do |line|
                file.write("https://www.linkedin.com/profile/view?id=#{$1}\n\n") if line =~ /\/fpg\/(\d{6,12})\/(?:.*) LinkedIn profile/
            end
        end
        file.close unless file == nil
    end
    gmail.logout
end
