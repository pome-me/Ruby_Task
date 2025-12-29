require "csv"

input = nil

#１か２が入力されるまで表示
loop do
    print "1(新規でメモを作成) 2(既存のメモ編集する)"
    input = gets&.chomp
    if input == "1" || input == "2"
        break
    else
        puts "1か2を入力してください"
    end
end

puts "拡張子を除いたファイル名を入力してください"
file_name = gets.chomp

dir = File.dirname(__FILE__)
path = File.join(dir,"#{file_name}.csv")

#２を入力後同じフォルダに存在しないファイル名を入力した場合はエラー
if input == "2" && !File.exist?(path)
    puts "そのファイルは存在しません"
    exit
end

puts "メモしたい内容を入力してください"
puts "完了したらCtrl + Dをおします。"

lines = []

loop do
    line = gets
    break if line.nil?
    line = line.chomp
    break if line == ":q"
    lines << line
end

#CSVファイルを作成して書き込む
CSV.open(path, "w") do |csv|
    lines.each do |line|
        csv << line.split(",")
    end
end
