# PG::UniqueViolation: ERROR: duplicate key value violates unique constraint
# DETAIL: Key (id)=(186) already exists
# $ rails database:correction_seq_id
namespace :database do
  desc 'Correction of sequences id'
  task correction_seq_id: :environment do
    ActiveRecord::Base.connection.tables.each do |t|
      ActiveRecord::Base.connection.reset_pk_sequence!(t)
    end
  end
end
