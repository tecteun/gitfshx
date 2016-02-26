package;
import haxe.web.Dispatch;
import cs.system.net.HttpListenerContext;

/**
 * https://gist.github.com/textarcana/1306223 
 * https://github.com/henon/GitSharp/
 */
//@:CsNative("using Microsoft.AspNet.Builder")
//@:CsNative("using System.Net")

//@:classCode("using System.Linq;\n")
class Index
{
	private static var repo:Dynamic;
	static var _listener;
	/**
	 * Required main starting point of our application.
	 */
	static function main() 
	{
		cs.system.Console.set_BackgroundColor(cs.system.ConsoleColor.Green);
		cs.system.Console.set_ForegroundColor(cs.system.ConsoleColor.Black);
	/*	
    var parseFolder:String->Dynamic = null;
    parseFolder = function(folder:String){
      folder = haxe.io.Path.addTrailingSlash(folder);
      var retval:Dynamic = {}, fsubfolder = false, path;
      for(rawpath in sys.FileSystem.readDirectory(folder)){
        path = folder + rawpath;
        if(sys.FileSystem.isDirectory(path)){
          fsubfolder = true;
          Reflect.setField(retval, rawpath, parseFolder(path));
        }
      }
      return fsubfolder == false ? sys.FileSystem.readDirectory(folder) : retval ;
    }
	*/


		var s:String = untyped __cs__("GitSharp.Repository.FindRepository(\".\")");
		trace(untyped __cs__("GitSharp.Repository.IsValid(s)"));
		repo = untyped __cs__("new GitSharp.Repository(s)");
		var enumerator:cs.system.collections.IEnumerator = repo.Branches.Keys.GetEnumerator();
		while(enumerator.MoveNext()){
			trace(enumerator.Current);
		}
		
		trace(untyped __cs__("new GitSharp.Repository(s).Get<GitSharp.Branch>(\"master\")"));
		var branch:Dynamic = (untyped __cs__("new GitSharp.Repository(s).Get<GitSharp.Branch>(\"master\")")); //GitSharp.Branch
		//trace(branch.Fullname);
		//var leaves:Iterator<Dynamic>= cast(branch.CurrentCommit.Tree.Leaves.Cast<());
		trace(branch.CurrentCommit.ShortHash);
		trace(branch.CurrentCommit.ShortHash);
		
		//branch.CurrentCommit.Tree; //upper level tree
		//branch.CurrentCommit.Tree.Trees; //sub level level tree
		
		for(tree in cs.Lib.array(branch.CurrentCommit.Tree.Trees)){
		
			trace(cs.Lib.array(tree.Leaves).length);
			//var enumerable:cs.system.collections.IEnumerator = tree.GetHistory();
			//trace(enumerable);
			//trace(tree.GetHistory().ToArray());
			for(leaf in cs.Lib.array(tree.Leaves)){
				trace(leaf.Path);
				trace(getMimeType(leaf.Path));
				//trace(" aap");//https://github.com/henon/GitSharp/blob/4cef5fe76e80cfb457abb7d5f9d8c5040affa4c5/GitSharp/AbstractTreeNode.cs
				if(leaf.Path == "testfolders/build.hxml"){
					var ienumerable:cs.system.collections.IEnumerable = leaf.GetHistory();
					var enumerator:cs.system.collections.IEnumerator = ienumerable.GetEnumerator();
					while(enumerator.MoveNext()){
						for(tree in cs.Lib.array(enumerator.Current.Tree.Trees)){
							for(leaf in cs.Lib.array(tree.Leaves)){
								if(leaf.Path == "testfolders/build.hxml"){
									trace("changed in " + enumerator.Current);
									trace(leaf.Data);
								}
							}
						}
						
					}
					//trace(leaf.GetLastCommit().Data);
					/*
					trace(leaf.GetLastCommit().Data);
					trace(enumerable.Current);
					//trace(enumerable.Current.Data);
					trace(enumerable.MoveNext());
					trace("test " + enumerable.Current);
					*/
					/*
					for(leaf in leaf.GetHistory()){
						trace(leaf.Data);
					}*/
				}
				//trace(leaf.Data);
				
			}
		}
		/*
		//trace(cs.Lib.array());
		trace("test");
		trace(repo);
		trace(repo.Head);
		trace(repo.Head.CurrentCommit);
		trace(repo.Head.CurrentCommit.Ancestors);
		trace(repo.Head.CurrentCommit.Ancestors.Where(function(d:Dynamic):Bool{ return true;}) );
		for(ancestor in cast(branch.CurrentCommit.Ancestors, Array<Dynamic>)){
			trace(ancestor.Message);
			
		}
		*/
		trace("Gixen webservice starting. press any key to quit.");
		_listener = untyped __cs__("new System.Net.HttpListener()");
		_listener.Prefixes.Add("http://*:1234/");
	    _listener.Start();
		_listener.BeginGetContext(new cs.system.AsyncCallback(GetContextCallback), null);
		cs.system.Console.ReadLine();
		_listener.Stop();
	}
	
