# encoding: utf-8

require 'watir'

b = Watir::Browser.new :chrome
b.goto 'http://projects.wsj.com/buzzwords2014/'

phrase = ''
for i in (1..3)
    b.button(:id, 'random_phrase').click
    phrase += ' ' + b.p(:id, 'response').text
    sleep 1
end
b.close
print "#{phrase.tr('“”','')}\n"

