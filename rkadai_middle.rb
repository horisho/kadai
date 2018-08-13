class Game
  attr_accessor :stone, :cputurn, :max_stone, :num_of_cpu
  def initialize(num_of_cpu)
    @stone = rand(11..30)
    @num_of_cpu = num_of_cpu
    @max_stone = rand(2..6)
    interval_1 = 0.2
    puts "机の上に #{@stone}個 の石が積まれています"
    sleep(interval_1)
    puts "各プレイヤーは一度に 1個 以上 #{@max_stone}個 以下の石を取り除きます"
    sleep(interval_1)
    puts "プレイヤー数はあなたを入れて #{@num_of_cpu + 1}人 です"
    sleep(interval_1)
    puts "最後の石を取ったプレイヤーの負けとなります"
    sleep(interval_1)
    puts "ゲームスタート！　"
    @cputurn = rand(0..@num_of_cpu)
  end
  def put_stone(stone_num)
    num = @max_stone + 1
    if stone_num % num == 1
      return 1
    elsif stone_num % num == 0
      return @max_stone
    else return stone_num % num -1
    end
  end	
  def leave_stone(stone_num)
    interval_2 = 0.2
    sleep(interval_2)
    if @stone >= stone_num && @max_stone >= stone_num && stone_num > 0
      @stone = @stone - stone_num
      puts "石が #{stone_num}個 取り除かれました"
      sleep(interval_2)
      if @stone <= 0
        puts "積まれていた石がすべてなくなりました！　"
      else
        puts "石は #{@stone}個 積まれています"
        @cputurn = (@cputurn + 1) % (@num_of_cpu + 1)
      end
    else 
      puts "無効な入力です"
      sleep(interval_2)
    end
  end
end

class Agent
  attr_accessor :max_stone, :name
  def initialize(max_stone,cpu_num)
    arr_cpu_name = ["PLAYER","コンピュータA", "コンピュータB", "コンピュータC", "コ>ンピュータD", "コンピュータE"] 
    @max_stone = max_stone; @name = arr_cpu_name[cpu_num]
  end
  def put_stone(stone_num)
    num = @max_stone + 1
    if stone_num % num == 1
      return 1     
    elsif stone_num % num == 0
      return @max_stone     
    else return stone_num % num -1     
    end   
  end
end

game = Game.new(2)
agent = Array.new(game.num_of_cpu + 1)
for num in 1..game.num_of_cpu do
  agent[num] = Agent.new(game.max_stone,num)
end
interval_0 = 0.2
while game.stone > 0 do
  sleep(interval_0)
  if game.cputurn == 0
    while game.cputurn == 0 do
      puts "あなたの番です"
      sleep(interval_0)
      puts "取り除く石の数を1以上#{[game.max_stone, game.stone].min}以下の数字で入力してください"
      lst = gets
      game.leave_stone(lst.to_i)
      break if game.stone == 0
    end
  else
    puts "#{agent[game.cputurn].name}の番です"
    game.leave_stone(agent[game.cputurn].put_stone(game.stone))
  end
end
sleep(interval_0)
puts "ゲームオーバー！　"
sleep(interval_0)
if game.cputurn == 0
  print "あなたの負けです！　"
else puts "#{agent[game.cputurn].name}の負けです！　"
end
