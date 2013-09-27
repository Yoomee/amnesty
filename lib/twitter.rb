class Twitter
  include HTTParty
  base_uri 'https://api.twitter.com'
  
  Twitter::BLACK_LIST = File.readlines("#{Rails.root}/lib/blacklist.txt").map{|w| w.strip.downcase}
  
  def self.search(term)
    tweets = get('/1.1/search/tweets.json', :query => {:q => URI.encode(term), :rpp => 30}, :headers => {"Authorization" => "Bearer AAAAAAAAAAAAAAAAAAAAAE6ORQAAAAAAIHgBvYwKX6VNYCvOAopBkW4XGl8%3D0wGL20mu9A5u12JvTMhsdbteFi77SPOnE1wURuKTjA"})["statuses"] || []
    tweets.reject do |tweet|
      tweet["text"].split(/[^\w]/).any?{|word| Twitter::BLACK_LIST.include?(word.downcase)}
    end
  end
  
end