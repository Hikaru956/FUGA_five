/**
 * Copyright (c) Tiny Technologies, Inc. All rights reserved.
 * Licensed under the LGPL or a commercial license.
 * For LGPL see License.txt in the project root for license information.
 * For commercial licenses see https://www.tiny.cloud/
 *
 * Version: 5.10.3 (2022-02-09)
 */
!function(){"use strict";function e(e){var t=e;return{get:function(){return t},set:function(e){t=e}}}function t(e){return null!=e}function n(){}function r(e){return function(){return e}}function o(e){return e}function i(){return Q}function a(e){return n=typeof(t=e),"array"==(null===t?"null":"object"==n&&(Array.prototype.isPrototypeOf(t)||t.constructor&&"Array"===t.constructor.name)?"array":"object"==n&&(String.prototype.isPrototypeOf(t)||t.constructor&&"String"===t.constructor.name)?"string":n);var t,n}function u(e){return e()}function c(e,t){return oe(document.createElement("canvas"),e,t)}function s(e){var t=c(e.width,e.height);return re(t).drawImage(e,0,0),t}function f(e){return new ne(function(t,n){function r(){i.removeEventListener("load",a),i.removeEventListener("error",u)}var o=URL.createObjectURL(e),i=new Image,a=function(){r(),t(i)},u=function(){r(),n("Unable to load data of type "+e.type+": "+o)};i.addEventListener("load",a),i.addEventListener("error",u),i.src=o,i.complete&&setTimeout(a,0)})}function l(e,t,n){return t=t||"image/png",J(HTMLCanvasElement.prototype.toBlob)?new ne(function(r,o){e.toBlob(function(e){e?r(e):o()},t,n)}):ae(e.toDataURL(t,n))}function d(e,t){for(var n=0,r=e.length;n<r;n++)t(e[n],n)}function m(e,t){return function(e,t,n){for(var r=0,o=e.length;r<o;r++){var i=e[r];if(t(i,r))return Z.some(i);if(n(i,r))break}return Z.none()}(e,t,K)}function h(e,t,n){function o(t,n){return e.then(function(e){return e.toDataURL(t||"image/png",n)})}return{getType:r(t.type),toBlob:function(){return ne.resolve(t)},toDataURL:r(n),toBase64:function(){return n.split(",")[1]},toAdjustedBlob:function(t,n){return e.then(function(e){return l(e,t,n)})},toAdjustedDataURL:o,toAdjustedBase64:function(e,t){return o(e,t).then(function(e){return e.split(",")[1]})},toCanvas:function(){return e.then(s)}}}function g(e,t){return l(e,t).then(function(t){return h(ne.resolve(e),t,e.toDataURL())})}function p(e,t){void 0===t&&(t=2);var n=Math.pow(10,t),r=Math.round(e*n);return Math.ceil(r/n)}function v(e,t,n){return void 0===n&&(n=!1),new ne(function(r){var o=new XMLHttpRequest;o.onreadystatechange=function(){4===o.readyState&&r({status:o.status,blob:o.response})},o.open("GET",e,!0),o.withCredentials=n,function(e){for(var t,n=fe(e),r=0,i=n.length;r<i;r++){var a=n[r];t=e[a],o.setRequestHeader(a,t)}}(t),o.responseType="blob",o.send()})}function y(e){var t,n=(t=e,"ImageProxy HTTP error: "+m(me,function(e){return t===e.code}).fold(r("Unknown ImageProxy error"),function(e){return e.message}));return ne.reject(n)}function w(e){return m(he,function(t){return t.type===e}).fold(r("Unknown service error"),function(e){return e.message})}function b(e){return"ImageProxy Service error: "+function(e){try{return Z.some(JSON.parse(e))}catch(e){return Z.none()}}(e).bind(function(e){return n=function(e,n){return t(e)?e[n]:void 0},r=e,d(["error","type"],function(e){r=n(r,e)}),o=r,Z.from(o).map(w);var n,r,o}).getOr("Invalid JSON in service error message")}function _(e){return e<200||300<=e}function E(e,t){var n,r,o,i={"Content-Type":"application/json;charset=UTF-8","tiny-api-key":t};return v((r=t,o=-1===(n=e).indexOf("?")?"?":"&",/[?&]apiKey=/.test(n)?n:n+o+"apiKey="+encodeURIComponent(r)),i).then(function(e){return _(e.status)?(n=e.status,"application/json"!==(null==(r=e.blob)?void 0:r.type)||400!==n&&403!==n&&404!==n&&500!==n?y(n):(t=r,new ne(function(e,n){var r=new FileReader;r.onload=function(){e(r.result)},r.onerror=function(e){n(e)},r.readAsText(t)}).then(function(e){var t=b(e);return ne.reject(t)}))):ne.resolve(e.blob);var t,n,r})}function T(e,t,n){return void 0===n&&(n=!1),t?E(e,t):v(e,{},n).then(function(e){return _(e.status)?y(e.status):ne.resolve(e.blob)})}function x(e){return t=e,new ne(function(e){var n=new FileReader;n.onloadend=function(){e(n.result)},n.readAsDataURL(t)}).then(function(t){return h(f(e).then(function(e){ue(e);var t=c(e.naturalWidth||e.width,e.naturalHeight||e.height);return re(t).drawImage(e,0,0),t}),e,t)});var t}function I(e){if(null==e)throw new Error("Node cannot be null or undefined");return{dom:e}}function R(e){return e.getParam("imagetools_proxy")}function U(e){function t(e){return/^[0-9\.]+px$/.test(e)}var n=e.style.width,r=e.style.height;return n||r?t(n)&&t(r)?{w:parseInt(n,10),h:parseInt(r,10)}:null:(n=e.width,r=e.height,n&&r?{w:parseInt(n,10),h:parseInt(r,10)}:null)}function A(e){return{w:e.naturalWidth,h:e.naturalHeight}}function j(e){return t=ge.fromDom(e),n="img",r=function(e){return function(t){var n=e.dom;if(1!==n.nodeType)return!1;var r=n;if(void 0!==r.matches)return r.matches(t);if(void 0!==r.msMatchesSelector)return r.msMatchesSelector(t);if(void 0!==r.webkitMatchesSelector)return r.webkitMatchesSelector(t);if(void 0!==r.mozMatchesSelector)return r.mozMatchesSelector(t);throw new Error("Browser lacks native selectors")}(n)},m(t.dom.childNodes,function(e){return r(ge.fromDom(e))}).map(ge.fromDom);var t,n,r}function S(e,t){return e.dom.is(t,"figure")}function M(e,t){return e.dom.is(t,"img:not([data-mce-object],[data-mce-placeholder])")}function P(e,n){function r(n){return M(e,n)&&(be(e,n)||_e(e,n)||t(R(e)))}return S(e,n)?j(n).bind(function(e){return r(e.dom)?Z.some(e.dom):Z.none()}):r(n)?Z.some(n):Z.none()}function O(e,t){e.notificationManager.open({text:t,type:"error"})}function L(e){var t=e.selection.getNode(),n=e.dom.getParent(t,"figure.image");return null!==n&&S(e,n)?j(n):M(e,t)?Z.some(ge.fromDom(t)):Z.none()}function k(e,n,r){var o=n.match(/(?:\/|^)(([^\/\?]+)\.(?:[a-z0-9.]+))(?:\?|$)/i);return t(o)?e.dom.encode(o[r]):null}function C(e,t){if(_e(e,t))return T(t.src,null,(n=t,-1!==G.inArray(e.getParam("imagetools_credentials_hosts",[],"string[]"),new ye(n.src).host)));var n,r;if(be(e,t))return(0===(r=t.src).indexOf("data:")?ae:ie)(r);var o=R(e);return T(o+(-1===o.indexOf("?")?"?":"&")+"url="+encodeURIComponent(t.src),e.getParam("api_key",e.getParam("imagetools_api_key","","string"),"string"),!1)}function F(e,t){var n,r,o=e.editorUpload.blobCache.getByUri(t.src);return o?ve.resolve(o.blob()):(n=e,r=t,Z.from(n.getParam("imagetools_fetch_image",null,"function")).fold(function(){return C(n,r)},function(e){return e(r)}))}function B(e){pe.clearTimeout(e.get())}function N(e,n,r,o,i,a,u){return r.toBlob().then(function(c){var s,f,l,d=e.editorUpload.blobCache,m=a.src,h=n.type===c.type;return e.getParam("images_reuse_filename",!1,"boolean")&&(f=t(l=d.getByUri(m))?(m=l.uri(),s=l.name(),l.filename()):(s=k(e,m,2),k(e,m,1))),l=d.create({id:"imagetools"+we++,blob:c,base64:r.toBase64(),uri:m,name:s,filename:h?f:void 0}),d.add(l),e.undoManager.transact(function(){var t=function(){var n,r,u;e.$(a).off("load",t),e.nodeChanged(),o?e.editorUpload.uploadImagesAuto():(B(i),n=e,r=i,u=pe.setEditorTimeout(n,function(){n.editorUpload.uploadImagesAuto()},n.getParam("images_upload_timeout",3e4,"number")),r.set(u))};e.$(a).on("load",t),u&&e.$(a).attr({width:u.w,height:u.h}),e.$(a).attr({src:l.blobUri()}).removeAttr("data-mce-src")}),l})}function D(e,t,n,r){return function(){return L(e).fold(function(){O(e,"Could not find selected image")},function(o){return e._scanForImages().then(function(){return F(e,o.dom)}).then(function(i){return x(i).then(n).then(function(n){return N(e,i,n,!1,t,o.dom,r)})})["catch"](function(t){O(e,t)})})}}function H(e,t,n){return function(){var r=L(e).map(function(e){var t=U(e.dom);return t?{w:t.h,h:t.w}:null}).getOrNull();return D(e,t,function(e){return r=n,(t=e).toCanvas().then(function(e){return le(e,t.getType(),r)});var t,r},r)()}}function z(e,t,n){return function(){return D(e,t,function(e){return r=n,(t=e).toCanvas().then(function(e){return de(e,t.getType(),r)});var t,r})()}}function q(e,t){return function(){var r=L(e),o=r.map(function(e){return A(e.dom)});r.each(function(i){P(e,i.dom).each(function(){F(e,i.dom).then(function(i){var a={blob:i,url:URL.createObjectURL(i)};e.windowManager.open({title:"Edit Image",size:"large",body:{type:"panel",items:[{type:"imagetools",name:"imagetools",label:"Edit Image",currentState:a}]},buttons:[{type:"cancel",name:"cancel",text:"Cancel"},{type:"submit",name:"save",text:"Save",primary:!0,disabled:!0}],onSubmit:function(n){var i=n.getData().imagetools.blob;r.each(function(n){o.each(function(r){var o,a,u,c,s;o=e,a=t,u=n.dom,c=r,ce(s=i).then(function(e){var t,n,r,o,i=A(e);return c.w===i.w&&c.h===i.h||U(u)&&(t=u,(n=i)&&(r=t.style.width,o=t.style.height,(r||o)&&(t.style.width=n.w+"px",t.style.height=n.h+"px",t.removeAttribute("data-mce-style")),r=t.width,o=t.height,(r||o)&&(t.setAttribute("width",String(n.w)),t.setAttribute("height",String(n.h))))),URL.revokeObjectURL(e.src),s}).then(x).then(function(e){return N(o,s,e,!0,a,u)})})}),n.close()},onCancel:n,onAction:function(e,t){switch(t.name){case"save-state":t.value?e.enable("save"):e.disable("save");break;case"disable":e.disable("save"),e.disable("cancel");break;case"enable":e.enable("cancel")}}})})})})}}function W(e){function t(t){return function(){return e.execCommand(t)}}function n(){return L(e).exists(function(t){return P(e,t.dom).isSome()})}function r(e){function t(t){return e.setDisabled(!t)}return t(n()),o=o.concat([t]),function(){o=function(e){for(var n=[],r=0,o=e.length;r<o;r++){var i=e[r];i!==t&&n.push(i)}return n}(o)}}var o=[];e.on("NodeChange",function(){var e=n();d(o,function(t){return t(e)})}),e.ui.registry.addButton("rotateleft",{tooltip:"Rotate counterclockwise",icon:"rotate-left",onAction:t("mceImageRotateLeft"),onSetup:r}),e.ui.registry.addButton("rotateright",{tooltip:"Rotate clockwise",icon:"rotate-right",onAction:t("mceImageRotateRight"),onSetup:r}),e.ui.registry.addButton("flipv",{tooltip:"Flip vertically",icon:"flip-vertically",onAction:t("mceImageFlipVertical"),onSetup:r}),e.ui.registry.addButton("fliph",{tooltip:"Flip horizontally",icon:"flip-horizontally",onAction:t("mceImageFlipHorizontal"),onSetup:r}),e.ui.registry.addButton("editimage",{tooltip:"Edit image",icon:"edit-image",onAction:t("mceEditImage"),onSetup:r}),e.ui.registry.addButton("imageoptions",{tooltip:"Image options",icon:"image",onAction:t("mceImage")}),e.ui.registry.addContextMenu("imagetools",{update:function(n){return P(e,n).map(function(){return{text:"Edit image",icon:"edit-image",onAction:t("mceEditImage")}}).toArray()}})}var $,V=tinymce.util.Tools.resolve("tinymce.PluginManager"),G=tinymce.util.Tools.resolve("tinymce.util.Tools"),J=function(e){return typeof e===$},K=r(!($="function")),X=r(!0),Q={fold:function(e){return e()},isSome:K,isNone:X,getOr:o,getOrThunk:u,getOrDie:function(e){throw new Error(e||"error: getOrDie called on none.")},getOrNull:r(null),getOrUndefined:r(void 0),or:o,orThunk:u,map:i,each:n,bind:i,exists:K,forall:X,filter:function(){return Q},toArray:function(){return[]},toString:r("none()")},Y=function(e){function t(){return i}function n(t){return t(e)}var o=r(e),i={fold:function(t,n){return n(e)},isSome:X,isNone:K,getOr:o,getOrThunk:o,getOrDie:o,getOrNull:o,getOrUndefined:o,or:t,orThunk:t,map:function(t){return Y(t(e))},each:function(t){t(e)},bind:n,exists:n,forall:n,filter:function(t){return t(e)?i:Q},toArray:function(){return[e]},toString:function(){return"some("+e+")"}};return i},Z={some:Y,none:i,from:function(e){return null==e?Q:Y(e)}},ee={},te={exports:ee};!function(){var e=this,t=function(){function e(){}function t(e){if("object"!=typeof this)throw new TypeError("Promises must be constructed via new");if("function"!=typeof e)throw new TypeError("not a function");this._state=0,this._handled=!1,this._value=void 0,this._deferreds=[],u(e,this)}function n(e,n){for(;3===e._state;)e=e._value;0!==e._state?(e._handled=!0,t._immediateFn(function(){var t,i=1===e._state?n.onFulfilled:n.onRejected;if(null!==i){try{t=i(e._value)}catch(t){return void o(n.promise,t)}r(n.promise,t)}else(1===e._state?r:o)(n.promise,e._value)})):e._deferreds.push(n)}function r(e,n){try{if(n===e)throw new TypeError("A promise cannot be resolved with itself.");if(n&&("object"==typeof n||"function"==typeof n)){var r=n.then;if(n instanceof t)return e._state=3,e._value=n,void i(e);if("function"==typeof r)return void u((a=r,c=n,function(){a.apply(c,arguments)}),e)}e._state=1,e._value=n,i(e)}catch(n){o(e,n)}var a,c}function o(e,t){e._state=2,e._value=t,i(e)}function i(e){2===e._state&&0===e._deferreds.length&&t._immediateFn(function(){e._handled||t._unhandledRejectionFn(e._value)});for(var r=0,o=e._deferreds.length;r<o;r++)n(e,e._deferreds[r]);e._deferreds=null}function a(e,t,n){this.onFulfilled="function"==typeof e?e:null,this.onRejected="function"==typeof t?t:null,this.promise=n}function u(e,t){var n=!1;try{e(function(e){n||(n=!0,r(t,e))},function(e){n||(n=!0,o(t,e))})}catch(e){if(n)return;n=!0,o(t,e)}}var c,s,f,l={exports:{}};c=l,s="undefined"!=typeof globalThis?globalThis:"undefined"!=typeof window?window:"undefined"!=typeof global?global:"undefined"!=typeof self?self:{},f=setTimeout,t.prototype["catch"]=function(e){return this.then(null,e)},t.prototype.then=function(t,r){var o=new this.constructor(e);return n(this,new a(t,r,o)),o},t.all=function(e){var n=Array.prototype.slice.call(e);return new t(function(e,t){if(0===n.length)return e([]);for(var r=n.length,o=0;o<n.length;o++)!function i(o,a){try{if(a&&("object"==typeof a||"function"==typeof a)){var u=a.then;if("function"==typeof u)return u.call(a,function(e){i(o,e)},t),0}n[o]=a,0==--r&&e(n)}catch(a){t(a)}}(o,n[o])})},t.resolve=function(e){return e&&"object"==typeof e&&e.constructor===t?e:new t(function(t){t(e)})},t.reject=function(e){return new t(function(t,n){n(e)})},t.race=function(e){return new t(function(t,n){for(var r=0,o=e.length;r<o;r++)e[r].then(t,n)})},t._immediateFn="function"==typeof setImmediate?function(e){setImmediate(e)}:function(e){f(e,0)},t._unhandledRejectionFn=function(e){"undefined"!=typeof console&&console&&console.warn("Possible Unhandled Promise Rejection:",e)},t._setImmediateFn=function(e){t._immediateFn=e},t._setUnhandledRejectionFn=function(e){t._unhandledRejectionFn=e},c.exports?c.exports=t:s.Promise||(s.Promise=t);var d=l.exports;return{boltExport:("undefined"!=typeof window?window:Function("return this;")()).Promise||d}};"object"==typeof ee&&void 0!==te?te.exports=t():(e="undefined"!=typeof globalThis?globalThis:e||self).EphoxContactWrapper=t()}();var ne=te.exports.boltExport,re=function(e){return e.getContext("2d")},oe=function(e,t,n){return e.width=t,e.height=n,e},ie=function(e){return new ne(function(t,n){var r=new XMLHttpRequest;r.open("GET",e,!0),r.responseType="blob",r.onload=function(){200===this.status&&t(this.response)},r.onerror=function(){var e;n(0===this.status?((e=new Error("No access to download image")).code=18,e.name="SecurityError",e):new Error("Error "+this.status+" downloading image"))},r.send()})},ae=function(e){return new ne(function(t,n){(function(){var t=e.split(","),n=/data:([^;]+)/.exec(t[0]);if(!n)return Z.none();for(var r=n[1],o=t[1],i=atob(o),a=i.length,u=Math.ceil(a/1024),c=new Array(u),s=0;s<u;++s){for(var f=1024*s,l=Math.min(1024+f,a),d=new Array(l-f),m=f,h=0;m<l;++h,++m)d[h]=i[m].charCodeAt(0);c[s]=new Uint8Array(d)}return Z.some(new Blob(c,{type:r}))})().fold(function(){n("uri is not base64: "+e)},t)})},ue=function(e){URL.revokeObjectURL(e.src)},ce=f,se=Array.prototype.indexOf,fe=Object.keys;!function(e){if(!a(e))throw new Error("cases must be an array");if(0===e.length)throw new Error("there must be at least one case");var t=[],n={};d(e,function(r,o){var i=fe(r);if(1!==i.length)throw new Error("one and only one name per case");var u=i[0],c=r[u];if(void 0!==n[u])throw new Error("duplicate key detected:"+u);if("cata"===u)throw new Error("cannot have a case named cata (sorry)");if(!a(c))throw new Error("case arguments must be an array");t.push(u),n[u]=function(){for(var n=[],r=0;r<arguments.length;r++)n[r]=arguments[r];var i=n.length;if(i!==c.length)throw new Error("Wrong number of arguments to case "+u+". Expected "+c.length+" ("+c+"), got "+i);return{fold:function(){for(var t=[],r=0;r<arguments.length;r++)t[r]=arguments[r];if(t.length!==e.length)throw new Error("Wrong number of arguments to fold. Expected "+e.length+", got "+t.length);return t[o].apply(null,n)},match:function(e){var r=fe(e);if(t.length!==r.length)throw new Error("Wrong number of arguments to match. Expected: "+t.join(",")+"\nActual: "+r.join(","));if(!function(e){for(var t,n=0,o=e.length;n<o;++n)if(!0!==(t=e[n],function(e,t){return-1<se.call(e,t)}(r,t)))return;return 1}(t))throw new Error("Not all branches were specified when using match. Specified: "+r.join(", ")+"\nRequired: "+t.join(", "));return e[u].apply(null,n)},log:function(e){console.log(e,{constructors:t,constructor:u,params:n})}}}})}([{bothErrors:["error1","error2"]},{firstError:["error1","value2"]},{secondError:["value1","error2"]},{bothValues:["value1","value2"]}]);var le=function(e,t,n){var r=(n<0?360+n:n)*Math.PI/180,o=e.width,i=e.height,a=Math.sin(r),u=Math.cos(r),s=p(Math.abs(o*u)+Math.abs(i*a)),f=p(Math.abs(o*a)+Math.abs(i*u)),l=c(s,f),d=re(l);return d.translate(s/2,f/2),d.rotate(r),d.drawImage(e,-o/2,-i/2),g(l,t)},de=function(e,t,n){var r=c(e.width,e.height),o=re(r);return"v"===n?(o.scale(1,-1),o.drawImage(e,0,-r.height)):(o.scale(-1,1),o.drawImage(e,-r.width,0)),g(r,t)},me=[{code:404,message:"Could not find Image Proxy"},{code:403,message:"Rejected request"},{code:0,message:"Incorrect Image Proxy URL"}],he=[{type:"not_found",message:"Failed to load image."},{type:"key_missing",message:"The request did not include an api key."},{type:"key_not_found",message:"The provided api key could not be found."},{type:"domain_not_trusted",message:"The api key is not valid for the request origins."}],ge={fromHtml:function(e,t){var n=(t||document).createElement("div");if(n.innerHTML=e,!n.hasChildNodes()||1<n.childNodes.length)throw console.error("HTML does not have a single root node",e),new Error("HTML must have a single root node");return I(n.childNodes[0])},fromTag:function(e,t){return I((t||document).createElement(e))},fromText:function(e,t){return I((t||document).createTextNode(e))},fromDom:I,fromPoint:function(e,t,n){return Z.from(e.dom.elementFromPoint(t,n)).map(I)}};"undefined"!=typeof window||Function("return this;")();var pe=tinymce.util.Tools.resolve("tinymce.util.Delay"),ve=tinymce.util.Tools.resolve("tinymce.util.Promise"),ye=tinymce.util.Tools.resolve("tinymce.util.URI"),we=0,be=function(e,t){var n=t.src;return 0===n.indexOf("data:")||0===n.indexOf("blob:")||new ye(n).host===e.documentBaseURI.host},_e=function(e,t){return-1!==G.inArray(e.getParam("imagetools_cors_hosts",[],"string[]"),new ye(t.src).host)};V.add("imagetools",function(t){var n,r,o,i,a=e(0),u=e(null),c=t;G.each({mceImageRotateLeft:H(c,a,-90),mceImageRotateRight:H(c,a,90),mceImageFlipVertical:z(c,a,"v"),mceImageFlipHorizontal:z(c,a,"h"),mceEditImage:q(c,a)},function(e,t){c.addCommand(t,e)}),W(t),(n=t).ui.registry.addContextToolbar("imagetools",{items:n.getParam("imagetools_toolbar","rotateleft rotateright flipv fliph editimage imageoptions"),predicate:function(e){return P(n,e).isSome()},position:"node",scope:"node"}),o=a,i=u,(r=t).on("NodeChange",function(e){var t=i.get(),n=P(r,e.element);t&&!n.exists(function(e){return t.src===e.src})&&(B(o),r.editorUpload.uploadImagesAuto(),i.set(null)),n.each(i.set)})})}();