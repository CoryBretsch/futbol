require './spec/spec_helper'

RSpec.configure do |config|
  config.formatter = :documentation
end

RSpec.describe StatTracker do
  before(:each) do
    game_path = './data/games_test.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/test_game_teams.csv'
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
      }
    @stat_tracker = StatTracker.from_csv(locations)
  end

  describe '#initialize' do
    it 'exists with attributes' do
      expect(@stat_tracker).to be_a StatTracker
      expect(@stat_tracker.games).to be_all Games
      expect(@stat_tracker.teams).to be_all Teams
      expect(@stat_tracker.game_teams).to be_all GameTeams
      expect(@stat_tracker.games.first).to be_a Games
      expect(@stat_tracker.teams.first).to be_a Teams
      expect(@stat_tracker.game_teams.first).to be_a GameTeams
      expect(@stat_tracker.games.first.game_id).to eq("2012030221")
      expect(@stat_tracker.teams.first.team_id).to eq(1)
      expect(@stat_tracker.game_teams.first.game_id).to eq("2012030221")
    end
  end

  ######### GAME STATS ##############

  describe '#highest_total_score' do
    it "returns the highest sum of the winning and losing teams scores" do        
      expect(@stat_tracker.highest_total_score).to eq 5 # Calculated manually
    end
  end

  describe '#lowest_total_score' do
    it "returns the lowest sum of the winning and losing teams scores" do
      expect(@stat_tracker.lowest_total_score).to eq(1) # Calculated manually
    end
  end

  describe '#percentage_home_wins' do
    it "returns the percentage of home team wins" do
      total_games = @stat_tracker.games.length
      home_wins = @stat_tracker.games.count { |game| game.home_goals > game.away_goals }
      expect(@stat_tracker.percentage_home_wins).to eq(0.6)
    end
  end

  describe '#percentage_visitor_wins' do
    it "returns the percentage of away team wins" do
      total_games = @stat_tracker.games.length
      away_wins = @stat_tracker.games.count { |game| game.away_goals > game.home_goals }
      expect(@stat_tracker.percentage_visitor_wins).to eq(0.4)
    end   
  end

  describe '#percentage_ties' do
    it "returns the percentage of tie games" do
      expect(@stat_tracker.percentage_ties).to eq(0.00)
    end   
  end

  describe '#count_of_games_by_season' do
    it "returns a hash with season id's as keys and a count of games as values" do
      expect(@stat_tracker.count_of_games_by_season).to eq({ "20122013" => 10 })
    end
  end

  describe '#average_goals_per_game' do
    it "returns average number of goals scored per game from all seasons" do
      expect(@stat_tracker.average_goals_per_game).to eq(3.70)
    end
  end 

  describe '#average_goals_by_season' do
    it "returns a hash with season id's as keys and a float of average number of goals per game as value" do
      expect(@stat_tracker.average_goals_by_season).to eq({ "20122013" => 3.70 })
    end
  end

################### LEAGUE STATS #####################

  describe '#highest_scoring_visitor' do
    it "returns a string of the team name with the highest average score per game across all season when playing away" do
      expect(@stat_tracker.highest_scoring_visitor).to eq("FC Dallas")
    end
  end

  describe '#lowest_scoring_visitor' do
    it "returns a string of the team name with the highest average score per game across all season when playing away" do
      expect(@stat_tracker.lowest_scoring_visitor).to eq("Sporting Kansas City")
    end
  end


end

