tinymce.PluginManager.add("fullscreen",function(e){function t(){var e,t,n=window,i=document.body;return i.offsetWidth&&(e=i.offsetWidth,t=i.offsetHeight),n.innerWidth&&n.innerHeight&&(e=n.innerWidth,t=n.innerHeight),{w:e,h:t}}function n(){function n(){d.setStyle(a,"height",t().h-(h.clientHeight-a.clientHeight))}var u,h,a,f,m=document.body,g=document.documentElement;s=!s,u=(h=e.getContainer()).style,f=(a=e.getContentAreaContainer().firstChild).style,s?(i=f.width,l=f.height,f.width=f.height="100%",c=u.width,o=u.height,u.width=u.height="",d.addClass(m,"mce-fullscreen"),d.addClass(g,"mce-fullscreen"),d.addClass(h,"mce-fullscreen"),d.bind(window,"resize",n),n(),r=n):(f.width=i,f.height=l,c&&(u.width=c),o&&(u.height=o),d.removeClass(m,"mce-fullscreen"),d.removeClass(g,"mce-fullscreen"),d.removeClass(h,"mce-fullscreen"),d.unbind(window,"resize",r)),e.fire("FullscreenStateChanged",{state:s})}var i,l,r,c,o,s=!1,d=tinymce.DOM;return e.settings.inline?void 0:(e.on("init",function(){e.addShortcut("Ctrl+Alt+F","",n)}),e.on("remove",function(){r&&d.unbind(window,"resize",r)}),e.addCommand("mceFullScreen",n),e.addMenuItem("fullscreen",{text:"Fullscreen",shortcut:"Ctrl+Alt+F",selectable:!0,onClick:n,onPostRender:function(){var t=this;e.on("FullscreenStateChanged",function(e){t.active(e.state)})},context:"view"}),e.addButton("fullscreen",{tooltip:"Fullscreen",shortcut:"Ctrl+Alt+F",onClick:n,onPostRender:function(){var t=this;e.on("FullscreenStateChanged",function(e){t.active(e.state)})}}),{isFullscreen:function(){return s}})});