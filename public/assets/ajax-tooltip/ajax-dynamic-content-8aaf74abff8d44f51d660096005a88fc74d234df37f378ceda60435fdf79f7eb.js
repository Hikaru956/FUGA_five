/************************************************************************************************************
Ajax dynamic content
Copyright (C) 2006  DTHMLGoodies.com, Alf Magne Kalleland

This library is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public
License as published by the Free Software Foundation; either
version 2.1 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public
License along with this library; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA

Dhtmlgoodies.com., hereby disclaims all copyright interest in this script
written by Alf Magne Kalleland.

Alf Magne Kalleland, 2006
Owner of DHTMLgoodies.com
	
************************************************************************************************************/
function ajax_showContent(e,n,a){document.getElementById(e).innerHTML=dynamicContent_ajaxObjects[n].response,enableCache&&(jsCache[a]=dynamicContent_ajaxObjects[n].response),dynamicContent_ajaxObjects[n]=!1}function ajax_loadContent(e,n){if(enableCache&&jsCache[n])document.getElementById(e).innerHTML=jsCache[n];else{var a=dynamicContent_ajaxObjects.length;if(document.getElementById(e).innerHTML="Loading content - please wait",dynamicContent_ajaxObjects[a]=new alt_sack,n.indexOf("?")>=0){dynamicContent_ajaxObjects[a].method="GET";var t=n.substring(n.indexOf("?"));n=n.replace(t,"");for(var c=(t=t.replace("?","")).split(/&/g),o=0;o<c.length;o++){var s=c[o].split("=");2==s.length&&dynamicContent_ajaxObjects[a].setVar(s[0],s[1])}n=n.replace(t,"")}dynamicContent_ajaxObjects[a].requestFile=n,dynamicContent_ajaxObjects[a].onCompletion=function(){ajax_showContent(e,a,n)},dynamicContent_ajaxObjects[a].runAJAX()}}var enableCache=!0,jsCache=new Array,dynamicContent_ajaxObjects=new Array;