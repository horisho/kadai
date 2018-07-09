class Agent
  attr_accessor :stone, :cputurn, :max_stone, :num_of_cpu
  def initialize(max_stone)
    @stone = rand(11..30)
    @num_of_cpu = 2
    @max_stone = max_stone
    print "机の上に ", @stone , "個 の石が積まれています\n"
    print "各プレイヤーは一度に 1個 以上 ", @max_stone, "個 以下の石を取り除きます\n"
    print "プレイヤー数はあなたを入れて ", @num_of_cpu + 1, "人 です\n"
    print "最後の石を取ったプレイヤーの負けとなります\n"
    print "ゲームスタート！　\n"
    @cputurn = rand(0..@num_of_cpu)
  end
  def put_stone(stone_num)
    num = @max_stone + 1
    if stone_num % num == 1 then
      return 1
    elsif stone_num % num == 0 then
      return @max_stone
    else return stone_num % num -1
    end
  end	
  def leave_stone(stone_num)
    if @stone >= stone_num && @max_stone >= stone_num && stone_num > 0 then
      @stone = @stone - stone_num
      print "石が " , stone_num , "個 取り除かれました\n"
      if @stone <= 0 then
        print "積まれていた石がすべてなくなりました！　\n"
      else
        print "石は " , @stone , "個 積まれています\n"
        @cputurn = (@cputurn + 1) % (@num_of_cpu + 1)
      end
    else print "無効な入力です\n"
    end
  end
end

mst = rand(2..6)
cpu_name = ["PLAYER","A", "B", "C", "D", "E"]
agent = Agent.new(mst)
while agent.stone > 0 do
  if agent.cputurn == 0 then
    while agent.cputurn == 0 do
      print "あなたの番です\n"
      print "取り除く石の数を1以上", [agent.max_stone, agent.stone].min,"以下の数字で入力してください\n"
      lst = gets
      agent.leave_stone(lst.to_i)
      if agent.stone == 0 then break end
    end
  else
    print "コンピュータ", cpu_name[agent.cputurn], "の番です\n"
    num = agent.put_stone(agent.stone)
    agent.leave_stone(num)
  end
end
print "ゲームオーバー！　\n"
if agent.cputurn == 0 then
  print "あなたの負けです！　\n"
else print "コンピュータ", cpu_name[agent.cputurn], "の負けです！　\n"
end
