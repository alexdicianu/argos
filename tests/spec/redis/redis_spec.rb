require 'serverspec'

set :backend, :exec

describe "Redis server installation" do
  describe package("redis") do
    it { should be_installed }
  end

  describe service("redis") do
    it { should be_running }
  end

  describe file("/var/lib/redis") do
    it { should be_a_directory }
    it { should be_owned_by "redis" }
    it { should be_grouped_into "redis" }
  end

  describe file("/etc/redis.conf") do
    it { should be_a_file }
    it { should be_owned_by "redis" }
    it { should be_grouped_into "root" }
  end

  describe file("/usr/bin/redis-server") do
    it { should be_a_file }
    it { should be_owned_by "root" }
    it { should be_grouped_into "root" }
  end

  describe port(6379) do
    it { should be_listening }
  end
end
