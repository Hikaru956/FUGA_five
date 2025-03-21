/**
 * Copyright (c) Tiny Technologies, Inc. All rights reserved.
 * Licensed under the LGPL or a commercial license.
 * For LGPL see License.txt in the project root for license information.
 * For commercial licenses see https://www.tiny.cloud/
 *
 * Version: 5.10.3 (2022-02-09)
 */
!function(){"use strict";function t(t,o,e){var n,i;t.dom.toggleClass(t.getBody(),"mce-visualblocks"),e.set(!e.get()),n=t,i=e.get(),n.fire("VisualBlocks",{state:i})}function o(t,o){return function(e){function n(t){return e.setActive(t.state)}return e.setActive(o.get()),t.on("VisualBlocks",n),function(){return t.off("VisualBlocks",n)}}}tinymce.util.Tools.resolve("tinymce.PluginManager").add("visualblocks",function(e){function n(){return u.execCommand("mceVisualBlocks")}var i,s,c,u,l,a,r,f=(i=!1,{get:function(){return i},set:function(t){i=t}});c=f,(s=e).addCommand("mceVisualBlocks",function(){t(s,0,c)}),(u=e).ui.registry.addToggleButton("visualblocks",{icon:"visualblocks",tooltip:"Show blocks",onAction:n,onSetup:o(u,l=f)}),u.ui.registry.addToggleMenuItem("visualblocks",{text:"Show blocks",icon:"visualblocks",onAction:n,onSetup:o(u,l)}),r=f,(a=e).on("PreviewFormats AfterPreviewFormats",function(t){r.get()&&a.dom.toggleClass(a.getBody(),"mce-visualblocks","afterpreviewformats"===t.type)}),a.on("init",function(){a.getParam("visualblocks_default_state",!1,"boolean")&&t(a,0,r)})})}();