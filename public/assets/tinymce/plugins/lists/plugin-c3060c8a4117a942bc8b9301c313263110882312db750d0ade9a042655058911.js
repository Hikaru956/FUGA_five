/**
 * Copyright (c) Tiny Technologies, Inc. All rights reserved.
 * Licensed under the LGPL or a commercial license.
 * For LGPL see License.txt in the project root for license information.
 * For commercial licenses see https://www.tiny.cloud/
 *
 * Version: 5.10.3 (2022-02-09)
 */
!function(){"use strict";function e(e){return function(t){return r=typeof(n=t),(null===n?"null":"object"==r&&(Array.prototype.isPrototypeOf(n)||n.constructor&&"Array"===n.constructor.name)?"array":"object"==r&&(String.prototype.isPrototypeOf(n)||n.constructor&&"String"===n.constructor.name)?"string":r)===e;var n,r}}function t(e){return function(t){return typeof t===e}}function n(){}function r(e){return function(){return e}}function o(e){return e}function i(e,t){return e===t}function a(e){return function(t){return!e(t)}}function s(){return st}function u(e){return e()}function c(e,t){for(var n=e.length,r=new Array(n),o=0;o<n;o++){var i=e[o];r[o]=t(i,o)}return r}function f(e,t){for(var n=0,r=e.length;n<r;n++)t(e[n],n)}function d(e,t){for(var n=[],r=0,o=e.length;r<o;r++){var i=e[r];t(i,r)&&n.push(i)}return n}function l(e,t,n){return f(e,function(e,r){n=t(n,e,r)}),n}function m(e,t,n){for(var r=0,o=e.length;r<o;r++){var i=e[r];if(t(i,r))return ct.some(i);if(n(i,r))break}return ct.none()}function p(e,t){return m(e,t,it)}function g(e,t){return function(e){for(var t=[],n=0,r=e.length;n<r;++n){if(!tt(e[n]))throw new Error("Arr.flatten item "+n+" was not an array, input: "+e);dt.apply(t,e[n])}return t}(c(e,t))}function h(e){var t=ft.call(e,0);return t.reverse(),t}function v(e,t){return 0<=t&&t<e.length?ct.some(e[t]):ct.none()}function y(e){return v(e,0)}function S(e){return v(e,e.length-1)}function C(e,t){return function(t){for(var n=0;n<t.length;n++){var r=function(t){var n=t.brand.toLowerCase();return p(e,function(e){var t;return n===(null===(t=e.brand)||void 0===t?void 0:t.toLowerCase())}).map(function(e){return{current:e.name,version:pt.nu(parseInt(t.version,10),0)}})}(t[n]);if(r.isSome())return r}return ct.none()}(t.brands)}function b(e,t){var n=String(t).toLowerCase();return p(e,function(e){return e.search(n)})}function N(e,t){return-1!==e.indexOf(t)}function O(e){return function(t){return N(t,e)}}function L(e){return window.matchMedia(e).matches}function T(e,t){return e.dom===t.dom}function D(e,t){return At().browser.isIE()?(n=e.dom,r=t.dom,o=Node.DOCUMENT_POSITION_CONTAINED_BY,0!=(n.compareDocumentPosition(r)&o)):(i=e.dom)!==(a=t.dom)&&i.contains(a);var n,r,o,i,a}function x(e,t){for(var n=Bt(e),r=0,o=n.length;r<o;r++){var i=n[r];t(e[i],i)}}function A(){return mt(0,0)}function w(e){function t(e){return function(){return n===e}}var n=e.current,r=e.version;return{current:n,version:r,isEdge:t("Edge"),isChrome:t("Chrome"),isIE:t("IE"),isOpera:t("Opera"),isFirefox:t(yt),isSafari:t("Safari")}}function k(e){function t(e){return function(){return n===e}}var n=e.current,r=e.version;return{current:n,version:r,isWindows:t(bt),isiOS:t("iOS"),isAndroid:t(Nt),isOSX:t("OSX"),isLinux:t("Linux"),isSolaris:t(Ot),isFreeBSD:t(Lt),isChromeOS:t(Tt)}}function E(e){if(null==e)throw new Error("Node cannot be null or undefined");return{dom:e}}function I(e){return e.dom.nodeName.toLowerCase()}function P(e){return function(t){return Xe(t)&&I(t)===e}}function B(e,t){var n=e.dom;x(t,function(e,t){!function(e,t,n){if(!(Je(n)||nt(n)||ot(n)))throw console.error("Invalid call to Attribute.set. Key ",t,":: Value ",n,":: Element ",e),new Error("Attribute value was not simple");e.setAttribute(t,n+"")}(n,t,e)})}function R(e){return l(e.dom.attributes,function(e,t){return e[t.name]=t.value,e},{})}function M(e){return ct.from(e.dom.parentNode).map(wt.fromDom)}function U(e){return c(e.dom.childNodes,wt.fromDom)}function _(e,t){var n=e.dom.childNodes;return ct.from(n[t]).map(wt.fromDom)}function $(e){return _(e,0)}function F(e){return _(e,e.dom.childNodes.length-1)}function H(e,t){M(e).each(function(n){n.dom.insertBefore(t.dom,e.dom)})}function j(e,t){e.dom.appendChild(t.dom)}function K(e,t){f(t,function(t){j(e,t)})}function V(e){var t=e.dom;null!==t.parentNode&&t.parentNode.removeChild(t)}function W(e){return wt.fromDom(e.dom.cloneNode(!0))}function Q(e,t){var n,r,o=(n=e,B(r=wt.fromTag(t),R(n)),r);return H(e,o),K(o,U(e)),V(e),o}function X(e){return function(t){return t&&t.nodeName.toLowerCase()===e}}function q(e){return function(t){return t&&e.test(t.nodeName)}}function z(e){return e&&3===e.nodeType}function Y(e,t){return t&&e.schema.getTextBlockElements()[t.nodeName]}function Z(e,t){return e&&e.nodeName in t}function G(e,t,n){var r=e.isEmpty(t);return!(n&&0<e.select("span[data-mce-type=bookmark]",t).length)&&r}function J(e,t){return e.isChildOf(t,e.getRoot())}function ee(e,t){var n,r,o,i,a=e.dom,s=e.schema.getBlockElements(),u=a.createFragment(),c=!1===(n=e.getParam("forced_root_block","p"))?"":!0===n?"p":n;if(c&&((o=a.create(c)).tagName===c.toUpperCase()&&a.setAttribs(o,e.getParam("forced_root_block_attrs",{})),Z(t.firstChild,s)||u.appendChild(o)),t)for(;r=t.firstChild;){var f=r.nodeName;i||"SPAN"===f&&"bookmark"===r.getAttribute("data-mce-type")||(i=!0),Z(r,s)?(u.appendChild(r),o=null):c?(o||(o=a.create(c),u.appendChild(o)),o.appendChild(r)):u.appendChild(r)}return c?i||o.appendChild(a.create("br",{"data-mce-bogus":"1"})):u.appendChild(a.create("br")),u}function te(e){Qt(e)&&Q(e,"dd")}function ne(e,t,n){f(n,"Indent"===t?te:function(t){return n=e,Wt(r=t)?Q(r,"dt"):Qt(r)&&M(r).each(function(e){return function(e,t,n){var r=Vt.select('span[data-mce-type="bookmark"]',t),o=ee(e,n),i=Vt.createRng();i.setStartAfter(n),i.setEndAfter(t);for(var a,s=i.extractContents(),u=s.firstChild;u;u=u.firstChild)if("LI"===u.nodeName&&e.dom.isEmpty(u)){Vt.remove(u);break}e.dom.isEmpty(s)||Vt.insertAfter(s,t),Vt.insertAfter(o,t),G(e.dom,n.parentNode)&&(a=n.parentNode,Mt.each(r,function(e){a.parentNode.insertBefore(e,n.parentNode)}),Vt.remove(a)),Vt.remove(n),G(e.dom,t)&&Vt.remove(t)}(n,e.dom,r.dom)}),0;var n,r})}function re(e,t){if(z(e))return{container:e,offset:t};var n=Et.getNode(e,t);return z(n)?{container:n,offset:t>=e.childNodes.length?n.data.length:0}:n.previousSibling&&z(n.previousSibling)?{container:n.previousSibling,offset:n.previousSibling.data.length}:n.nextSibling&&z(n.nextSibling)?{container:n.nextSibling,offset:0}:{container:e,offset:t}}function oe(e){var t=e.cloneRange(),n=re(e.startContainer,e.startOffset);t.setStart(n.container,n.offset);var r=re(e.endContainer,e.endOffset);return t.setEnd(r.container,r.offset),t}function ie(e,t){var n=t||e.selection.getStart(!0);return e.dom.getParent(n,"OL,UL,DL",qt(e,n))}function ae(e){var t,n,r=e.selection.getSelectedBlocks();return d((t=e,n=Mt.map(r,function(e){return t.dom.getParent(e,"li,dd,dt",qt(t,e))||e}),Xt.unique(n)),Ft)}function se(e,t){return S(e.dom.getParents(t,"ol,ul",qt(e,t)))}function ue(e,t,n){return void 0===n&&(n=i),e.exists(function(e){return n(e,t)})}function ce(e,t,n){return e.isSome()&&t.isSome()?ct.some(n(e.getOrDie(),t.getOrDie())):ct.none()}function fe(e,t,n){return e.fire("ListMutation",{action:t,element:n})}function de(e,t){j(e.item,t.list)}function le(e,t){for(var n=0;n<e.length-1;n++)!function(e,t,n){if(!Je(n))throw console.error("Invalid call to CSS.set. Property ",t,":: Value ",n,":: Element ",e),new Error("CSS value must be a string: "+n);void 0!==e.style&&rt(e.style.getPropertyValue)&&e.style.setProperty(t,n)}(e[n].item.dom,"list-style-type","none");S(e).each(function(e){B(e.list,t.listAttributes),B(e.item,t.itemAttributes),K(e.item,t.content)})}function me(e,t,n){var r=t.slice(0,n.depth);return S(r).each(function(t){var r,o,i,a,s,u,c=(r=n.itemAttributes,o=n.content,B(i=wt.fromTag("li",e),r),K(i,o),i);j((a=t).list,c),a.item=c,u=n,I((s=t).list)!==u.listType&&(s.list=Q(s.list,u.listType)),B(s.list,u.listAttributes)}),r}function pe(e,t,n){var r,o=function(e,t,n){for(var r,o,i,a=[],s=0;s<n;s++)a.push((o=t.listType,j((i={list:wt.fromTag(o,r=e),item:wt.fromTag("li",r)}).list,i.item),i));return a}(e,n,n.depth-t.length);return function(e){for(var t=1;t<e.length;t++)de(e[t-1],e[t])}(o),le(o,n),r=o,ce(S(t),y(r),de),t.concat(o)}function ge(e){return kt(e,"OL,UL")}function he(e){return $(e).exists(ge)}function ve(e){return 0<e.depth}function ye(e){return e.isSelected}function Se(e){return f(e,function(t,r){function o(e){return e.depth===u&&!e.dirty}function i(e){return e.depth<u}var a,s,u;u=(a=e)[s=r].depth,m(h(a.slice(0,s)),o,i).orThunk(function(){return m(a.slice(s+1),o,i)}).fold(function(){var e,r,o,i,a,s;t.dirty&&(t.listAttributes=(e=t.listAttributes,o=function(e,t){return"start"!==t},i=r={},a=function(e,t){i[t]=e},s=n,x(e,function(e,t){(o(e,t)?a:s)(e,t)}),r))},function(e){var n=e;t.listType=n.listType,t.listAttributes=lt({},n.listAttributes)})}),e}function Ce(e,t,n,r){return $(r).filter(ge).fold(function(){t.each(function(e){T(e.start,r)&&n.set(!0)});var o,i,a,s=(o=r,i=e,a=n.get(),M(o).filter(Xe).map(function(e){return{depth:i,dirty:!1,isSelected:a,content:(n=U(t=o),c(F(t).exists(ge)?n.slice(0,-1):n,W)),itemAttributes:R(o),listAttributes:R(e),listType:I(e)};var t,n}));t.each(function(e){T(e.end,r)&&n.set(!1)});var u=F(r).filter(ge).map(function(r){return Yt(e,t,n,r)}).getOr([]);return s.toArray().concat(u)},function(r){return Yt(e,t,n,r)})}function be(e,t){return c(Se(t),function(t){var n,r,o=(n=t.content,r=document.createDocumentFragment(),f(n,function(e){r.appendChild(e.dom)}),wt.fromDom(r));return wt.fromDom(ee(e,o.dom))})}function Ne(e,t){var n=Se(t),r=e.contentDocument;return y(l(n,function(e,t){return(t.depth>e.length?pe:me)(r,e,t)},[])).map(function(e){return e.list}).toArray()}function Oe(e,t){f(d(e,ye),function(e){return function(e){switch(t){case"Indent":e.depth++;break;case"Outdent":e.depth--;break;case"Flatten":e.depth=0}e.dirty=!0}(e),0})}function Le(e,t){var n,r,o,i,s,u,l,m,v,S,C,b,N,O=c((i=se(o=r=e,o.selection.getStart()),s=d(o.selection.getSelectedBlocks(),_t),u=i.toArray().concat(s),zt(r,u)),wt.fromDom),L=c(d(ae(e),Ht),wt.fromDom),T=!1;return(O.length||L.length)&&(n=e.selection.getBookmark(),m=t,f((v=O,N=c(ae(l=e),wt.fromDom),S=ce(p(N,a(he)),p(h(N),a(he)),function(e,t){return{start:e,end:t}}),C=!1,b={get:function(){return C},set:function(e){C=e}},c(v,function(e){return{sourceList:e,entries:Yt(0,S,b,e)}})),function(e){Oe(e.entries,m);var t,n,r=(t=l,g(function(e,t){if(0===e.length)return[];for(var n=t(e[0]),r=[],o=[],i=0,a=e.length;i<a;i++){var s=e[i],u=t(s);u!==n&&(r.push(o),o=[]),n=u,o.push(s)}return 0!==o.length&&r.push(o),r}(e.entries,ve),function(e){return(y(e).exists(ve)?Ne:be)(t,e)}));f(r,function(e){fe(l,"Indent"===m?"IndentList":"OutdentList",e.dom)}),n=e.sourceList,f(r,function(e){H(n,e)}),V(e.sourceList)}),ne(e,t,L),e.selection.moveToBookmark(n),e.selection.setRng(oe(e.selection.getRng())),e.nodeChanged(),T=!0),T}function Te(e){return Le(e,"Indent")}function De(e){return Le(e,"Outdent")}function xe(e){return Le(e,"Flatten")}function Ae(e){function t(t){var r,o=e[t?"startContainer":"endContainer"],i=e[t?"startOffset":"endOffset"];1===o.nodeType&&(r=Gt.create("span",{"data-mce-type":"bookmark"}),o.hasChildNodes()?(i=Math.min(i,o.childNodes.length-1),t?o.insertBefore(r,o.childNodes[i]):Gt.insertAfter(r,o.childNodes[i])):o.appendChild(r),o=r,i=0),n[t?"startContainer":"endContainer"]=o,n[t?"startOffset":"endOffset"]=i}var n={};return t(!0),e.collapsed||t(),n}function we(e){function t(t){var n,r=n=e[t?"startContainer":"endContainer"],o=e[t?"startOffset":"endOffset"];r&&(1===r.nodeType&&(o=function(e){for(var t=e.parentNode.firstChild,n=0;t;){if(t===e)return n;1===t.nodeType&&"bookmark"===t.getAttribute("data-mce-type")||n++,t=t.nextSibling}return-1}(r),r=r.parentNode,Gt.remove(n),!r.hasChildNodes()&&Gt.isBlock(r)&&r.appendChild(Gt.create("br"))),e[t?"startContainer":"endContainer"]=r,e[t?"startOffset":"endOffset"]=o)}t(!0),t();var n=Gt.createRng();return n.setStart(e.startContainer,e.startOffset),e.endContainer&&n.setEnd(e.endContainer,e.endOffset),oe(n)}function ke(e){switch(e){case"UL":return"ToggleUlList";case"OL":return"ToggleOlList";case"DL":return"ToggleDLList"}}function Ee(e){return/\btox\-/.test(e.className)}function Ie(e,t,n){function r(e){var r=m(e.parents,Ut,jt).filter(function(e){return e.nodeName===t&&!Ee(e)}).isSome();n(r)}return r({parents:e.dom.getParents(e.selection.getNode())}),e.on("NodeChange",r),function(){return e.off("NodeChange",r)}}function Pe(e,t){Mt.each(t,function(t,n){e.setAttribute(n,t)})}function Be(e,t,n){var r,o,i,a=n["list-style-type"]||null;e.setStyle(t,"list-style-type",a),r=e,Pe(o=t,(i=n)["list-attributes"]),Mt.each(r.select("li",o),function(e){Pe(e,i["list-item-attributes"])})}function Re(e,t,n,r){var o=t[n?"startContainer":"endContainer"],i=t[n?"startOffset":"endOffset"];for(1===o.nodeType&&(o=o.childNodes[Math.min(i,o.childNodes.length-1)]||o),!n&&Kt(o.nextSibling)&&(o=o.nextSibling);o.parentNode!==r;){if(Y(e,o))return o;if(/^(TD|TH)$/.test(o.parentNode.nodeName))return o;o=o.parentNode}return o}function Me(e,t,n){var r,o,i=e.selection.getRng(),a="LI",s=qt(e,e.selection.getStart(!0)),u=e.dom;"false"!==u.getContentEditable(e.selection.getNode())&&("DL"===(t=t.toUpperCase())&&(a="DT"),r=Ae(i),o=function(e,t,n){for(var r,o=[],i=e.dom,a=Re(e,t,!0,n),s=Re(e,t,!1,n),u=[],c=a;c&&(u.push(c),c!==s);c=c.nextSibling);return Mt.each(u,function(t){if(Y(e,t))return o.push(t),void(r=null);if(i.isBlock(t)||Kt(t))return Kt(t)&&i.remove(t),void(r=null);var a=t.nextSibling;Zt.isBookmarkNode(t)&&(Ut(a)||Y(e,a)||!a&&t.parentNode===n)?r=null:(r||(r=i.create("p"),t.parentNode.insertBefore(r,t),o.push(r)),r.appendChild(t))}),o}(e,i,s),Mt.each(o,function(r){var o,i,s,c,f,d=r.previousSibling,l=r.parentNode;Ft(l)||(d&&Ut(d)&&d.nodeName===t&&(c=n,u.getStyle(d,"list-style-type")===(f=null===(f=c?c["list-style-type"]:"")?"":f))?(o=d,r=u.rename(r,a),d.appendChild(r)):(o=u.create(t),r.parentNode.insertBefore(o,r),o.appendChild(r),r=u.rename(r,a)),i=u,s=r,Mt.each(["margin","margin-right","margin-bottom","margin-left","margin-top","padding","padding-right","padding-bottom","padding-left","padding-top"],function(e){var t;return i.setStyle(s,((t={})[e]="",t))}),Be(u,o,n),Jt(e.dom,o))}),e.selection.setRng(we(r)))}function Ue(e,t,n){return a=n,(i=t)&&a&&Ut(i)&&i.nodeName===a.nodeName&&(o=n,(r=e).getStyle(t,"list-style-type",!0)===r.getStyle(o,"list-style-type",!0))&&t.className===n.className;var r,o,i,a}function _e(e,t,n){var r,o,i,a,s,u,c,f,l,m,p,g,h,v,y,S,C,b=ie(e),N=(f=ie(c=e),l=c.selection.getSelectedBlocks(),f&&1===l.length&&l[0]===f?d(f.querySelectorAll("ol,ul,dl"),Ut):d(l,function(e){return Ut(e)&&f!==e})),O=et(n)?n:{};0<N.length?(m=e,g=N,h=t,v=O,(C=Ut(p=b))&&p.nodeName===h&&!en(v)?xe(m):(Me(m,h,v),y=Ae(m.selection.getRng()),S=C?function(e,t){for(var n,r=0,o=t.length;r<o;r++)!n&&r in t||((n=n||Array.prototype.slice.call(t,0,r))[r]=t[r]);return e.concat(n||Array.prototype.slice.call(t))}([p],g):g,Mt.each(S,function(e){var t,n,r=m,o=h,i=v;(t=e).nodeName!==o?(n=r.dom.rename(t,o),Be(r.dom,n,i),fe(r,ke(o),n)):(Be(r.dom,t,i),fe(r,ke(o),t))}),m.selection.setRng(we(y)))):(i=t,a=O,(o=b)!==(r=e).getBody()&&(o?o.nodeName!==i||en(a)||Ee(o)?(s=Ae(r.selection.getRng()),Be(r.dom,o,a),u=r.dom.rename(o,i),Jt(r.dom,u),r.selection.setRng(we(s)),Me(r,i,a),fe(r,ke(i),u)):xe(r):(Me(r,i,a),fe(r,ke(i),o))))}function $e(e,t,n,r){var o=t.startContainer,i=t.startOffset;if(z(o)&&(n?i<o.data.length:0<i))return o;var a=e.schema.getNonEmptyElements();1===o.nodeType&&(o=Et.getNode(o,i));var s,u,c=new It(o,r);for(n&&(s=e.dom,Kt(u=o)&&s.isBlock(u.nextSibling)&&!Kt(u.previousSibling)&&c.next());o=c[n?"next":"prev2"]();){if("LI"===o.nodeName&&!o.hasChildNodes())return o;if(a[o.nodeName])return o;if(z(o)&&0<o.data.length)return o}}function Fe(e,t){var n=t.childNodes;return 1===n.length&&!Ut(n[0])&&e.isBlock(n[0])}function He(e,t,n){var r,o,i,a=t.parentNode;J(e,t)&&J(e,n)&&(Ut(n.lastChild)&&(r=n.lastChild),a===n.lastChild&&Kt(a.previousSibling)&&e.remove(a.previousSibling),(o=n.lastChild)&&Kt(o)&&t.hasChildNodes()&&e.remove(o),G(e,n,!0)&&e.$(n).empty(),function(e,t,n){var r,o,i,a=Fe(e,n)?n.firstChild:n;if(Fe(o=e,i=t)&&o.remove(i.firstChild,!0),!G(e,t,!0))for(;r=t.firstChild;)a.appendChild(r)}(e,t,n),r&&n.appendChild(r),i=D(wt.fromDom(n),wt.fromDom(t))?e.getParents(t,Ut,n):[],e.remove(t),f(i,function(t){G(e,t)&&t!==e.getRoot()&&e.remove(t)}))}function je(e,t){var n=e.dom,r=e.selection,o=r.getStart(),i=qt(e,o),a=n.getParent(r.getStart(),"LI",i);if(a){var s=a.parentNode;if(s===e.getBody()&&G(n,s))return 1;var u=oe(r.getRng()),c=n.getParent($e(e,u,t,i),"LI",i);if(c&&c!==a)return e.undoManager.transact(function(){var n,r,o,i,s,f,d,l,m;t?(r=u,o=c,i=a,(m=(n=e).dom).isEmpty(i)?(d=o,(f=n).dom.$(l=i).empty(),He(f.dom,d,l),f.selection.setCursorLocation(l,0)):(s=Ae(r),He(m,o,i),n.selection.setRng(we(s)))):a.parentNode.firstChild===a?De(e):function(e,t,n){var r=Ae(u);He(e.dom,t,n);var o=we(r);e.selection.setRng(o)}(e,a,c)}),1;if(!c&&!t&&0===u.startOffset&&0===u.endOffset)return e.undoManager.transact(function(){xe(e)}),1}}function Ke(e,t){return e.selection.isCollapsed()?je(i=e,a=t)||function(e,t){var n=e.dom,r=e.selection.getStart(),o=qt(e,r),i=n.getParent(r,n.isBlock,o);if(i&&n.isEmpty(i)){var a=oe(e.selection.getRng()),s=n.getParent($e(e,a,t,o),"LI",o);if(s)return e.undoManager.transact(function(){var r,a=i,u=(r=n).getParent(a.parentNode,r.isBlock,o);r.remove(a),u&&r.isEmpty(u)&&r.remove(u),Jt(n,s.parentNode),e.selection.select(s,!0),e.selection.collapse(t)}),1}}(i,a):(r=(n=e).selection.getStart(),o=qt(n,r),(n.dom.getParent(r,"LI,DT,DD",o)||0<ae(n).length)&&(n.undoManager.transact(function(){var e,t,r;n.execCommand("Delete"),e=n.dom,t=n.getBody(),r=Mt.grep(e.select("ol,ul",t)),Mt.each(r,function(t){var n,r,o,i=e;"LI"===(o=(n=t).parentNode).nodeName&&o.firstChild===n&&((r=o.previousSibling)&&"LI"===r.nodeName?(r.appendChild(n),G(i,o)&&tn.remove(o)):tn.setStyle(o,"listStyleType","none")),Ut(o)&&(r=o.previousSibling)&&"LI"===r.nodeName&&r.appendChild(n)})}),1));var n,r,o,i,a}function Ve(e){return l(c(h(gt(e).split("")),function(e,t){var n=e.toUpperCase().charCodeAt(0)-"A".charCodeAt(0)+1;return Math.pow(26,t)*n}),function(e,t){return e+t},0)}function We(e,t){return function(){var n=ie(e);return n&&n.nodeName===t}}function Qe(e){e.addCommand("mceListProps",function(){var t,n,r,o;o=ie(t=e),$t(o)&&t.windowManager.open({title:"List Properties",body:{type:"panel",items:[{type:"input",name:"start",label:"Start list at number",inputMode:"numeric"}]},initialData:{start:(n={start:t.dom.getAttrib(o,"start","1"),listStyleType:ct.some(t.dom.getStyle(o,"list-style-type"))},r=parseInt(n.start,10),ue(n.listStyleType,"upper-alpha")?nn(r):ue(n.listStyleType,"lower-alpha")?nn(r).toLowerCase():n.start)},buttons:[{type:"cancel",name:"cancel",text:"Cancel"},{type:"submit",name:"save",text:"Save",primary:!0}],onSubmit:function(e){(function(e){switch(/^[0-9]+$/.test(t=e)?2:/^[A-Z]+$/.test(t)?0:/^[a-z]+$/.test(t)?1:0<t.length?4:3){case 2:return ct.some({listStyleType:ct.none(),start:e});case 0:return ct.some({listStyleType:ct.some("upper-alpha"),start:Ve(e).toString()});case 1:return ct.some({listStyleType:ct.some("lower-alpha"),start:Ve(e).toString()});case 3:return ct.some({listStyleType:ct.none(),start:""});case 4:return ct.none()}var t})(e.getData().start).each(function(e){t.execCommand("mceListUpdate",!1,{attrs:{start:"1"===e.start?"":e.start},styles:{"list-style-type":e.listStyleType.getOr("")}})}),e.close()}})})}function Xe(e){return 1===e.dom.nodeType}var qe,ze,Ye,Ze,Ge=tinymce.util.Tools.resolve("tinymce.PluginManager"),Je=e("string"),et=e("object"),tt=e("array"),nt=t("boolean"),rt=t("function"),ot=t("number"),it=r(!1),at=r(!0),st={fold:function(e){return e()},isSome:it,isNone:at,getOr:o,getOrThunk:u,getOrDie:function(e){throw new Error(e||"error: getOrDie called on none.")},getOrNull:r(null),getOrUndefined:r(void 0),or:o,orThunk:u,map:s,each:n,bind:s,exists:it,forall:at,filter:function(){return st},toArray:function(){return[]},toString:r("none()")},ut=function(e){function t(){return i}function n(t){return t(e)}var o=r(e),i={fold:function(t,n){return n(e)},isSome:at,isNone:it,getOr:o,getOrThunk:o,getOrDie:o,getOrNull:o,getOrUndefined:o,or:t,orThunk:t,map:function(t){return ut(t(e))},each:function(t){t(e)},bind:n,exists:n,forall:n,filter:function(t){return t(e)?i:st},toArray:function(){return[e]},toString:function(){return"some("+e+")"}};return i},ct={some:ut,none:s,from:function(e){return null==e?st:ut(e)}},ft=Array.prototype.slice,dt=Array.prototype.push,lt=function(){return(lt=Object.assign||function(e){for(var t,n=1,r=arguments.length;n<r;n++)for(var o in t=arguments[n])Object.prototype.hasOwnProperty.call(t,o)&&(e[o]=t[o]);return e}).apply(this,arguments)},mt=function(e,t){return{major:e,minor:t}},pt={nu:mt,detect:function(e,t){function n(e){return Number(r.replace(o,"$"+e))}var r,o,i=String(t).toLowerCase();return 0===e.length?A():(o=function(e,t){for(var n=0;n<e.length;n++){var r=e[n];if(r.test(t))return r}}(e,r=i))?mt(n(1),n(2)):{major:0,minor:0}},unknown:A},gt=(qe=/^\s+|\s+$/g,function(e){return e.replace(qe,"")}),ht=/.*?version\/\ ?([0-9]+)\.([0-9]+).*/,vt={browsers:r([{name:"Edge",versionRegexes:[/.*?edge\/ ?([0-9]+)\.([0-9]+)$/],search:function(e){return N(e,"edge/")&&N(e,"chrome")&&N(e,"safari")&&N(e,"applewebkit")}},{name:"Chrome",brand:"Chromium",versionRegexes:[/.*?chrome\/([0-9]+)\.([0-9]+).*/,ht],search:function(e){return N(e,"chrome")&&!N(e,"chromeframe")}},{name:"IE",versionRegexes:[/.*?msie\ ?([0-9]+)\.([0-9]+).*/,/.*?rv:([0-9]+)\.([0-9]+).*/],search:function(e){return N(e,"msie")||N(e,"trident")}},{name:"Opera",versionRegexes:[ht,/.*?opera\/([0-9]+)\.([0-9]+).*/],search:O("opera")},{name:"Firefox",versionRegexes:[/.*?firefox\/\ ?([0-9]+)\.([0-9]+).*/],search:O("firefox")},{name:"Safari",versionRegexes:[ht,/.*?cpu os ([0-9]+)_([0-9]+).*/],search:function(e){return(N(e,"safari")||N(e,"mobile/"))&&N(e,"applewebkit")}}]),oses:r([{name:"Windows",search:O("win"),versionRegexes:[/.*?windows\ nt\ ?([0-9]+)\.([0-9]+).*/]},{name:"iOS",search:function(e){return N(e,"iphone")||N(e,"ipad")},versionRegexes:[/.*?version\/\ ?([0-9]+)\.([0-9]+).*/,/.*cpu os ([0-9]+)_([0-9]+).*/,/.*cpu iphone os ([0-9]+)_([0-9]+).*/]},{name:"Android",search:O("android"),versionRegexes:[/.*?android\ ?([0-9]+)\.([0-9]+).*/]},{name:"OSX",search:O("mac os x"),versionRegexes:[/.*?mac\ os\ x\ ?([0-9]+)_([0-9]+).*/]},{name:"Linux",search:O("linux"),versionRegexes:[]},{name:"Solaris",search:O("sunos"),versionRegexes:[]},{name:"FreeBSD",search:O("freebsd"),versionRegexes:[]},{name:"ChromeOS",search:O("cros"),versionRegexes:[/.*?chrome\/([0-9]+)\.([0-9]+).*/]}])},yt="Firefox",St=function(){return w({current:void 0,version:pt.unknown()})},Ct=w,bt=(r("Edge"),r("Chrome"),r("IE"),r("Opera"),r(yt),r("Safari"),"Windows"),Nt="Android",Ot="Solaris",Lt="FreeBSD",Tt="ChromeOS",Dt=function(){return k({current:void 0,version:pt.unknown()})},xt=k,At=(r(bt),r("iOS"),r(Nt),r("Linux"),r("OSX"),r(Ot),r(Lt),r(Tt),Ze=!(ze=function(){return e=navigator.userAgent,t=ct.from(navigator.userAgentData),n=L,h=vt.browsers(),v=vt.oses(),{browser:y=t.bind(function(e){return C(h,e)}).orThunk(function(){return b(h,t=e).map(function(e){var n=pt.detect(e.versionRegexes,t);return{current:e.name,version:n}});var t}).fold(St,Ct),os:S=b(v,o=e).map(function(e){var t=pt.detect(e.versionRegexes,o);return{current:e.name,version:t}}).fold(Dt,xt),deviceType:(a=y,s=e,u=n,c=(i=S).isiOS()&&!0===/ipad/i.test(s),f=i.isiOS()&&!c,l=(d=i.isiOS()||i.isAndroid())||u("(pointer:coarse)"),m=c||!f&&d&&u("(min-device-width:768px)"),p=f||d&&!m,g=a.isSafari()&&i.isiOS()&&!1===/safari/i.test(s),{isiPad:r(c),isiPhone:r(f),isTablet:r(m),isPhone:r(p),isTouch:r(l),isAndroid:i.isAndroid,isiOS:i.isiOS,isWebView:r(g),isDesktop:r(!p&&!m&&!g)})};var e,t,n,o,i,a,s,u,c,f,d,l,m,p,g,h,v,y,S}),function(){for(var e=[],t=0;t<arguments.length;t++)e[t]=arguments[t];return Ze||(Ze=!0,Ye=ze.apply(null,e)),Ye}),wt={fromHtml:function(e,t){var n=(t||document).createElement("div");if(n.innerHTML=e,!n.hasChildNodes()||1<n.childNodes.length)throw console.error("HTML does not have a single root node",e),new Error("HTML must have a single root node");return E(n.childNodes[0])},fromTag:function(e,t){return E((t||document).createElement(e))},fromText:function(e,t){return E((t||document).createTextNode(e))},fromDom:E,fromPoint:function(e,t,n){return ct.from(e.dom.elementFromPoint(t,n)).map(E)}},kt=function(e,t){var n=e.dom;if(1!==n.nodeType)return!1;var r=n;if(void 0!==r.matches)return r.matches(t);if(void 0!==r.msMatchesSelector)return r.msMatchesSelector(t);if(void 0!==r.webkitMatchesSelector)return r.webkitMatchesSelector(t);if(void 0!==r.mozMatchesSelector)return r.mozMatchesSelector(t);throw new Error("Browser lacks native selectors")},Et=tinymce.util.Tools.resolve("tinymce.dom.RangeUtils"),It=tinymce.util.Tools.resolve("tinymce.dom.TreeWalker"),Pt=tinymce.util.Tools.resolve("tinymce.util.VK"),Bt=Object.keys;"undefined"!=typeof window||Function("return this;")();var Rt=tinymce.util.Tools.resolve("tinymce.dom.DOMUtils"),Mt=tinymce.util.Tools.resolve("tinymce.util.Tools"),Ut=q(/^(OL|UL|DL)$/),_t=q(/^(OL|UL)$/),$t=X("ol"),Ft=q(/^(LI|DT|DD)$/),Ht=q(/^(DT|DD)$/),jt=q(/^(TH|TD)$/),Kt=X("br"),Vt=Rt.DOM,Wt=P("dd"),Qt=P("dt"),Xt=tinymce.util.Tools.resolve("tinymce.dom.DomQuery"),qt=function(e,t){var n=e.dom.getParents(t,"TD,TH");return 0<n.length?n[0]:e.getBody()},zt=function(e,t){var n=c(t,function(t){return se(e,t).getOr(t)});return Xt.unique(n)},Yt=function(e,t,n,r){return g(U(r),function(r){return(ge(r)?Yt:Ce)(e+1,t,n,r)})},Zt=tinymce.util.Tools.resolve("tinymce.dom.BookmarkManager"),Gt=Rt.DOM,Jt=function(e,t){var n,r=t.nextSibling;if(Ue(e,t,r)){for(;n=r.firstChild;)t.appendChild(n);e.remove(r)}if(Ue(e,t,r=t.previousSibling)){for(;n=r.lastChild;)t.insertBefore(n,t.firstChild);e.remove(r)}},en=function(e){return"list-style-type"in e},tn=Rt.DOM,nn=function(e){if(--e<0)return"";var t=e%26,n=Math.floor(e/26);return nn(n)+String.fromCharCode("A".charCodeAt(0)+t)};Ge.add("lists",function(e){function t(e){return function(){return i.execCommand(e)}}var n,r,o,i,a,s,u,c;return!1===e.hasPlugin("rtc",!0)?((s=e).getParam("lists_indent_on_tab",!0)&&(u=s).on("keydown",function(e){e.keyCode!==Pt.TAB||Pt.metaKeyPressed(e)||u.undoManager.transact(function(){(e.shiftKey?De:Te)(u)&&e.preventDefault()})}),(c=s).on("keydown",function(e){e.keyCode===Pt.BACKSPACE?Ke(c,!1)&&e.preventDefault():e.keyCode===Pt.DELETE&&Ke(c,!0)&&e.preventDefault()}),(a=e).on("BeforeExecCommand",function(e){var t=e.command.toLowerCase();"indent"===t?Te(a):"outdent"===t&&De(a)}),a.addCommand("InsertUnorderedList",function(e,t){_e(a,"UL",t)}),a.addCommand("InsertOrderedList",function(e,t){_e(a,"OL",t)}),a.addCommand("InsertDefinitionList",function(e,t){_e(a,"DL",t)}),a.addCommand("RemoveList",function(){xe(a)}),Qe(a),a.addCommand("mceListUpdate",function(e,t){var n,r,o;et(t)&&(r=t,o=ie(n=a),n.undoManager.transact(function(){et(r.styles)&&n.dom.setStyles(o,r.styles),et(r.attrs)&&x(r.attrs,function(e,t){return n.dom.setAttrib(o,t,e)})}))}),a.addQueryStateHandler("InsertUnorderedList",We(a,"UL")),a.addQueryStateHandler("InsertOrderedList",We(a,"OL")),a.addQueryStateHandler("InsertDefinitionList",We(a,"DL"))):Qe(e),(i=e).hasPlugin("advlist")||(i.ui.registry.addToggleButton("numlist",{icon:"ordered-list",active:!1,tooltip:"Numbered list",onAction:t("InsertOrderedList"),onSetup:function(e){return Ie(i,"OL",e.setActive)}}),i.ui.registry.addToggleButton("bullist",{icon:"unordered-list",active:!1,tooltip:"Bullet list",onAction:t("InsertUnorderedList"),onSetup:function(e){return Ie(i,"UL",e.setActive)}})),r={text:"List properties...",icon:"ordered-list",onAction:function(){return n.execCommand("mceListProps")},onSetup:function(e){return Ie(n,"OL",function(t){return e.setDisabled(!t)})}},(n=e).ui.registry.addMenuItem("listprops",r),n.ui.registry.addContextMenu("lists",{update:function(e){var t=ie(n,e);return $t(t)?["listprops"]:[]}}),o=e,{backspaceDelete:function(e){Ke(o,e)}}})}();