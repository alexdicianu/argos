require 'serverspec'

set :backend, :exec

# determine all required paths
filesdata_path = '/var/www/data/'

# DTAG SEC: Req 3.24-17, SEC: Req 3.24-18, SEC: Req 3.24-19
describe 'Files persistent data directory' do

  describe file(filesdata_path) do
    it { should be_directory }
  end

end
