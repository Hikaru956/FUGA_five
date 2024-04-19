/************************************************************************************************************
Ajax tooltip
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
function ajax_showTooltip(t,o){if(!ajax_tooltipObj){(ajax_tooltipObj=document.createElement("DIV")).style.position="absolute",ajax_tooltipObj.id="ajax_tooltipObj",document.body.appendChild(ajax_tooltipObj);var a=document.createElement("DIV");a.className="ajax_tooltip_arrow",a.id="ajax_tooltip_arrow",ajax_tooltipObj.appendChild(a);var e=document.createElement("DIV");e.className="ajax_tooltip_content",ajax_tooltipObj.appendChild(e),e.id="ajax_tooltip_content",ajax_tooltip_MSIE&&((ajax_tooltipObj_iframe=document.createElement('<IFRAME frameborder="0">')).style.position="absolute",ajax_tooltipObj_iframe.border="0",ajax_tooltipObj_iframe.frameborder=0,ajax_tooltipObj_iframe.style.backgroundColor="#FFF",ajax_tooltipObj_iframe.src="about:blank",e.appendChild(ajax_tooltipObj_iframe),ajax_tooltipObj_iframe.style.left="0px",ajax_tooltipObj_iframe.style.top="0px")}ajax_tooltipObj.style.display="block",ajax_loadContent("ajax_tooltip_content",t),ajax_tooltip_MSIE&&(ajax_tooltipObj_iframe.style.width=ajax_tooltipObj.clientWidth+"px",ajax_tooltipObj_iframe.style.height=ajax_tooltipObj.clientHeight+"px"),ajax_positionTooltip(o)}function ajax_positionTooltip(t){var o=ajaxTooltip_getLeftPos(t)+t.offsetWidth,a=ajaxTooltip_getTopPos(t);document.getElementById("ajax_tooltip_content").offsetWidth,document.getElementById("ajax_tooltip_arrow").offsetWidth;ajax_tooltipObj.style.left=o+"px",ajax_tooltipObj.style.top=a+"px"}function ajax_hideTooltip(){ajax_tooltipObj.style.display="none"}function ajaxTooltip_getTopPos(t){for(var o=t.offsetTop;null!=(t=t.offsetParent);)"HTML"!=t.tagName&&(o+=t.offsetTop);return o}function ajaxTooltip_getLeftPos(t){for(var o=t.offsetLeft;null!=(t=t.offsetParent);)"HTML"!=t.tagName&&(o+=t.offsetLeft);return o}var x_offset_tooltip=5,y_offset_tooltip=0,ajax_tooltipObj=!1,ajax_tooltipObj_iframe=!1,ajax_tooltip_MSIE=!1;navigator.userAgent.indexOf("MSIE")>=0&&(ajax_tooltip_MSIE=!0);