import { on } from 'ember-addons/ember-computed-decorators';
import User from 'discourse/models/user';
import TopicRoute from 'discourse/routes/topic';
import { ajax } from 'discourse/lib/ajax';

export default {
  name: 'discourse-zendesk-button',
  initialize(container) {
    const user = container.lookup('current-user:main');

    const defaultTicket = {
      text: 'Create Zendesk Ticket',
      title: 'Click to create a new ticket in Zendesk',
      exists: false
    };

    const TopicFooterButtons = container.lookupFactory('component:topic-footer-buttons');
    TopicFooterButtons.reopen({
      actions: {
        clickZendeskButton() {
          const topic = this.get('topic');
          const zendeskTicket = topic.get('zendeskTicket');

          if (zendeskTicket.exists) {
            return window.open(zendeskTicket.url);
          }

          User.findByUsername(this.currentUser.get('username')).then(user => {
            const email = user.get('email');
            if (email) {
              const post = topic.get('postStream.posts.firstObject');

              const data = {
                topic_title: topic.get('title'),
                html_comment: post.get('cooked'),
                created_at: post.get('created_at'),
                external_id: `community-${topic.get('id')}`,
                post_url: post.get('url'),
                mod_email: email,
                requester: false,
                collaborator_email: false
              };

              ajax("/zendesk/create_ticket", { dataType: 'json', data, type: 'POST' })
                .then(zendeskTicket => topic.set('zendeskTicket', zendeskTicket));
            }
          });
        },
      }
    });

    TopicRoute.on("setupTopicController", event => {
      const { model } = event.controller;

      model.set('zendeskTicket', defaultTicket);

      ajax("/zendesk/find_ticket", {
        dataType: 'json',
        data: { external_id: "community-" + event.currentModel.id },
        type: 'GET'
      }).then(zendeskTicket => {
        if (zendeskTicket) {
          model.set('zendeskTicket', zendeskTicket);
        }
      });
    });
  }
}
