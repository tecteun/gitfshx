package;
import haxe.web.Dispatch;

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
		var s:String = untyped __cs__("GitSharp.Repository.FindRepository(\"/Users/tecteun/work/svn-checkouts/rtl_dash\")");
		trace(untyped __cs__("GitSharp.Repository.IsValid(s)"));
		var repo = untyped __cs__("new GitSharp.Repository(s)");
		trace(untyped __cs__("new GitSharp.Repository(s).Get<GitSharp.Branch>(\"master\")"));
		var branch = (untyped __cs__("new GitSharp.Repository(s).Get<GitSharp.Branch>(\"master\")"));
		var leaves:Array<Dynamic<{Path:String}>> = (branch.CurrentCommit.Tree.Leaves);
		for(l in leaves){
			trace(l);
		}
		
	}
	
	
}