	private static function GetBranches():Array<Dynamic>{
		var retval:Array<Dynamic> = new Array<Dynamic>();
		var enumerator:cs.system.collections.IEnumerator = repo.Branches.Values.GetEnumerator();

		while(enumerator.MoveNext()){
			retval.push(enumerator.Current);
		}
		return retval;
	}
	
	private static function GetLeaves(branchKey:String){
		//var branch:Dynamic = (untyped __cs__('new GitSharp.Repository(s).Get<GitSharp.Branch>("$branchKey")')); //GitSharp.Branch
		
		
	}
	
	///refs/heads
	
	//http://mikehadlow.blogspot.no/2006/07/playing-with-httpsys.html
	//TODO: chunked responses?
	private static function GetContextCallback(result:cs.system.IAsyncResult):Void{
		var context:HttpListenerContext = _listener.EndGetContext(result);
		var request = context.Request;
		var response = context.Response;
		var p = new haxe.io.Path(request.Url.LocalPath);
		trace(p.dir);
		trace(p.backslash);
		trace(p.file);
		
		
		var t = new haxe.Template(haxe.Resource.getString("filetemplate"));
		var output = "";
		var branches:Array<Dynamic> = new Array<Dynamic>();
		
		var count = 0;
		for(branch in GetBranches()){
			branches.push({count: count++, name: branch, lastmodified: branch.CurrentCommit.AuthorDate});
		}
		try{
			output = t.execute({ rows : GetBranches(), type:"brrranches", branches: branches });
		}catch(e:Dynamic){trace(e);}
		
		
		cs.system.Console.set_ForegroundColor(cs.system.ConsoleColor.DarkRed);
		trace('Incoming -> ${context.Request.Url.AbsoluteUri}');
		cs.system.Console.set_ForegroundColor(cs.system.ConsoleColor.Black);
		var buf = new StringBuf();
		buf.add("");
        buf.add('HttpMethod: ${request.HttpMethod}\n');
        buf.add('Uri: ${request.Url.AbsoluteUri}\n');
        buf.add('LocalPath: ${request.Url.LocalPath}\n');
    	var enumerator:cs.system.collections.IEnumerator = request.QueryString.Keys.GetEnumerator();
        while(enumerator.MoveNext()){
			
            buf.add('Query:      ${enumerator.Current} = ${ request.QueryString.Get(enumerator.Current)}\n');

        }
		buf.add(GetBranches());
		
        buf.add("");
		var buffer = cs.system.text.Encoding.UTF8.GetBytes(output.toString());
		if(request.Headers.Get("Accept-Encoding").indexOf("gzip") > -1){
			var ms:cs.system.io.MemoryStream = new cs.system.io.MemoryStream();
			var zip = new cs.system.io.compression.GZipStream(ms, cs.system.io.compression.CompressionMode.Compress);
			zip.Write(buffer, 0, buffer.Length);
			zip.Close();
			var oldSize= buffer.Length;
			
			//set new buffer to compressed stream
			buffer = ms.ToArray();
			
			var perc = Math.round(((buffer.Length - oldSize) / oldSize) * 100);
			trace('write compressed stream $oldSize->${buffer.Length} $perc% reduction of bytes');
			response.AddHeader("Content-Encoding", "gzip");
		}
		
		response.AppendHeader("Server", "Gixen/Mono | v0.1");
		response.ContentLength64 = buffer.Length;
		response.OutputStream.Write(buffer, 0, buffer.Length);		
		_listener.BeginGetContext(new cs.system.AsyncCallback(GetContextCallback), null);
	}
	
	private static function getMimeType(file:String):String{
		var p = new haxe.io.Path(file).ext;
		return Reflect.hasField(mimes, p) ? Reflect.field(mimes, p) : "application/octet-stream";
		//return (untyped __cs__("System.Web.MimeMapping.GetMimeMapping("file")")); 		
	}
	
