package;
import haxe.web.Dispatch;
import cs.system.net.HttpListenerContext;
import macros.Macros;
import cs.StdTypes;
import gitsharp.Branch;
import gitsharp.Repository;
/**
 * https://gist.github.com/textarcana/1306223 
 * https://github.com/henon/GitSharp/
 */
//@:CsNative("using Microsoft.AspNet.Builder")
//@:CsNative("using System.Net")
@:enum
abstract QType(String) {
  var BRANCH = "/refs/heads";
  var TAG = "/refs/tags";
}

/**
 * https://github.com/HaxeFoundation/HaxeManual/wiki/Haxe-C%23
*/
class Index
{
	private static inline var VERSION:String = "0.2beta";
	private static var repo:Repository;
	static var _listener:cs.system.net.HttpListener;
	/**
	 * Required main starting point of our application.
	 */
	static function main() 
	{
		cs.system.Console.set_BackgroundColor(cs.system.ConsoleColor.Red);
		cs.system.Console.set_ForegroundColor(cs.system.ConsoleColor.Black);
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
		var validRepo:Bool = untyped __cs__("GitSharp.Repository.IsValid(s)");
        if(validRepo){
            repo = untyped __cs__("new GitSharp.Repository(s)");
        }else{
            trace("Error: must run program in a Git repo");
            return;
        }
		var enumerator:cs.system.collections.IEnumerator = repo.Branches.Keys.GetEnumerator();
		while(enumerator.MoveNext()){
			trace(enumerator.Current);
		}
        
        
		
		//trace(untyped __cs__("new GitSharp.Repository(s).Get<GitSharp.Branch>(\"master\")"));
		var branch:Branch = new Repository(s).Get("master");//(untyped __cs__("new GitSharp.Repository(s).Get<GitSharp.Branch>(\"master\")")); //GitSharp.Branch
		
        //trace(branch.Fullname);
		//var leaves:Iterator<Dynamic>= cast(branch.CurrentCommit.Tree.Leaves.Cast<());
		//GitHelper.parseTree(branch);
		
		//branch.CurrentCommit.Tree; //upper level tree
		//branch.CurrentCommit.Tree.Trees; //sub level level tree
		
        for(tree in cs.Lib.array(cast branch.CurrentCommit.Tree.Trees)){
		
			trace("path: " + tree.Path + " contains " + cs.Lib.array(tree.Leaves).length + " leaves");
			//var enumerable:cs.system.collections.IEnumerator = tree.GetHistory();
			//trace(enumerable);
			//trace(tree.GetHistory().ToArray());
			for(leaf in cs.Lib.array(tree.Leaves)){
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
		// maybe do this multithreaded: http://stackoverflow.com/questions/4672010/multi-threading-with-net-httplistener
		_listener = new cs.system.net.HttpListener();
		_listener.Prefixes.Add("http://*:1234/");
	    _listener.Start();
		var result:cs.system.IAsyncResult = _listener.BeginGetContext(new cs.system.AsyncCallback(GetContextCallback), null);
		//result.AsyncWaitHandle.WaitOne();
		cs.system.Console.ReadLine();
		_listener.Stop();
	}
	
	private static function GetTags():Array<Dynamic>{
		var retval:Array<Dynamic> = new Array<Dynamic>();
		var enumerator:cs.system.collections.IEnumerator = repo.Tags.Values.GetEnumerator();

		while(enumerator.MoveNext()){
			retval.push(enumerator.Current);
		}
		return retval;
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
	private static function GetContextCallback(async_result:cs.system.IAsyncResult):Void{
		//startup new thread cycle
		_listener.BeginGetContext(new cs.system.AsyncCallback(GetContextCallback), null);
		
		
		var context:HttpListenerContext = _listener.EndGetContext(async_result);
		var request = context.Request;
		var response = context.Response;
		var output = "";

		trace('Incoming -> ${context.Request.Url.AbsoluteUri}');
		if(request.Url.LocalPath == "/favicon.ico"){
			handleResponse(haxe.Resource.getBytes("favicon").getData(), context, "image/x-icon");
			return;
		}

		if(request.Url.LocalPath.indexOf("/refs/") == 0){
			
			var split = request.Url.LocalPath.substr(1).split("/");
			var repofilepath = null, target = null;
			var qtype:QType = null;
            var commitPointer:String = null;
			while(split.length > 0){
				switch(target = split.shift()){
					
					case "refs": continue;
                    case "heads": qtype = QType.BRANCH; continue;
                    case "tags": qtype = QType.TAG; continue;
					
                default: trace(target); if(commitPointer == null && qtype == QType.BRANCH){ commitPointer = split.shift(); }; repofilepath = split.join("/");  break;
				}
			}
			trace(qtype +  " " + target + " " + commitPointer);
			trace(repofilepath);
            
            //redirect requests for index without trailing /
            if((repofilepath == null || repofilepath.length == 0) && !StringTools.endsWith(request.Url.LocalPath, "/")){
                context.Response.StatusCode = 302;
                context.Response.Headers.Set("Location", request.Url.LocalPath + "/");
                handleResponseString("moved", context);
                return;
            }
			
			var commit = null;
            
            //try getting branch or tag
            try{
                if(null != target && target.length > 0){
        			commit = switch(qtype){
                        case QType.BRANCH: untyped __cs__("(repo as GitSharp.Repository).Get<GitSharp.Commit>(commitPointer);"); //cast(repo.Branches, cs.system.collections.IDictionary).get_Item(target).CurrentCommit; //repo.Get<Commit>( "979829389f136bfabb5956c68d909e7bf3092a4e");
                        case QType.TAG: cast(repo.Tags, cs.system.collections.IDictionary).get_Item(target).Target;
        			}
                }
            }catch(e:Dynamic){
                context.Response.StatusCode = 404;
				handleResponseString('$qtype $target not found in repo/branch', context);
                return;
			};
            
            if(commit != null && repofilepath == null || repofilepath.length == 0){
                var enumerator:cs.system.collections.IEnumerator = commit.Ancestors.GetEnumerator();
        		while(enumerator.MoveNext()){
        			trace('${enumerator.Current} ${enumerator.Current.CommitDate} ${enumerator.Current.Message} ${enumerator.Current.Hash}');
        		}
            }
            
            //try getting a requested file (if any in repofilepath)
			try{
				var leaf:Dynamic = untyped __cs__("(commit as GitSharp.Commit).Tree[repofilepath];"); //these array accessors cannot work with haxe?
            
                if(null != leaf){
                    handleResponseLeaf(leaf, context);
                }else{
                    context.Response.StatusCode = 404;
    				handleResponseString('file $repofilepath not found in [$qtype/$target]', context);	
                }
					
				return;
			}catch(e:Dynamic){
				trace(e);
			};
			
			if(null != commit){
				//https://github.com/HaxeFoundation/haxe/issues/1903
				/*
				var ts : cs.system.threading.ThreadStart = function(){ GitHelper.parseTree(branch); };
				var thread1 = new cs.system.threading.Thread(ts);
				thread1.Start();	
				thread1.Join();
				*/
				try{
					var t = new haxe.Template(haxe.Resource.getString("index_template"));
					output = t.execute({filetree: GitHelper.parseTree(commit), breadcrumb: [cast(qtype, String), target]});
				}catch(e:Dynamic){ 
                    trace(e); 
                };
			}
		}else{
			
			var t = new haxe.Template(haxe.Resource.getString("branch_template"));
			
			var branches:Array<Dynamic> = new Array<Dynamic>();
			
			var count = 0;
			for(branch in GetBranches()){
				branches.push({count: count++, name: branch, link: '${branch.Fullname}/', lastmodified: branch.CurrentCommit.AuthorDate, msg: branch.CurrentCommit.Message});
			}
			
			
			try{
				for(tag in GetTags()){
					branches.push({count: count++, name: tag + " " + tag.Name, link: 'refs/tags/${tag.Name}/', lastmodified: tag.Target.AuthorDate, msg: tag.Target.Message});
				}
				output = t.execute({ rows : GetBranches(), type:"brrranches", branches: branches });
			}catch(e:Dynamic){trace(e);}
			
			/*
			cs.system.Console.set_ForegroundColor(cs.system.ConsoleColor.DarkRed);
			
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
            */
		}
			
		handleResponseString(output, context);
	}
	
    private static function handleResponseLeaf(leaf:Dynamic, context:HttpListenerContext, ?UTF8:Bool = true){
        handleResponse(UTF8 ? cs.system.text.Encoding.UTF8.GetBytes(cast(leaf.Data, String)) : leaf.RawData, context, Util.getMimeType(leaf.Path));
    }
    
	private static function handleResponseString(output:String, context:HttpListenerContext, ?UTF8:Bool = true){
		handleResponse(UTF8 ? cs.system.text.Encoding.UTF8.GetBytes(output) : haxe.io.Bytes.ofString(output).getData(), context, null);
	}
	
	private static function handleResponse(buffer:cs.NativeArray<UInt8>, context:HttpListenerContext, mimeType:String):Void {
		try{
			var response = context.Response, request = context.Request;
			if(request.Headers.Get("Accept-Encoding").indexOf("gzip") > -1){
				var ms:cs.system.io.MemoryStream = new cs.system.io.MemoryStream();
				var zip = new cs.system.io.compression.GZipStream(ms, cs.system.io.compression.CompressionMode.Compress);
				var oldSize = buffer.Length;
                zip.Write(buffer, 0, buffer.Length);
				zip.Close();
				
				
				//set new buffer to compressed stream
				buffer = ms.ToArray();
				
				var perc = Math.round(((buffer.Length - oldSize) / oldSize) * 100);
				trace('write gzipped stream ${Util.bytes2String(oldSize)} -> ${Util.bytes2String(buffer.Length)} [$perc% reduction of bytes]');
				response.AddHeader("Content-Encoding", "gzip");
			}
			
			if(null != mimeType){
				response.AppendHeader("Content-Type", mimeType);
			}
			
			response.AppendHeader("Server", "Gixen/Mono | " + VERSION);
			response.ContentLength64 = buffer.Length;
			response.OutputStream.Write(buffer, 0, buffer.Length);
			response.Close(); //close connection
		
		}catch(e:Dynamic){trace(e);};
	}
	

	
	
	
	
	
}
