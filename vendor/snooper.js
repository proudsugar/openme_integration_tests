//
// Copyright (C) 2014 Proudsugar.com
// Author Luis Merino <luis@proudsugar.com>
//

function Snooper() {
  // used to keep tab on the sync (push-array) mixpanel fakes'
  window.__mixpanel = {};
  // fake methods lists
  this.stubs = 'track alias name_tag people.set people.set_once people.increment people.append people.track_charge people.clear_charges people.delete_user'.split(' ');
  this.spies = 'track_links track_forms register register_once unregister identify set_config'.split(' ');
}

Snooper.prototype.setup = function() {
  if (this.sandbox) {
    this.sandbox.restore();
  } else {
    this.sandbox = sinon.sandbox.create();
  }

  // Snoop on this context for async mixpanel tracking
  var loaded = function(mixpanel) {
    this.sinonize(mixpanel);
  }.bind(this)

  // Snoop on this context for sync mixpanel tracking
  this.sinonize(window.__mixpanel);

  window.mixpanel.set_config({
    loaded: loaded
  });
};

Snooper.prototype.sinonize = function(scope) {
  var len = 'people.'.length;
  var sandbox = this.sandbox;

  // very often, track_pageview is called internally because is default behavior,
  // thus we have to stub it in advance to make sure it doesn't slide
  if (scope.ua) {
    // minified version method is 'ua' and we don't want to miss it
    scope.track_pageview = scope.ua = sandbox.stub(window.mixpanel, 'track_pageview');
  } else {
    scope.track_pageview = sandbox.stub(window.mixpanel, 'track_pageview');
  }

  this.stubs.forEach(function(key) {
    if (key.indexOf('people') != -1) {
      scope[key] = sandbox.stub(window.mixpanel.people, key.substr(len));
    } else {
      scope[key] = sandbox.stub(window.mixpanel, key);
    }
  });

  this.spies.forEach(function(key) {
    scope[key] = sandbox.spy(window.mixpanel, key);
  });
};


var snooper = new Snooper();
document.addEventListener('DOMContentLoaded', snooper.setup.bind(snooper));