	private static var mimes:Dynamic = 
	{	"ai": "application/postscript",
	    "aif": "audio/x-aiff",
	    "aifc": "audio/x-aiff",
	    "aiff": "audio/x-aiff",
	    "asc": "text/plain",
	    "atom": "application/atom+xml",
	    "au": "audio/basic",
	    "avi": "video/x-msvideo",
	    "bcpio": "application/x-bcpio",
	    "bin": "application/octet-stream",
	    "bmp": "image/bmp",
	    "cdf": "application/x-netcdf",
	    "cgm": "image/cgm",
	    "class": "application/octet-stream",
	    "cpio": "application/x-cpio",
	    "cpt": "application/mac-compactpro",
	    "csh": "application/x-csh",
	    "css": "text/css",
	    "dcr": "application/x-director",
	    "dif": "video/x-dv",
	    "dir": "application/x-director",
	    "djv": "image/vnd.djvu",
	    "djvu": "image/vnd.djvu",
	    "dll": "application/octet-stream",
	    "dmg": "application/octet-stream",
	    "dms": "application/octet-stream",
	    "doc": "application/msword",
	    "docx":"application/vnd.openxmlformats-officedocument.wordprocessingml.document",
	    "dotx": "application/vnd.openxmlformats-officedocument.wordprocessingml.template",
	    "docm":"application/vnd.ms-word.document.macroEnabled.12",
	    "dotm":"application/vnd.ms-word.template.macroEnabled.12",
	    "dtd": "application/xml-dtd",
	    "dv": "video/x-dv",
	    "dvi": "application/x-dvi",
	    "dxr": "application/x-director",
	    "eps": "application/postscript",
	    "etx": "text/x-setext",
	    "exe": "application/octet-stream",
	    "ez": "application/andrew-inset",
	    "gif": "image/gif",
	    "gram": "application/srgs",
	    "grxml": "application/srgs+xml",
	    "gtar": "application/x-gtar",
	    "hdf": "application/x-hdf",
	    "hqx": "application/mac-binhex40",
		"hx": "text/x-haxe",
	    "htm": "text/html",
	    "html": "text/html",
	    "ice": "x-conference/x-cooltalk",
	    "ico": "image/x-icon",
	    "ics": "text/calendar",
	    "ief": "image/ief",
	    "ifb": "text/calendar",
	    "iges": "model/iges",
	    "igs": "model/iges",
	    "jnlp": "application/x-java-jnlp-file",
	    "jp2": "image/jp2",
	    "jpe": "image/jpeg",
	    "jpeg": "image/jpeg",
	    "jpg": "image/jpeg",
	    "js": "application/x-javascript",
	    "kar": "audio/midi",
	    "latex": "application/x-latex",
	    "lha": "application/octet-stream",
	    "lzh": "application/octet-stream",
	    "m3u": "audio/x-mpegurl",
	    "m4a": "audio/mp4a-latm",
	    "m4b": "audio/mp4a-latm",
	    "m4p": "audio/mp4a-latm",
	    "m4u": "video/vnd.mpegurl",
	    "m4v": "video/x-m4v",
	    "mac": "image/x-macpaint",
	    "man": "application/x-troff-man",
	    "mathml": "application/mathml+xml",
	    "me": "application/x-troff-me",
	    "mesh": "model/mesh",
	    "mid": "audio/midi",
	    "midi": "audio/midi",
	    "mif": "application/vnd.mif",
	    "mov": "video/quicktime",
	    "movie": "video/x-sgi-movie",
	    "mp2": "audio/mpeg",
	    "mp3": "audio/mpeg",
	    "mp4": "video/mp4",
	    "mpe": "video/mpeg",
	    "mpeg": "video/mpeg",
	    "mpg": "video/mpeg",
	    "mpga": "audio/mpeg",
	    "ms": "application/x-troff-ms",
	    "msh": "model/mesh",
	    "mxu": "video/vnd.mpegurl",
	    "nc": "application/x-netcdf",
	    "oda": "application/oda",
	    "ogg": "application/ogg",
	    "pbm": "image/x-portable-bitmap",
	    "pct": "image/pict",
	    "pdb": "chemical/x-pdb",
	    "pdf": "application/pdf",
	    "pgm": "image/x-portable-graymap",
	    "pgn": "application/x-chess-pgn",
	    "pic": "image/pict",
	    "pict": "image/pict",
	    "png": "image/png",
	    "pnm": "image/x-portable-anymap",
	    "pnt": "image/x-macpaint",
	    "pntg": "image/x-macpaint",
	    "ppm": "image/x-portable-pixmap",
	    "ppt": "application/vnd.ms-powerpoint",
	    "pptx": "application/vnd.openxmlformats-officedocument.presentationml.presentation",
	    "potx": "application/vnd.openxmlformats-officedocument.presentationml.template",
	    "ppsx": "application/vnd.openxmlformats-officedocument.presentationml.slideshow",
	    "ppam": "application/vnd.ms-powerpoint.addin.macroEnabled.12",
	    "pptm": "application/vnd.ms-powerpoint.presentation.macroEnabled.12",
	    "potm": "application/vnd.ms-powerpoint.template.macroEnabled.12",
	    "ppsm": "application/vnd.ms-powerpoint.slideshow.macroEnabled.12",
	    "ps": "application/postscript",
	    "qt": "video/quicktime",
	    "qti": "image/x-quicktime",
	    "qtif": "image/x-quicktime",
	    "ra": "audio/x-pn-realaudio",
	    "ram": "audio/x-pn-realaudio",
	    "ras": "image/x-cmu-raster",
	    "rdf": "application/rdf+xml",
	    "rgb": "image/x-rgb",
	    "rm": "application/vnd.rn-realmedia",
	    "roff": "application/x-troff",
	    "rtf": "text/rtf",
	    "rtx": "text/richtext",
	    "sgm": "text/sgml",
	    "sgml": "text/sgml",
	    "sh": "application/x-sh",
	    "shar": "application/x-shar",
	    "silo": "model/mesh",
	    "sit": "application/x-stuffit",
	    "skd": "application/x-koan",
	    "skm": "application/x-koan",
	    "skp": "application/x-koan",
	    "skt": "application/x-koan",
	    "smi": "application/smil",
	    "smil": "application/smil",
	    "snd": "audio/basic",
	    "so": "application/octet-stream",
	    "spl": "application/x-futuresplash",
	    "src": "application/x-wais-source",
	    "sv4cpio": "application/x-sv4cpio",
	    "sv4crc": "application/x-sv4crc",
	    "svg": "image/svg+xml",
	    "swf": "application/x-shockwave-flash",
	    "t": "application/x-troff",
	    "tar": "application/x-tar",
	    "tcl": "application/x-tcl",
	    "tex": "application/x-tex",
	    "texi": "application/x-texinfo",
	    "texinfo": "application/x-texinfo",
	    "tif": "image/tiff",
	    "tiff": "image/tiff",
	    "tr": "application/x-troff",
	    "tsv": "text/tab-separated-values",
	    "txt": "text/plain",
	    "ustar": "application/x-ustar",
	    "vcd": "application/x-cdlink",
	    "vrml": "model/vrml",
	    "vxml": "application/voicexml+xml",
	    "wav": "audio/x-wav",
	    "wbmp": "image/vnd.wap.wbmp",
	    "wbmxl": "application/vnd.wap.wbxml",
	    "wml": "text/vnd.wap.wml",
	    "wmlc": "application/vnd.wap.wmlc",
	    "wmls": "text/vnd.wap.wmlscript",
	    "wmlsc": "application/vnd.wap.wmlscriptc",
	    "wrl": "model/vrml",
	    "xbm": "image/x-xbitmap",
	    "xht": "application/xhtml+xml",
	    "xhtml": "application/xhtml+xml",
	    "xls": "application/vnd.ms-excel",                        
	    "xml": "application/xml",
	    "xpm": "image/x-xpixmap",
	    "xsl": "application/xml",
	    "xlsx": "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
	    "xltx": "application/vnd.openxmlformats-officedocument.spreadsheetml.template",
	    "xlsm": "application/vnd.ms-excel.sheet.macroEnabled.12",
	    "xltm": "application/vnd.ms-excel.template.macroEnabled.12",
	    "xlam": "application/vnd.ms-excel.addin.macroEnabled.12",
	    "xlsb": "application/vnd.ms-excel.sheet.binary.macroEnabled.12",
	    "xslt": "application/xslt+xml",
	    "xul": "application/vnd.mozilla.xul+xml",
	    "xwd": "image/x-xwindowdump",
	    "xyz": "chemical/x-xyz",
	    "zip": "application/zip"};
	
	
	
	
}
