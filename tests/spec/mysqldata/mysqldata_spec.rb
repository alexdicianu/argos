require 'serverspec'

set :backend, :exec

# determine all required paths
mariadbdata_path  = '/var/lib/mysql/'

# DTAG SEC: Req 3.24-17, SEC: Req 3.24-18, SEC: Req 3.24-19
describe 'Mariadb persistent data directory' do

  describe file(mariadbdata_path) do
    it { should be_directory } 
  end

end
