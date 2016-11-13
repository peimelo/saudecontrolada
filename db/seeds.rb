require 'csv'

def load_file(klass)
  csv_text = File.read(Rails.root.join('db', 'data', "#{klass}.csv"))
  csv = CSV.parse(csv_text, headers: true)
  p "loading #{klass} ..."
  csv.each do |row|
    begin
      register = klass.find_by_id(row['id'])
      if register
        register.update_attributes!(row.to_hash)
      else
        klass.create!(row.to_hash)
      end
    rescue ActiveRecord::RecordInvalid => e
      p "error: #{ e } | #{ row.to_hash }"
    end
  end
  p "... done #{klass}"
end

load_file(Reference)
load_file(Unit)
load_file(Exam)
load_file(Valor)

if User.count
  User.where(gender: 'Feminino').update_all(gender: 'F')
  User.where(gender: 'Masculino').update_all(gender: 'M')
end

if Valor.count
  Valor.where(gender: 'Feminino').update_all(gender: 'F')
  Valor.where(gender: 'Masculino').update_all(gender: 'M')
end
