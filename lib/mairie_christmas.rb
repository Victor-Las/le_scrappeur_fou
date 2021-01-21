require 'rubygems'
require 'nokogiri'
require 'open-uri'

# Xpath email address specific city council
# /html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]

#all city councils' URLs
def get_all_urls
  val_d_oise = "http://annuaire-des-mairies.com/val-d-oise.html"
  page = Nokogiri::HTML(URI.open(val_d_oise))
  links = page.xpath('//*[@class="lientxt"]').map{|anchor| anchor["href"]}
  return links
end

def get_names
  val_d_oise = "http://annuaire-des-mairies.com/val-d-oise.html"
  page = Nokogiri::HTML(URI.open(val_d_oise))
  names = page.xpath('//*[@class="lientxt"]').map{|element| element = element.text}
  return names
end

def scrape_addresses (links)
  emails = []
  links.each do |url|
    page_url = "http://annuaire-des-mairies.com/#{url}"
    page = Nokogiri::HTML(URI.open(page_url))
    emails << page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
  end
  return emails
end

def final_array_def (emails,names)
  final_array = []
  emails.length.times do |i|
    hash = {}
    hash[names[i]] = emails[i]
    final_array << hash
  end
  return final_array
end

def perform
  links = get_all_urls
  names = get_names
  emails = scrape_addresses(links)
  final_array = final_array_def(emails,names)
  puts final_array
end

perform
