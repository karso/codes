#!/bin/ruby -w

=begin
Run a command on thousands of servers. The list of servers will be given in a text file (serverlist.txt).
Note: You do not know beforehand how many servers are there. Not that it matters. 

Algo: 
We will read the file in a Queue. Then use threads to read from the queue till the queue empties. Threads will run the command.
=end

thrd_lmt = 5
thrd_cnt = []
  
queue = Queue.new
file = File.open('C:\Users\karsoumi\GIT\karso\codes\project_learn_ruby\project_multithreading\serverlist.txt', 'r')
file.each_line do |line|
  queue << line
end

until queue.empty? 
  puts "BP1"
  while thrd_cnt.size < thrd_lmt
    hostname = queue.pop(true) rescue nil
    puts "BP2"
    thrd_cnt << Thread.new do
      puts "BP3"
      puts "Running command on #{hostname}"
      sleep(rand(10))
    end
  end
  thrd_cnt.each do |t|
    t.join
  end
  thrd_cnt = []
end