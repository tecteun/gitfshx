package;
import haxe.web.Dispatch;
import cs.system.net.HttpListenerContext;
import macros.Macros;
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
		trace(Macros.GetGitShortHead());
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
		GitHelper.parseTree(branch);
		return;
		//branch.CurrentCommit.Tree; //upper level tree
		//branch.CurrentCommit.Tree.Trees; //sub level level tree
		
		for(tree in cs.Lib.array(branch.CurrentCommit.Tree.Trees)){
		
			trace("path: " + tree.Path + " contains " + cs.Lib.array(tree.Leaves).length + " leaves");
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
		
		
		var t = new haxe.Template(haxe.Resource.getString("branch_template"));
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
		return Reflect.hasField(Util.mimes, p) ? Reflect.field(Util.mimes, p) : "application/octet-stream";
		//return (untyped __cs__("System.Web.MimeMapping.GetMimeMapping("file")")); 		
	}
	
	
	
	
	
	
}
