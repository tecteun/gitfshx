package;
import haxe.web.Dispatch;
import cs.NativeArray;

/**
 * https://gist.github.com/textarcana/1306223 
 */
//@:CsNative("using Microsoft.AspNet.Builder")
//@:CsNative("using System.Net")

//@:classCode("using System.Linq;\n")
class Index
{
	static var _listener;
	/**
	 * Required main starting point of our application.
	 */
	static function main() 
	{
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
		var s:String = untyped __cs__("GitSharp.Repository.FindRepository(\".\")");
		trace(untyped __cs__("GitSharp.Repository.IsValid(s)"));
		var repo = untyped __cs__("new GitSharp.Repository(s)");

		trace(untyped __cs__("new GitSharp.Repository(s).Get<GitSharp.Branch>(\"master\")"));
		var branch:Dynamic = (untyped __cs__("new GitSharp.Repository(s).Get<GitSharp.Branch>(\"master\")")); //GitSharp.Branch
		//trace(branch.Fullname);
		//var leaves:Iterator<Dynamic>= cast(branch.CurrentCommit.Tree.Leaves.Cast<());
		trace(branch.CurrentCommit.ShortHash);
		for(tree in cs.Lib.array(branch.CurrentCommit.Tree.Trees)){
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
		trace("serv");
		_listener = untyped __cs__("new System.Net.HttpListener()");
		_listener.Prefixes.Add("http://*:1234/");
	    _listener.Start();
		_listener.BeginGetContext(new cs.system.AsyncCallback(GetContextCallback), null);
		while(true){
			
		}
	}
	
	//http://mikehadlow.blogspot.no/2006/07/playing-with-httpsys.html
	private static function GetContextCallback(result:cs.system.IAsyncResult):Void{
		var context = _listener.EndGetContext(result);
		trace(context.Request);
		trace(context.Response);
		trace(context.Request.Url.AbsoluteUri);
		_listener.BeginGetContext(new cs.system.AsyncCallback(GetContextCallback), null);
	}
	
}


class Branch {
	
}