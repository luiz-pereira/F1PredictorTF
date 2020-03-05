class ScrapeResult
 
	def self.get_results
		years = get_years
		races = years.map{|year, url|get_races(year[:year], year[:url])}
	end

  def self.get_years
		doc=Nokogiri::HTML(URI.open('https://www.f1-fansite.com/f1-results/'))
		years = []
		table_year = doc.search('.motor-sport-results td').map{|year|year.text}.reject{|a|a.size < 2}
		table_url = doc.search('.motor-sport-results a').map{|year|year['href']}
		table_year.each_with_index do |d, i| 
			url = table_url[i].gsub("\/\/", "\/").gsub(":\/", ":\/\/")
			years << {year: d, url: url}
		end
		years
	end
	
	def self.get_races(year, url)
		doc=Nokogiri::HTML(URI.open(url))
		table_races_url = doc.xpath('//*[@id="header"]/div[2]/div[4]/div/div[1]/div[2]/table[1]').search('td.msr_col1 a').map{|a|a['href'].gsub("\/\/", "\/").gsub(":\/", ":\/\/")}
		table_races_url.each do |race_url| 
			doc=Nokogiri::HTML(URI.open(race_url))
			get_race_details(doc, race_url, year)
		end
  end

	def self.get_race_details(doc, race_url, year)
		race = Race.create(name: doc.search('div > p > a').map{|a|a.text}[0], url: race_url)
		circuit_url = doc.search('div > p > a').map{|a|a['href']}[1]
		!circuit_url || circuit_url.gsub("\/\/", "\/").gsub(":\/", ":\/\/")
		circuit_name = doc.search('div > p > a').map{|a|a.text}[1]
		race.circuit = Circuit.find_by(url: circuit_url) || Circuit.create(url: circuit_url, name: circuit_name)
		race.race_date = year
		race.save
		get_results_details(doc, race)
	end

	def self.get_results_details(doc, race)
		begin
			table_positions = doc.xpath('//*[@id="msr_result"]/table').search('th.msr_col1').map(&:text) - ["Pos"]
			table_grid = doc.xpath('//*[@id="msr_result"]/table').search('td.msr_col8').map(&:text)
			table_drivers = doc.xpath('//*[@id="msr_result"]/table').search('td.msr_col3').map{|driver|driver.search('a').map{|a|a.text}.last}
			table_drivers_url = doc.xpath('//*[@id="msr_result"]/table').search('td.msr_col3').map{|driver|driver.search('a').map{|a|a['href']}.last}
			!table_drivers_url || table_drivers_url = table_drivers_url.map{|url|url.gsub("\/\/", "\/").gsub(":\/", ":\/\/")}
			table_teams = doc.xpath('//*[@id="msr_result"]/table').search('td.msr_col4').map{|team|team.search('a').map{|a|a.text}.last}
			table_teams_url = doc.xpath('//*[@id="msr_result"]/table').search('td.msr_col4').map{|team|team.search('a').map{|a|a['href']}.last}
			!table_teams_url || table_teams_url = table_teams_url.map{|url|url.gsub("\/\/", "\/").gsub(":\/", ":\/\/")}
			table_positions.each_with_index do |position, i|
				result = Result.new
				result.driver = Driver.find_by(url: table_drivers_url[i]) || Driver.create(name: table_drivers[i], url: table_drivers_url[i])
				result.team = Team.find_by(url: table_teams_url[i]) || Team.create(name: table_teams[i], url: table_teams_url[i])
				result.race = race
				result.position_start = table_grid[i]
				result.position_finish = position
				result.save
			end
		rescue => exception
		end
	end
end

