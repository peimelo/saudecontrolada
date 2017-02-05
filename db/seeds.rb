require 'csv'

def update_gender(kclass)
  if kclass.count
    kclass.where(gender: 'Feminino').update_all(gender: 'F')
    kclass.where(gender: 'Masculino').update_all(gender: 'M')
  end
end

def rescue_error(e, error_num, row, line_num)
  p '-------------------------'
  p "[error #{error_num}:line #{line_num}]: #{ e } | #{ row.to_hash }"
  error_num += 1
end

def load_file(klass)
  error_num = 1
  line_num = 2
  csv_text = File.read(Rails.root.join('db', 'data', "#{klass}.csv"))
  csv = CSV.parse(csv_text, headers: true)

  p "loading #{klass} ..."

  csv.each do |row|
    begin
      register = klass.find_by_id(row['id'])

      unless register
        klass.create!(row.to_hash)
      end
    rescue => e
      error_num = rescue_error(e, error_num, row, line_num)
    end

    line_num += 1
  end

  p "... done #{klass}"
end

load_file(Reference)
load_file(Unit)
load_file(Exam)
load_file(Valor)
load_file(Food)
load_file(Meal)

update_gender(User)
update_gender(Valor)
