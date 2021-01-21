require 'rubygems'
require 'nokogiri'
require 'open-uri'

def page_def
  vox_public = "https://www.voxpublic.org/spip.php?page=annuaire&cat=deputes&pagnum=575&lang=fr"
  page = Nokogiri::HTML(URI.open(vox_public))
  return page
end

def get_first_names (page)
  first_names = page.xpath('//*[@class="titre_normal"]').map{|element| element = element.text.to_s}
  first_names_array = []
  first_names.each do |name|
    name_array = name.split(" ")
    first_names_array << name_array[1]
  end
  return first_names_array
end

def get_last_names (page)
  last_names = page.xpath('//*[@class="titre_normal"]').map{|element| element = element.text.to_s}
  last_names_array = []
  last_names.each do |name|
    name_array = name.split(" ")
    last_names_array << name_array[2,2].join(" ")
  end
  return last_names_array
end

def get_emails (page)
  emails = page.xpath('//*[@class="ann_mail"]').map{|anchor| anchor["href"]}.select{|element| element.end_with? "nationale.fr"}.map{|mail| mail.gsub("mailto:", "")}
  return emails
end

# //*[@id="content"]/div[1]/ul[1]/li[5]/a[1]

def array_creation (first_names_array,last_names_array,emails)
  final_array = []
  emails.size.times do |i|
    hash = {}
    hash["first_name"] = first_names_array[i]
    hash["last_name"] = last_names_array[i]
    hash["email"] = emails[i]
    final_array << hash
  end
  return final_array
end

def perform
  page = page_def
  first_names_array = get_first_names(page)
  last_names_array = get_last_names(page)
  emails = get_emails(page)
  final_array = array_creation(first_names_array,last_names_array,emails)
  puts final_array
  puts final_array.length
  return final_array
end

perform