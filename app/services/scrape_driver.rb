class ScrapeDriver
 
  def self.get_drivers_list
		doc=Nokogiri::HTML(URI.open('https://www.f1-fansite.com/f1-drivers/'))
		table_driver = doc.search('.motor-sport-results td').map{|driver|driver.text}.reject{|a|a.size < 2}
		table_url = doc.search('.motor-sport-results a').map{|driver|driver['href']}
		
		table_driver.each_with_index do |d, i| 
			driver = Driver.create(name: d)
			url = table_url[i].gsub("\/\/", "\/").gsub(":\/", ":\/\/")
			driver.url = url
			get_driver_profile(driver, url)
			driver.save
		end
		
  end

	def self.get_driver_profile (driver, url)
		begin
			doc=Nokogiri::HTML(URI.open(url))
			driver.num_races = doc.xpath('//*[@id="header"]/div[2]/div[4]/div/div[1]/div[2]/div[4]/table').search('.msr_row1 td').map(&:text)[1]
			driver.championships = doc.xpath('//*[@id="header"]/div[2]/div[4]/div/div[1]/div[2]/div[4]/table').search('.msr_row3 td').map(&:text)[1]
			driver.wins = doc.xpath('//*[@id="header"]/div[2]/div[4]/div/div[1]/div[2]/div[4]/table').search('.msr_row4 td').map(&:text)[1]
			driver.poles = doc.xpath('//*[@id="header"]/div[2]/div[4]/div/div[1]/div[2]/div[4]/table').search('.msr_row5 td').map(&:text)[1]
			driver.podiums = doc.xpath('//*[@id="header"]/div[2]/div[4]/div/div[1]/div[2]/div[4]/table').search('.msr_row6 td').map(&:text)[1]
			driver.fastest_laps = doc.xpath('//*[@id="header"]/div[2]/div[4]/div/div[1]/div[2]/div[4]/table').search('.msr_row8 td').map(&:text)[1]	

			# age
			driver.age = doc.xpath('//*[@id="header"]/div[2]/div[4]/div/div[1]/div[2]/div[3]/table').search('.msr_row4 td').text.split(' ')[-3].to_i
			current_team_url = doc.xpath('//*[@id="header"]/div[2]/div[4]/div/div[1]/div[2]/div[3]/a').map{|a|a['href']}
			driver.current_team = Team.find_by(url: current_team_url[0]) unless current_team_url.empty?
		rescue => exception
			driver.destroy	
		end
		
  end

end

