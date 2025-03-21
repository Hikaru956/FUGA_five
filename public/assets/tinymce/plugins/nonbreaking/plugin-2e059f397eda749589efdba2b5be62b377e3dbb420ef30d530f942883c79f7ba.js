/**
 * Copyright (c) Tiny Technologies, Inc. All rights reserved.
 * Licensed under the LGPL or a commercial license.
 * For LGPL see License.txt in the project root for license information.
 * For commercial licenses see https://www.tiny.cloud/
 *
 * Version: 5.10.3 (2022-02-09)
 */
!function(){"use strict";function n(n,e){for(var a="",o=0;o<e;o++)a+=n;return a}function e(e,a){var o=e.getParam("nonbreaking_wrap",!0,"boolean")||e.plugins.visualchars?'<span class="'+(e.plugins.visualchars&&e.plugins.visualchars.isEnabled()?"mce-nbsp-wrap mce-nbsp":"mce-nbsp-wrap")+'" contenteditable="false">'+n("&nbsp;",a)+"</span>":n("&nbsp;",a);e.undoManager.transact(function(){return e.insertContent(o)})}var a=tinymce.util.Tools.resolve("tinymce.PluginManager"),o=tinymce.util.Tools.resolve("tinymce.util.VK");a.add("nonbreaking",function(n){function a(){return i.execCommand("mceNonBreaking")}var t,i,r,s,c;(t=n).addCommand("mceNonBreaking",function(){e(t,1)}),(i=n).ui.registry.addButton("nonbreaking",{icon:"non-breaking",tooltip:"Nonbreaking space",onAction:a}),i.ui.registry.addMenuItem("nonbreaking",{icon:"non-breaking",text:"Nonbreaking space",onAction:a}),0<(c="boolean"==typeof(s=(r=n).getParam("nonbreaking_force_tab",0))?!0===s?3:0:s)&&r.on("keydown",function(n){n.keyCode!==o.TAB||n.isDefaultPrevented()||n.shiftKey||(n.preventDefault(),n.stopImmediatePropagation(),e(r,c))})})}();