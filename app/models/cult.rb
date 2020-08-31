require 'date'
require 'pry'

class Cult

    @@all = []
    attr_accessor :name, :location, :founding_year, :slogan

    def initialize(name, location, founding_year, slogan)
        @name = name
        @location = location
        @founding_year = founding_year
        @slogan = slogan
        @@all.push(self)
    end

    def recruit_follower(follower)
        BloodOath.new(self, follower)
    end

    def cult_population
        #return # of followers in cult
        BloodOath.all.select{ |bloodoath|
            bloodoath.cult == self
        }.count
    end

    def self.all
        @@all
    end

    def self.find_by_name(name)
        self.all.find { |cult|
            cult.name == name
        }
    end

    def self.find_by_location(location)
        self.all.select { |cult|
            cult.location == location
        }
    end

    def self.find_by_founding_year(year)
        self.all.select{ |cult|
            cult.founding_year == year
        }
    end

end

class Follower

    @@all = []
    attr_accessor :name, :age, :life_motto, :cults

    def initialize(name, age, life_motto)
        @name = name
        @age = age
        @life_motto = life_motto
        @cults = []
        @@all.push(self)
    end

    def join_cult(cult)
        BloodOath.new(cult, self)
    end

    def self.all
        @@all
    end

    def self.of_a_certain_age(age)
        self.all.select{ |follower|
            follower.age == age
        }
    end

end

class BloodOath

    @@all = []
    attr_accessor :cult, :follower, :date

    def initialize(cult, follower)
        @cult = cult
        @follower = follower
        @date = Date.today
        @@all << self
    end

    def self.all
        @@all
    end

end


team_rocket = Cult.new("Team Rocket", "Kanto", 1995, "To protect the world from devastation")
jesse = Follower.new("Jesse", 25, "We may not have a lot of money, but we sure have got our freedom!")
james = Follower.new("James", 25, "No one's carried me since my momma!")

jesse.join_cult(team_rocket)
james.join_cult(team_rocket)

scientology = Cult.new("Scientology", "USA", 1950, "Taking everyone's money")
tom_cruise = Follower.new("Tom Cruise", 58, "Won't come out of the closet")
john_travolta = Follower.new("John Travolta", 66, "Ohmigahd")

scientology.recruit_follower(tom_cruise)
scientology.recruit_follower(john_travolta)

giovanni = Follower.new("Giovanni", 49, "Rule over Team Rocket")
team_rocket.recruit_follower(giovanni)
giovanni.join_cult(scientology)

random_cult = Cult.new("Lance's Fanboys", "Kanto", 1995, "We love our dragon daddy")
random_cult.recruit_follower(Follower.new("Lance", 69, "Dragons r kewl"))

puts team_rocket.name
puts Cult.find_by_name("Scientology").name
puts Cult.find_by_location("Kanto")[1].name

puts BloodOath.all.map{ |bloodoath|
    bloodoath.follower.name
}.uniq

puts BloodOath.all[-1].date
#name, age, life_motto
#name, location, founding_year, slogan
#Cults have many followers
#Followers join many cuts
#BloodOaths