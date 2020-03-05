class ScrapeTeam

	def self.get_teams_list
		doc=Nokogiri::HTML(URI.open('https://www.f1-fansite.com/f1-teams/'))
		table_team = doc.search('.motor-sport-results td').map{|team|team.text}.reject{|a|a.size < 2}
		table_url = doc.search('.motor-sport-results a').map{|team|team['href']}
		table_team.each_with_index do |t, i| 
			team = Team.create(name: t)
			url = table_url[i].gsub("\/\/", "\/").gsub(":\/", ":\/\/")
			team.url = url
			get_team_profile(team, url)
			team.save
		end
		
  end

	def self.get_team_profile (team, url)
		begin
			doc=Nokogiri::HTML(URI.open(url))
			team.num_races = doc.xpath('//*[@id="header"]/div[2]/div[4]/div/div[1]/div[2]/div[4]/table').search('.msr_row1 td').map(&:text)[1]
			team.driver_championships = doc.xpath('//*[@id="header"]/div[2]/div[4]/div/div[1]/div[2]/div[4]/table').search('.msr_row3 td').map(&:text)[1]
			team.team_championships = doc.xpath('//*[@id="header"]/div[2]/div[4]/div/div[1]/div[2]/div[4]/table').search('.msr_row4 td').map(&:text)[1]
			team.wins = doc.xpath('//*[@id="header"]/div[2]/div[4]/div/div[1]/div[2]/div[4]/table').search('.msr_row5 td').map(&:text)[1]
			team.poles = doc.xpath('//*[@id="header"]/div[2]/div[4]/div/div[1]/div[2]/div[4]/table').search('.msr_row6 td').map(&:text)[1]
			team.podiums = doc.xpath('//*[@id="header"]/div[2]/div[4]/div/div[1]/div[2]/div[4]/table').search('.msr_row7 td').map(&:text)[1]
			team.fastest_laps = doc.xpath('//*[@id="header"]/div[2]/div[4]/div/div[1]/div[2]/div[4]/table').search('.msr_row9 td').map(&:text)[1]	
		rescue => exception
			team.destroy	
		end
		
  end

  
end

