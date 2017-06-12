# Discourse Zendesk Plugin
## Description

This plugin helps administrators and moderators to easily create a Zendesk ticket from a topic. An additional topic footer button will be visible to admins/moderators in each topic to create a new Zendesk ticket, where the topic title will be the ticket subject and the first post's body will be ticket comment. 

Once a case has been created, or if a case already exists for that topic, the button label and color will change indicating the status of the ticket, and clicking it will link to the ticket on Zendesk.

<a href="https://github.com/anomali/discourse-zendesk-plugin/blob/master/Screen%20Shot%202017-06-07%20at%201.59.30%20PM.png?raw=true"><img src="https://github.com/anomali/discourse-zendesk-plugin/blob/master/Screen%20Shot%202017-06-07%20at%201.59.30%20PM.png?raw=true" width="720px"></a>

<a href="https://github.com/anomali/discourse-zendesk-plugin/blob/master/Screen%20Shot%202017-06-07%20at%201.59.42%20PM.png?raw=true"><img src="https://github.com/anomali/discourse-zendesk-plugin/blob/master/Screen%20Shot%202017-06-07%20at%201.59.42%20PM.png?raw=true" width="720px"></a>

<a href="https://github.com/anomali/discourse-zendesk-plugin/blob/master/Screen%20Shot%202017-06-07%20at%202.00.04%20PM.png?raw=true"><img src="https://github.com/anomali/discourse-zendesk-plugin/blob/master/Screen%20Shot%202017-06-07%20at%202.00.04%20PM.png?raw=true" width="720px"></a>

<a href="https://github.com/anomali/discourse-zendesk-plugin/blob/master/Screen%20Shot%202017-06-07%20at%202.00.35%20PM.png?raw=true"><img src="https://github.com/anomali/discourse-zendesk-plugin/blob/master/Screen%20Shot%202017-06-07%20at%202.00.35%20PM.png?raw=true" width="720px"></a>

<a href="https://github.com/anomali/discourse-zendesk-plugin/blob/master/Screen%20Shot%202017-06-07%20at%202.01.17%20PM.png?raw=true"><img src="https://github.com/anomali/discourse-zendesk-plugin/blob/master/Screen%20Shot%202017-06-07%20at%202.01.17%20PM.png?raw=true" width="720px"></a>

Got to `/admin/plugins/zendesk` to view all tickets currently opened from your forum and their information from a table view in the admin page. Click on the links for quick access to the topics or tickets. 

<a href="https://github.com/anomali/discourse-zendesk-plugin/blob/master/Screen%20Shot%202017-06-07%20at%202.02.28%20PM.png?raw=true"><img src="https://github.com/anomali/discourse-zendesk-plugin/blob/master/Screen%20Shot%202017-06-07%20at%202.02.28%20PM.png?raw=true" width="720px"></a>

## Installation

Follow the Discourse [Install a Plugin](https://meta.discourse.org/t/install-a-plugin/19157)
howto, using `git clone https://github.com/anomali/discourse-zendesk-plugin.git`
as the plugin command.

After installation, go to `/admin/site_settings` and search for `zendesk`, turn on the `zendesk_plugin_enabled` site setting, and fill up the other fields `zendesk_base_url`, `zendesk_username`, `zendesk_password` and `zendesk_requester_id`.

`zendesk_plugin_enabled`: This toggles the 'Create Zendesk Button' in the topic footer buttons group (under the first post of every topic).

`zendesk_base_url`: The url of your organization's zendesk endpoint (e.g. www.myorg.zendesk.com)

`zendesk_username` and `zendesk_password`: The username and password combination of the Zendesk user account that would create the Zendesk ticket. This user would also be the requester and assignee of the ticket (for the time being).

`zendesk_requester_id`: The ID of the user with the above credentials. (Again for the time being.)


<a href="https://github.com/anomali/discourse-zendesk-plugin/blob/master/Screen%20Shot%202017-06-07%20at%201.59.03%20PM.png?raw=true"><img src="https://github.com/anomali/discourse-zendesk-plugin/blob/master/Screen%20Shot%202017-06-07%20at%201.59.03%20PM.png?raw=true" width="720px"></a>

## Contributions

Pull requests or suggestions are welcome.

Special thanks to [shivpkumar's Zendesk Plugin](https://github.com/shivpkumar/Zendesk-Plugin) as well as [jsorchik's Desk Plugin](https://github.com/jsorchik/discourse-desk-plugin).
