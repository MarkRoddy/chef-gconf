Description
===========
The ```gconf``` resource can be used for manipulation of Gnome configuration settings via gconftool-2. 

Usage
=====

    gconf "/apps/metacity/some/setting" do
        action :set
        user "bob"
        attr_val "some_value"
    end

* action - Can be :set or :delete
* user - User name for whom the setting applies to, should be a valid account on the system.
* attr_value - Value for the setting
* attr_type - optional, the data type of the attribute value, defaults to 'string'. Can be 'int', 'bool', 'float', 'string', or 'list'.
* list_type - optional, only applicable if attr_type is list. the data type of each element in the list

See ```man gconftool-2``` for more information on attribute typing and lists, though in practice you won't need this too much.

Examples
========

Bind switching of workspaces 1-4 to Ctrl-Alt-[1-4]
--------------------------------------------------

    [1,2,3,4].each{ |n|
      gconf "/apps/metacity/global_keybindings/switch_to_workspace_#{n}" do
        action :set
        user "bob"
        attr_val "<Control><Alt>#{n}"
      end
    }

Swap Ctrl and Caps Lock key
---------------------------

    gconf '/desktop/gnome/peripherals/keyboard/kbd/options' do
      action :set
      user "bob"
      attr_val "[ctrl\tctrl:swapcaps]"
      attr_type 'list'
      list_type 'string'
    end

Turn the screensaver on and off
-------------------------------

    gconf '/apps/gnome-screensaver/idle_activation_enabled' do
      action :set
      user "bob"
      attr_val true
      attr_type 'bool'
    end

