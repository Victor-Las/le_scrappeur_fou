require 'rubygems'
require 'nokogiri'
require 'open-uri'
PAGE_URL = "https://coinmarketcap.com/all/views/all/"

# //*[@id="__next"]/div[1]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr[1]                  ///   root for each table line

# /html/body/div[1]/div[1]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr[1]    /td[3]/div    ///   symbols xpath

# //*[@id="__next"]/div[1]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr[1]    /td[5]/div/a  ///   prices xpath

def page_def
  page = Nokogiri::HTML(URI.open(PAGE_URL))
  return page
end

def cc_names_def (page)
  cc_names = page.xpath('//*[@class="cmc-table-row"]//td[3]/div').map{|element| element = element.text}
  return cc_names
end

def cc_price_def (page)
  cc_price = page.xpath('//*[@class="cmc-table-row"]//td[5]//div//a').map{|element| element = element.text}
  return cc_price
end

def cc_array_def (cc_names,cc_price)
  cc_array = []
  cc_names.length.times do |i|
    hash = {}
    hash[cc_names[i]] = cc_price[i]
    cc_array << hash
  end
  return cc_array
end

def perform
  page = page_def
  cc_names = cc_names_def(page)
  cc_price = cc_price_def(page)
  cc_array = cc_array_def(cc_names,cc_price)
  puts cc_array
  puts cc_array.length
end

perform




