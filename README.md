# Discourse Zendesk Plugin
## Description

This plugin helps administrators and moderators to easily create a Zendesk ticket from a topic. An additional topic footer button will be visible to admins/moderators in each topic to create a new Zendesk ticket, where the topic title will be the ticket subject and the first post's body will be ticket comment. 

Once a case has been created, or if a case already exists for that topic, the button will change color indicating the status of the ticket, and will be a link to the ticket on Zendesk.


## Installation

Follow the Discourse [Install a Plugin](https://meta.discourse.org/t/install-a-plugin/19157)
howto, using `git clone https://github.com/anomali/discourse-zendesk-plugin.git`
as the plugin command.

After installation, go to `/admin/site_settings` and search for `zendesk`, turn on the `zendesk_plugin_enabled` site setting, and fill up the other fields `zendesk_base_url`, `zendesk_username`, `zendesk_password` and `zendesk_requester_id`.


## Configuration


## Contributions

Pull requests or suggestions are welcome.

Special thanks to [shivpkumar's Zendesk Plugin](https://github.com/shivpkumar/Zendesk-Plugin) as well as [jsorchik's Desk Plugin](https://github.com/jsorchik/discourse-desk-plugin).
