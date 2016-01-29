package;
import haxe.web.Dispatch;
import cs.NativeArray;
/**
 * https://gist.github.com/textarcana/1306223 
 */
@:CsNative("using Microsoft.AspNet.Builder")
class Index
{
	
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
		
		for(leaf in cs.Lib.array(branch.CurrentCommit.Tree.Leaves)){
			trace(leaf.Path);
			trace(leaf.Data);
			
		}
		
		
	}
}


class Branch {
	
}