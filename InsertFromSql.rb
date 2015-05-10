# CSVからInsert文を生成
# 利用例 ruby InsertFromSql.rb [CSVのパス] [テーブル名]

require 'csv'

# CSVのテーブルの加工
table = CSV.read(ARGV[0])
  for i in 0..table.length-1 do
    table[i].compact!
  end
table.delete_if(&:empty?)

# SQL文の発行
sql = "INSERT INTO " + ARGV[1] + "(\n"
  for i in 0..table[0].length-1 do
    sql.concat("  " + table[0][i])
    if(i != table[0].length-1) then
      sql.concat(",\n")
    end
  end

sql.concat("\n)\nVALUES\n")
  # レコードの走査
  for j in 1..table.length-1 do
      sql.concat("  (")
    #  フィールドの走査
    for i in 0..table[i].length-1 do
      sql.concat(table[j][i])
        # フィールド間である
        if(i != table[j].length-1) then
          sql.concat(", ")
        end
	# レコードの末尾である
	if(i == table[j].length-1) then
          sql.concat(")")
	end
    end
      # レコード間である
      if(j != table.length-1) then
        sql.concat(",\n")
      end
  end
sql.concat("\n;")

# SQL文の表示
puts sql
