action :set do
  dbus_session = "$(grep -v \"^#\" $HOME/.dbus/session-bus/`cat /var/lib/dbus/machine-id`-0)"
  cmd = "env #{dbus_session} "
  cmd += "gconftool-2 --set #{new_resource.key} --type #{new_resource.attr_type} '#{new_resource.attr_val}'"
  if 'list' == new_resource.attr_type then
    cmd += " --list-type #{new_resource.list_type}"
  end
  cmd_name = "Setting gconf key '#{new_resource.key}' to '#{new_resource.attr_val}'"
  execute cmd_name do
    command cmd
    # environment {} Use this for dbus at some point
    user new_resource.user
  end
end

action :delete do
  dbus_session = "$(grep -v \"^#\" $HOME/.dbus/session-bus/`cat /var/lib/dbus/machine-id`-0)"
  cmd = "env #{dbus_session} "
  if new_resource.recursive then
    cmd += "gconftool-2 --recursive-unset #{new_resource.key}"
    cmd_name = "Recursively unsetting gconf key '#{new_resource.key}'"
  else
    cmd += "gconftool-2 --unset #{new_resource.key}"
    cmd_name = "Unsetting gconf key '#{new_resource.key}'"
  end
  execute cmd_name do
    command cmd
    # environment {} Use this for dbus at some point
    user new_resource.user
  end
end
