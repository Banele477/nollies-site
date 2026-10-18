var V="nq-v1792356482";
var OK=["cdn.jsdelivr.net","unpkg.com","cdn.tailwindcss.com","fonts.googleapis.com","fonts.gstatic.com"];
self.addEventListener("install",function(){self.skipWaiting()});
self.addEventListener("activate",function(e){e.waitUntil(caches.keys().then(function(k){return Promise.all(k.filter(function(x){return x!==V}).map(function(x){return caches.delete(x)}))}).then(function(){return self.clients.claim()}))});
function put(r,res){if(res&&(res.ok||res.type==="opaque")){var c=res.clone();caches.open(V).then(function(ch){ch.put(r,c)})}return res}
self.addEventListener("fetch",function(e){
  var r=e.request;if(r.method!=="GET")return;
  var u=new URL(r.url);
  if(u.origin!==location.origin&&OK.indexOf(u.hostname)<0)return;
  if(r.mode==="navigate"){
    e.respondWith(fetch(r).then(function(x){return put(r,x)}).catch(function(){return caches.match(r).then(function(m){return m||caches.match("./")})}));
  }else if(r.destination==="image"){
    e.respondWith(caches.match(r).then(function(m){return m||fetch(r).then(function(x){return put(r,x)})}));
  }else{
    e.respondWith(caches.match(r).then(function(m){var n=fetch(r).then(function(x){return put(r,x)}).catch(function(){return m});return m||n}));
  }
});
