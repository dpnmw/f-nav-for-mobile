import Component from "@glimmer/component";
import { service } from "@ember/service";
import DButton from "discourse/components/d-button";
import icon from "discourse-common/helpers/d-icon";
import getURL from "discourse-common/lib/get-url";
import { i18n } from "discourse-i18n";

let ChatHeaderIconUnreadIndicator;

try {
  ChatHeaderIconUnreadIndicator = require("discourse/plugins/chat/discourse/components/chat/header/icon/unread-indicator").default;
} catch (e) {
  ChatHeaderIconUnreadIndicator = null;
}

export default class ChatIcon extends Component {
  @service currentUser;
  @service site;
  @service chatStateManager;

  get showUnreadIndicator() {
    return !this.currentUserInDnD;
  }

  get currentUserInDnD() {
    return this.args.currentUserInDnD || this.currentUser.isInDoNotDisturb();
  }

  get title() {
    return i18n("chat.title_capitalized");
  }

  get icon() {
    return "comments";
  }

  get href() {
    return getURL(this.chatStateManager.lastKnownChatURL || "/chat");
  }

  <template>
    <DButton
      @href={{this.href}}
      tabindex="0"
      class="icon chat-icon btn-flat"
      title={{this.title}}
    >
      {{~icon this.icon~}}
      {{#if this.showUnreadIndicator}}
        <ChatHeaderIconUnreadIndicator
          @urgentCount={{@urgentCount}}
          @unreadCount={{@unreadCount}}
          @indicatorPreference={{@indicatorPreference}}
        />
      {{/if}}
    </DButton>
  </template>
}
