/**
 * Copyright (c) Tiny Technologies, Inc. All rights reserved.
 * Licensed under the LGPL or a commercial license.
 * For LGPL see License.txt in the project root for license information.
 * For commercial licenses see https://www.tiny.cloud/
 *
 * Version: 5.10.3 (2022-02-09)
 */
!function(){"use strict";tinymce.util.Tools.resolve("tinymce.PluginManager").add("hr",function(n){function o(){return e.execCommand("InsertHorizontalRule")}var t,e;(t=n).addCommand("InsertHorizontalRule",function(){t.execCommand("mceInsertContent",!1,"<hr />")}),(e=n).ui.registry.addButton("hr",{icon:"horizontal-rule",tooltip:"Horizontal line",onAction:o}),e.ui.registry.addMenuItem("hr",{icon:"horizontal-rule",text:"Horizontal line",onAction:o})})}();