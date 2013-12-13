# coding: utf-8
require 'open-uri'

class AdsenseChecker
  def banned_words_in?(url)
    src = open(url).read
    matched = src.scan(/sex/m)
    if  matched.count > 0
        p matched
    else
        p false
    end
  end
end

adc = AdsenseChecker.new
adc.banned_words_in?('http://jp.xvideos.com')
