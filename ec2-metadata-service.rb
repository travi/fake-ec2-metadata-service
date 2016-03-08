#!/usr/bin/env ruby

require 'sinatra'
require 'sinatra/reloader'
require 'socket'
require 'ipaddr'
require 'json'
require 'inifile'

set :bind, '169.254.169.254'
set :port, '80'

docker_range = IPAddr.new("172.17.42.1/16")

get '/latest/meta-data/local-ipv4' do
    ipv4 = (Socket.ip_address_list.select {|a| a.ipv4_private? && !(docker_range === a.ip_address) }).last
    ipv4.ip_address
end

get '/latest/meta-data/local-hostname' do
    `hostname`
end

get '/latest/meta-data/iam/security-credentials/*' do
    content_type :json

    creds_file = IniFile.load('/tmp/.aws/credentials').to_h

    {
        :Code => 'Success',
        :AccessKeyId => creds_file['default']['aws_access_key_id'],
        :SecretAccessKey => creds_file['default']['aws_secret_access_key']
    }.to_json
end
