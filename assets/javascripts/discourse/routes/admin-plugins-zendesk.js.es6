// import FilterRule from 'discourse/plugins/discourse-zendesk-plugin/discourse/models/filter-rule';
import { ajax } from 'discourse/lib/ajax';

export default Discourse.Route.extend({
  model() {
    return ajax("/zendesk/list_tickets")
      .then(function(result){
        console.log(result.tickets);
        result.tickets.forEach((i) => {
          i.base_url = Discourse.SiteSettings.zendesk_base_url;
          var x = i.external_id.split("-");
          i.forum_link = window.location.origin + '/t/' + x[x.length-1];
          i.forum_topic_id = x[x.length-1];
        })
        return result.tickets;
      })
  }
});
