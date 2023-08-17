#!/usr/bin/ruby

require 'net/http'
require 'json'
require 'pathname'
require 'open-uri'
require 'fileutils'

### functions ###
def download(url, path)
  case io = OpenURI::open_uri(url)
  when StringIO then File.open(path, 'w') { |f| f.write(io.read) }
  when Tempfile then io.close; FileUtils.mv(io.path, path)
  end
end
### functions end ###

local_version = Dir.children('/opt/minecraft/versions').sort.last.strip

response = Net::HTTP.get(URI('https://launchermeta.mojang.com/mc/game/version_manifest.json'))
manifest = JSON.parse(response)
remote_version = manifest['latest']['release'].strip

if local_version != remote_version
  system('systemctl stop minecraft.service')
  remote_version_url = ''
  manifest['versions'].each do |version|
    if version['id'] == remote_version
      remote_version_url = version['url']
    end
  end
  rv_response = Net::HTTP.get(URI(remote_version_url))
  rv_manifest = JSON.parse(rv_response)
  rv_dl_url =  rv_manifest['downloads']['server']['url']
  rv_server_path = '/opt/minecraft/jars/minecraft_server.' + remote_version + '.jar'
  File.unlink(rv_server_path) if File.exist?(rv_server_path)
  download(rv_dl_url, rv_server_path)
  FileUtils.chown('minecraft', 'minecraft', rv_server_path)
  FileUtils.chmod(0644, rv_server_path)
  symlink_path = '/opt/minecraft/server.jar'
  File.unlink(symlink_path)
  File.symlink(rv_server_path, symlink_path)
  system('chown -h minecraft:minecraft /opt/minecraft/server.jar')
  system('systemctl start minecraft.service')
end
