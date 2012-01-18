# Setting.delete_all

global = Setting.group("global")
global.key("site_url").create

airbrake = Setting.group("airbrake")
airbrake.key("api_key").create
airbrake.key("account_url").create
