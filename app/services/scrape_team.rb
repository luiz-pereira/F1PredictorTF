class ScrapeTeam

	require 'net/http'
	require 'open-uri'


  def self.scrape_wiki_teams
    @teams = []
    @teams = get_teams_list
  end

  def self.get_teams_list
		doc=Nokogiri::HTML(URI.open('https://www.f1-fansite.com/f1-teams/'))
		table_team = doc.search('.motor-sport-results td').map{|team|team.text}.reject{|a|a.size < 2}
		table_url = doc.search('.motor-sport-results a').map{|team|team['href']}
		table_team.each_with_index do |team, i| 
			team = Team.create(name: team)
			url = table_url[i]
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

  def self.scrape_team_profile(url)
    attributes={}
    drivers=[]
    doc=Nokogiri::HTML(open(url))
    attributes
  end

  def self.scrape_results_teams
    scrape_results_teams_2018
    scrape_results_teams_2019
    format_results
  end

  def self.scrape_results_teams_2018
    doc=Nokogiri::HTML(open("https://en.wikipedia.org/wiki/2018_Formula_One_World_Championship"))
    table=doc.css('h3').detect{|a|a.text=="World Constructors' Championship standings[edit]"}.css('+table')
    team=nil
    table.css('tr').each do |t|
      unless t.text.include?('Constructor')
        if t.text.split("\n").reject(&:empty?).size ==24
          team=F1Team.find_by_url("https://en.wikipedia.org" + t.css('a').map{|a|a['href']}[1])
          team.last_results<<t.text.split("\n").reject(&:empty?).map(&:to_i).map do |a|
           a == 0 ? 20 : a
          end[2..22]
        elsif t.text.split("\n").reject(&:empty?).size ==21
          team.last_results<<t.text.split("\n").reject(&:empty?).map(&:to_i).map do |a|
            a == 0 ? 20 : a
          end[0..21]
        end
      end
    end
  end

  def self.scrape_results_teams_2019
    doc=Nokogiri::HTML(open("https://en.wikipedia.org/wiki/2019_Formula_One_World_Championship"))
    table=doc.css('h3').detect{|a|a.text=="World Constructors' Championship standings[edit]"}.css('+table')
    team=nil
    table.css('tr').each do |t|
      unless t.text.include?('Constructor')
        if t.text.split("\n").reject(&:empty?).size ==6
          team=F1Team.find_by_url("https://en.wikipedia.org" + t.css('a').map{|a|a['href']}[1])
          team=F1Team.new(t.text.split("\n").reject(&:empty?)[1].strip,"https://en.wikipedia.org" + t.css('a').map{|a|a['href']}[1]) if team == nil
          team.last_results<<t.text.split("\n").reject(&:empty?).map(&:to_i).map do |a|
            a == 0 ? 20 : a
          end[2..4]
        elsif t.text.split("\n").reject(&:empty?).size ==3
          team.last_results<<t.text.split("\n").reject(&:empty?).map(&:to_i).map do |a|
            a == 0 ? 20 : a
          end[0..2]
        end
      end
    end
  end

  def self.format_results
    teams=F1Team.all.reject{|a|a.last_results.empty?}.uniq
    teams.each do |team|
      unless team.last_results.size<3
        team.last_results[0]<<team.last_results[2]
        team.last_results[0]=team.last_results[0].flatten
        team.last_results[1]<<team.last_results[3]
        team.last_results[1]=team.last_results[1].flatten
        team.last_results=team.last_results[0..1]
      end
      team.last_results=team.last_results.transpose.map(&:sum)
      while team.last_results.size<20
        team.last_results.unshift(20)
      end
    end
  end
end

