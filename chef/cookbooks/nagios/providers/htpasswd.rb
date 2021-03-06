#
# Author:: Farah Schüller <fschueller@suse.com>
# Author:: Felix Schnizlein <fschnizlein@suse.com>
# Cookbook Name:: nagios
# Provider:: htpasswd
#
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

action :delete do
  file new_resource.file do
    action :delete
    only_if { ::File.exists?(new_resource.file)}
  end
end

action :add do
  unless ::File.exists?(new_resource.file)
    file new_resource.file do
       owner "nagios"
       group node[:apache][:group]
       mode 0640
    end
  end

  execute 'add_htpasswd_user' do
    command "htpasswd -b #{new_resource.file} #{new_resource.user} #{new_resource.password}"
  end
end
