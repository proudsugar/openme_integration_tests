document.addEventListener('DOMContentLoaded', Snooper);

function Snooper() {
  var stubs = 'track alias name_tag people.set people.set_once people.increment people.append people.track_charge people.clear_charges people.delete_user'.split(' ');
  var spies = 'track_links track_forms register register_once unregister identify set_config'.split(' ');
  var len = 'people.'.length;

  var sinonize = function(ctx) {
    if (ctx.ua) {
      ctx.track_pageview = ctx.ua = sinon.stub(window.mixpanel, 'track_pageview');
    } else {
      ctx.track_pageview = sinon.stub(window.mixpanel, 'track_pageview');
    }

    stubs.forEach(function(key) {
      if (key.indexOf('people') != -1) {
        ctx[key] = sinon.stub(window.mixpanel.people, key.substr(len));
      } else {
        ctx[key] = sinon.stub(window.mixpanel, key);
      }
    });

    spies.forEach(function(key) {
      ctx[key] = sinon.spy(window.mixpanel, key);
    });
  };

  // Snoop on this context for sync mixpanel tracking
  sinonize( window.__mixpanel = {} );
  // Snoop on this context for async mixpanel tracking
  window.mixpanel.set_config({ loaded: sinonize });
}
