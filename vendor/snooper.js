//
// Copyright (C) 2014 Proudsugar.com
// Author Luis Merino <luis@proudsugar.com>
//

function Snooper() {
  // used to keep tab on the sync (push-array) mixpanel methods
  window.__mixpanel = {};
  // fakes
  this.stubs = 'track alias name_tag people.set people.set_once people.increment people.append people.track_charge people.clear_charges people.delete_user'.split(' ');
  this.spies = 'track_links track_forms register register_once unregister identify set_config'.split(' ');
}

Snooper.prototype.setup = function() {
  if (this.sandbox) {
    this.sandbox.restore();
  } else {
    this.sandbox = sinon.sandbox.create();
  }

  var loaded = function(mixpanel) {
    // Snoop on this context for async mixpanel tracking
    this.sinonize(mixpanel);
    this._loaded = true;
  }.bind(this)


  if (window.mixpanel.__loaded) {
    loaded(window.mixpanel);
  } else {
    // Snoop on this context for sync mixpanel tracking
    this.sinonize(window.__mixpanel);
  }

  window.mixpanel.set_config({
    loaded: loaded
  });
};

Snooper.prototype.sinonize = function(ctx) {
  var len = 'people.'.length;
  var sandbox = this.sandbox;

  // very often, track_pageview is called internally because is default behavior,
  // thus we have to stub it in advance to make sure it doesn't slide
  if (ctx.ua) {
    // minified version method is 'ua' and we don't want to miss it
    ctx.track_pageview = ctx.ua = sandbox.stub(window.mixpanel, 'track_pageview');
  } else {
    ctx.track_pageview = sandbox.stub(window.mixpanel, 'track_pageview');
  }

  this.stubs.forEach(function(key) {
    if (key.indexOf('people') != -1) {
      ctx[key] = sandbox.stub(window.mixpanel.people, key.substr(len));
    } else {
      ctx[key] = sandbox.stub(window.mixpanel, key);
    }
  });

  this.spies.forEach(function(key) {
    ctx[key] = sandbox.spy(window.mixpanel, key);
  });
};


var snooper = new Snooper();
document.addEventListener('DOMContentLoaded', snooper.setup.bind(snooper));
