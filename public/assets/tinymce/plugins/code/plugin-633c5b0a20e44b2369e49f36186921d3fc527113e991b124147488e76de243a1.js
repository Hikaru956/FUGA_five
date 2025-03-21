/**
 * Copyright (c) Tiny Technologies, Inc. All rights reserved.
 * Licensed under the LGPL or a commercial license.
 * For LGPL see License.txt in the project root for license information.
 * For commercial licenses see https://www.tiny.cloud/
 *
 * Version: 5.10.3 (2022-02-09)
 */
!function(){"use strict";tinymce.util.Tools.resolve("tinymce.PluginManager").add("code",function(e){function t(){return n.execCommand("mceCodeEditor")}var o,n;return(o=e).addCommand("mceCodeEditor",function(){var e,t;t=(e=o).getContent({source_view:!0}),e.windowManager.open({title:"Source Code",size:"large",body:{type:"panel",items:[{type:"textarea",name:"code"}]},buttons:[{type:"cancel",name:"cancel",text:"Cancel"},{type:"submit",name:"save",text:"Save",primary:!0}],initialData:{code:t},onSubmit:function(t){var o=e,n=t.getData().code;o.focus(),o.undoManager.transact(function(){o.setContent(n)}),o.selection.setCursorLocation(),o.nodeChanged(),t.close()}})}),(n=e).ui.registry.addButton("code",{icon:"sourcecode",tooltip:"Source code",onAction:t}),n.ui.registry.addMenuItem("code",{icon:"sourcecode",text:"Source code",onAction:t}),{}})}();