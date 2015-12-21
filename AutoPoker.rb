#coding : utf-8
def AIjudge(cards)
  flash = false
  straight = false
  royal = false
  pair = false
  two_pair = false
  three = false
  four = false
  high_card = false
  
  marks = cards.transpose[0]
  nums = cards.transpose[1]
  
  marks_type = marks.uniq.size
  max_mark = ""
  marks_type_max = marks.map{|n|
    a = marks.count(n)
    if a>2
      max_mark = n
    end
    a
    }.max
  if marks_type == 1
    flash = true
  end
  
  num_type = nums.uniq.size
  pair_num = []
  num_type_max = nums.map{|n|
    a = nums.count(n)
    if(a>1)
      pair_num.push(n)
    end
    a
    }.max
  
  
  if num_type == 5
    if nums.sort.max - nums.sort.min == 4
      straight = true
    elsif nums.sort == [1,10,11,12,13]
      royal = true
      straight = true
    else
      high_card = true
    end
    
  elsif num_type == 4
    pair = true
    
  elsif num_type == 3
    if num_type_max == 3
      three = true
    else
      two_pair = true
    end
    
  else
    if num_type_max == 4
      four = true
    else
      full_house = true
    end
  end
  
  
  if flash && royal
    return ""
     
  elsif straight && flash
    return ""
    
  elsif four
    return ""
    
  elsif full_house
    return ""
    
  elsif flash
    return ""
  
  elsif straight
    return ""
    
  elsif three
    st = ""
    5.times do |i|
      if nums[i] != pair_num[0]
        st += i.to_s
      end
    end
    return st
    
  elsif two_pair
    st = ""
    5.times do |i|
      if (nums[i] != pair_num[0]) && (nums[i] != pair_num[0])
        st += i.to_s
      end
    end
    return st
    
  elsif pair
    st = ""
    5.times do |i|
      if nums[i] != pair_num[0]
        st += i.to_s
      end
    end
    if marks_type_max == 4
      5.times do |i|
        if marks[i] != max_mark
          st = i.to_s
        end
      end 
    end
    return st
    
  elsif high_card
    if marks_type_max == 4
      5.times do |i|
        if marks[i] != max_mark
          return i.to_s
        end
      end
    end
    
    9.times do |i|
      if (nums-((i+1)..(i+4)).to_a).size == 1
        return (nums.index((nums-((i+1)..(i+4)).to_a)[0])).to_s
      end
    end
    if (nums-[1,10,11,12,13]).size == 1
      return (nums.index( (nums-[1,10,11,12,13]) [0])).to_s
    end
    
    if  marks_type_max == 3
      st = ""
      5.times do |i|
        if marks[i] != max_mark
          st += i.to_s
        end
      end
      return st
    end
    
    9.times do |i|
      if (nums-((i+1)..(i+4)).to_a).size == 2
        s = (nums.index((nums-((i+1)..(i+4)).to_a)[0])).to_s
        ss =( nums.index((nums-((i+1)..(i+4)).to_a)[1])).to_s
        return s+ss
      end
    end
    if (nums-[1,10,11,12,13]).size == 2
      s = (nums.index( (nums-[1,10,11,12,13]) [0])).to_s
      ss = (nums.index( (nums-[1,10,11,12,13]) [1])).to_s
      return s+ss
    end
    
    return "01234"
  end
end

def judge(cards)
  flash = false
  straight = false
  royal = false
  pair = false
  two_pair = false
  three = false
  four = false
  high_card = false
  
  marks = cards.transpose[0]
  nums = cards.transpose[1]
  
  if marks.uniq.size == 1
    flash = true
  end
  
  num_type = nums.uniq.size
  
  num_type_max = nums.map{|n|nums.count(n)}.max
  
  if num_type == 5
    if nums.sort.max - nums.sort.min == 4
      straight = true
    elsif nums.sort == [1,10,11,12,13]
      royal = true
      straight = true
    else
      high_card = true
    end
    
  elsif num_type == 4
    pair = true
    
  elsif num_type == 3
    if num_type_max == 3
      three = true
    else
      two_pair = true
    end
    
  else
    if num_type_max == 4
      four = true
    else
      full_house = true
    end
  end
  
  
  if flash && royal
    return :royal_flash
     
  elsif straight && flash
    return :straight_flash
    
  elsif four
    return :four_card
    
  elsif full_house
    return :full_house
    
  elsif flash
    return :flash
  
  elsif straight
    return :straight
    
  elsif three
    return :three_card
    
  elsif two_pair
    return :two_pair
    
  elsif pair
    return :pair
    
  elsif high_card
    return :high_card
  end
