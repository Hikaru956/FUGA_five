tinymce.PluginManager.add("fullpage",function(e){function t(){var t=n();e.windowManager.open({title:"Document properties",data:t,defaults:{type:"textbox",size:40},body:[{name:"title",label:"Title"},{name:"keywords",label:"Keywords"},{name:"description",label:"Description"},{name:"robots",label:"Robots"},{name:"author",label:"Author"},{name:"docencoding",label:"Encoding"}],onSubmit:function(e){l(tinymce.extend(t,e.data))}})}function n(){function t(e,t){return e.attr(t)||""}var n,l,a=i(),o={};return o.fontface=e.getParam("fullpage_default_fontface",""),o.fontsize=e.getParam("fullpage_default_fontsize",""),7==(n=a.firstChild).type&&(o.xml_pi=!0,(l=/encoding="([^"]+)"/.exec(n.value))&&(o.docencoding=l[1])),(n=a.getAll("#doctype")[0])&&(o.doctype="<!DOCTYPE"+n.value+">"),(n=a.getAll("title")[0])&&n.firstChild&&(o.title=n.firstChild.value),s(a.getAll("meta"),function(e){var t,n=e.attr("name"),l=e.attr("http-equiv");n?o[n.toLowerCase()]=e.attr("content"):"Content-Type"==l&&((t=/charset\s*=\s*(.*)\s*/gi.exec(e.attr("content")))&&(o.docencoding=t[1]))}),(n=a.getAll("html")[0])&&(o.langcode=t(n,"lang")||t(n,"xml:lang")),o.stylesheets=[],tinymce.each(a.getAll("link"),function(e){"stylesheet"==e.attr("rel")&&o.stylesheets.push(e.attr("href"))}),(n=a.getAll("body")[0])&&(o.langdir=t(n,"dir"),o.style=t(n,"style"),o.visited_color=t(n,"vlink"),o.link_color=t(n,"link"),o.active_color=t(n,"alink")),o}function l(t){function n(e,t,n){e.attr(t,n||void 0)}function l(e){o.firstChild?o.insert(e,o.firstChild):o.append(e)}var a,o,r,c,u,f=e.dom;a=i(),(o=a.getAll("head")[0])||(c=a.getAll("html")[0],o=new m("head",1),c.firstChild?c.insert(o,c.firstChild,!0):c.append(o)),c=a.firstChild,t.xml_pi?(u='version="1.0"',t.docencoding&&(u+=' encoding="'+t.docencoding+'"'),7!=c.type&&(c=new m("xml",7),a.insert(c,a.firstChild,!0)),c.value=u):c&&7==c.type&&c.remove(),c=a.getAll("#doctype")[0],t.doctype?(c||(c=new m("#doctype",10),t.xml_pi?a.insert(c,a.firstChild):l(c)),c.value=t.doctype.substring(9,t.doctype.length-1)):c&&c.remove(),t.docencoding&&(c=null,s(a.getAll("meta"),function(e){"Content-Type"==e.attr("http-equiv")&&(c=e)}),c||((c=new m("meta",1)).attr("http-equiv","Content-Type"),c.shortEnded=!0,l(c)),c.attr("content","text/html; charset="+t.docencoding)),c=a.getAll("title")[0],t.title?c||((c=new m("title",1)).append(new m("#text",3)).value=t.title,l(c)):c&&c.remove(),s("keywords,description,author,copyright,robots".split(","),function(e){var n,i,o=a.getAll("meta"),r=t[e];for(n=0;n<o.length;n++)if((i=o[n]).attr("name")==e)return void(r?i.attr("content",r):i.remove());r&&((c=new m("meta",1)).attr("name",e),c.attr("content",r),c.shortEnded=!0,l(c))});var g={};tinymce.each(a.getAll("link"),function(e){"stylesheet"==e.attr("rel")&&(g[e.attr("href")]=e)}),tinymce.each(t.stylesheets,function(e){g[e]||((c=new m("link",1)).attr({rel:"stylesheet",text:"text/css",href:e}),c.shortEnded=!0,l(c)),delete g[e]}),tinymce.each(g,function(e){e.remove()}),(c=a.getAll("body")[0])&&(n(c,"dir",t.langdir),n(c,"style",t.style),n(c,"vlink",t.visited_color),n(c,"link",t.link_color),n(c,"alink",t.active_color),f.setAttribs(e.getBody(),{style:t.style,dir:t.dir,vLink:t.visited_color,link:t.link_color,aLink:t.active_color})),(c=a.getAll("html")[0])&&(n(c,"lang",t.langcode),n(c,"xml:lang",t.langcode)),o.firstChild||o.remove(),r=new tinymce.html.Serializer({validate:!1,indent:!0,apply_source_formatting:!0,indent_before:"head,html,body,meta,title,script,link,style",indent_after:"head,html,body,meta,title,script,link,style"}).serialize(a),d=r.substring(0,r.indexOf("</body>"))}function i(){return new tinymce.html.DomParser({validate:!1,root_name:"#document"}).parse(d)}function a(t){function n(e){return e.replace(/<\/?[A-Z]+/g,function(e){return e.toLowerCase()})}var l,a,r,m,u=t.content,f="",g=e.dom;if(!t.selection&&!("raw"==t.format&&d||t.source_view&&e.getParam("fullpage_hide_in_source_view"))){-1!=(l=(u=u.replace(/<(\/?)BODY/gi,"<$1body")).indexOf("<body"))?(l=u.indexOf(">",l),d=n(u.substring(0,l+1)),-1==(a=u.indexOf("</body",l))&&(a=u.length),t.content=u.substring(l+1,a),c=n(u.substring(a))):(d=o(),c="\n</body>\n</html>"),r=i(),s(r.getAll("style"),function(e){e.firstChild&&(f+=e.firstChild.value)}),(m=r.getAll("body")[0])&&g.setAttribs(e.getBody(),{style:m.attr("style")||"",dir:m.attr("dir")||"",vLink:m.attr("vlink")||"",link:m.attr("link")||"",aLink:m.attr("alink")||""}),g.remove("fullpage_styles");var y=e.getDoc().getElementsByTagName("head")[0];f&&(g.add(y,"style",{id:"fullpage_styles"},f),(m=g.get("fullpage_styles")).styleSheet&&(m.styleSheet.cssText=f));var h={};tinymce.each(y.getElementsByTagName("link"),function(e){"stylesheet"==e.rel&&e.getAttribute("data-mce-fullpage")&&(h[e.href]=e)}),tinymce.each(r.getAll("link"),function(e){var t=e.attr("href");h[t]||"stylesheet"!=e.attr("rel")||g.add(y,"link",{rel:"stylesheet",text:"text/css",href:t,"data-mce-fullpage":"1"}),delete h[t]}),tinymce.each(h,function(e){e.parentNode.removeChild(e)})}}function o(){var t,n="",l="";return e.getParam("fullpage_default_xml_pi")&&(n+='<?xml version="1.0" encoding="'+e.getParam("fullpage_default_encoding","ISO-8859-1")+'" ?>\n'),n+=e.getParam("fullpage_default_doctype","<!DOCTYPE html>"),n+="\n<html>\n<head>\n",(t=e.getParam("fullpage_default_title"))&&(n+="<title>"+t+"</title>\n"),(t=e.getParam("fullpage_default_encoding"))&&(n+='<meta http-equiv="Content-Type" content="text/html; charset='+t+'" />\n'),(t=e.getParam("fullpage_default_font_family"))&&(l+="font-family: "+t+";"),(t=e.getParam("fullpage_default_font_size"))&&(l+="font-size: "+t+";"),(t=e.getParam("fullpage_default_text_color"))&&(l+="color: "+t+";"),n+"</head>\n<body"+(l?' style="'+l+'"':"")+">\n"}function r(t){t.selection||t.source_view&&e.getParam("fullpage_hide_in_source_view")||(t.content=tinymce.trim(d)+"\n"+tinymce.trim(t.content)+"\n"+tinymce.trim(c))}var d,c,s=tinymce.each,m=tinymce.html.Node;e.addCommand("mceFullPageProperties",t),e.addButton("fullpage",{title:"Document properties",cmd:"mceFullPageProperties"}),e.addMenuItem("fullpage",{text:"Document properties",cmd:"mceFullPageProperties",context:"file"}),e.on("BeforeSetContent",a),e.on("GetContent",r)});