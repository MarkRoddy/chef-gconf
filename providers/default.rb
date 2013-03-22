
# Get the current value for the specified setting
def get_current_gconf_value(user, confkey)
  output = `sudo -u #{user} dbus-launch gconftool-2 --get #{confkey}`
  return output.strip()
end

action :set do
  cmd = "dbus-launch gconftool-2 --set #{new_resource.key} --type #{new_resource.attr_type} '#{new_resource.attr_val}'"
  if 'list' == new_resource.attr_type then
    cmd += " --list-type #{new_resource.list_type}"
  end
  current_value = get_current_gconf_value(new_resource.user, new_resource.key)
  if current_value != new_resource.attr_val then
    cmd_name = "Setting gconf key #{new_resource.key} from #{current_value} to #{new_resource.attr_val}"
    execute cmd_name do
      command cmd
      # environment {} Use this for dbus at some point
      user new_resource.user
    end
  end

end

action :delete do
  if new_resource.recursive then
    cmd = "dbus-launch gconftool-2 --recursive-unset #{new_resource.key}"
    cmd_name = "Recursively unsetting gconf key '#{new_resource.key}'"
  else
    cmd = "dbus-launch gconftool-2 --unset #{new_resource.key}"
    cmd_name = "Unsetting gconf key '#{new_resource.key}'"
  end
  execute cmd_name do
    command cmd
    # environment {} Use this for dbus at some point
    user new_resource.user
  end
end