end


def geti
  gets.chomp.to_i
end

class Player
  def initialize
    @money = 0
    @game = nil
    @cards = []
  end
  
  def set_money(i)
    @money = i
  end
  
  def show_money
    puts "現在の所持金 : #{@money}"
  end
  
  def get_money
    return @money
  end
  
  def join_game(game)
    if playable?
      puts "既に別のゲームに参加しています"
    else
      @game = game
    end
  end
  
  def defection_game
    if playable?
      @game = nil
    else
      puts "ゲームに参加していません"
    end
  end
  
  def bet(i)
 #   print "いくらbetしますか？ : "
    num = i
    @game.bet(self, num)
    @money -= num
  end
  
  def draw
    @cards = @game.draw
  end
  
  def show_cards
    #print "所持カード : "
    @cards.each do |card|
      print "#{card[0]}の#{card[1]}, "
    end
    puts
  end
  
  def get_cards
    return @cards
  end
  
  def action(str)

    @game.action(self, str)
  end
  
  def change_card(index, card)
    @cards[index] = card
  end
  
  def showdown
    @game.showdown(self, @cards)
    @money += @game.payout(self)
    @cards = []
  end
  
  def playable?
    return @game
  end
end

class Poker
  def initialize
    @bets = {}
    @deck = []
    @odds = {}
    init_odds
    init_deck
    
    @deck.shuffle!
  end
  
  def init_odds
    @odds = {high_card:      1,
             pair:           2,
             two_pair:       4,
             three_card:     6,
             straight:       10,
             flash:          15,
             full_house:     25,
             four_card:      50,
             straight_flash: 100,
             royal_flash:    1000
             }
  end
  
  def set_odds(odds)
    @odds = odds
  end
  
  def init_deck
    mark = ["H", "D", "S", "C"]
    num = (1..13).to_a
    @deck = mark.product(num)
  end

  def bet(player, i)
    @bets[player] = i
  end
  
  def draw
    @deck.shift(5)
  end
  
  def action(player, str)
   # puts "捨てるカードを入力してください"
 #   puts '例 "124", "1と4と2", "0と1", "交換しない", "ノーチェンジ" 等'
    input = str
    5.times do|i|
      if input.include?(i.to_s)
        player.change_card(i, @deck.shift)
      end
    end
    #player.show_cards
  end
  
  def showdown(player, cards)
    hand = judge(cards)
    @bets[player] *= @odds[hand]
  end
  
  def payout(player)
    ret = @bets[player]
    @bets[player] = 0
    return ret
    
  end
  
  def next_game
    init_deck
    @deck.shuffle!
    @bets = {}
  end
  
end

game = Poker.new
player = Player.new

odds = {high_card:      0,
        pair:           1,
        two_pair:       2,
        three_card:     3,
        straight:       6,
        flash:          8,
        full_house:     15,
        four_card:      20,
        straight_flash: 40,
        royal_flash:    540
        }
game.set_odds(odds)
player.join_game(game)
  

av = 0
minus = 0
plus = 0
tims = 200
tims.times do|i|
  player.set_money 8445
  mon = 0
  40.times do
   bet_num = (player.get_money * 0.05).to_i
   # bet_num = 100
    player.bet(bet_num)
    player.draw
  #  player.show_cards
    
    cards = player.get_cards
  # puts judge(cards)
    str = AIjudge(cards)
  #  puts str + " をチェンジ"
    player.action(str)
  # player.show_cards
  #  puts judge(player.get_cards)
    player.showdown
  #  player.show_money
    mon = player.get_money
    break if player.get_money < 10

   game.next_game
  end
  puts mon
  if mon < 5000
    minus += 1
  end
  if mon > 10000
    plus += 1
  end
  av += mon
end
puts "\n\n\n"
puts av/tims
puts "1000以下 : #{minus}"
puts "10000以上 : #{plus}"
player.defection_game

  
  