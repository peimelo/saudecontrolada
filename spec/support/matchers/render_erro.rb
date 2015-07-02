RSpec::Matchers.define :render_erro do |expected|
  match do |actual|
    expect(actual).to render_template(file: "#{Rails.root}/public/erro.html")
  end
=begin
  failure_message do |actual|
    'expected to require login to access the method'
  end

  failure_message_when_negated do |actual|
    'expected not to require login to access the method'
  end

  description do
    'redirect to the login form'
  end
=end
end
