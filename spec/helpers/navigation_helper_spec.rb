RSpec.describe NavigationHelper do
  it '.nav_tab' do
    %w[active href id Titulo].each do |item|
      expect(helper.nav_tab('Titulo', root_path)).to include(item)
    end
  end
end
