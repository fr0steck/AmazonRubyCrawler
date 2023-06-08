require 'open-uri'
require 'nokogiri'

def search_amazon_by_keywords(keywords, limit)
  base_url = 'https://www.amazon.pl/s'
  query_params = {
    'k' => keywords,
    'i' => 'automotive',
    '__mk_pl_PL' => '%C3%85M%C3%85%C5%BD%C3%95%C3%91',
    'crid' => '1QGGFVOVX31J5',
    'sprefix' => 'moto,automotive,128',
    'ref' => 'nb_sb_noss_2'
  }

  products = []
  count = 0

  url = "#{base_url}?#{URI.encode_www_form(query_params)}"
  response = Nokogiri::HTML(URI.open(url).read)

  response.css('div.s-result-item').each do |element|
    title = element.css("h2.a-size-mini").text.strip
    price = element.css("span.a-offscreen").text.strip

    if !title.to_s.strip.empty? && !price.to_s.strip.empty?
      products << "\n"  
      products << "Tytul: #{title}\n"
      products << "Cena: #{price}\n"
      products << "\n"
      count += 1
      break if count >= limit
    end
  end
  products
end

print "Wprowadz slowa kluczowe do wyszukiwania: "
keywords = gets.chomp

print "Wprowadz ilosc produktow ktore chcesz wyszukac: "
limit = gets.chomp.to_i

products = search_amazon_by_keywords(keywords, limit)
puts products
