
#pragma warning disable 109, 114, 219, 429, 168, 162
namespace sys {
	public class FileSystem : global::haxe.lang.HxObject {
		
		public FileSystem(global::haxe.lang.EmptyObject empty) {
		}
		
		
		public FileSystem() {
			global::sys.FileSystem.__hx_ctor_sys_FileSystem(this);
		}
		
		
		public static void __hx_ctor_sys_FileSystem(global::sys.FileSystem __temp_me27) {
		}
		
		
		public static bool isDirectory(string path) {
			bool isdir = global::System.IO.Directory.Exists(((string) (path) ));
			if (( isdir != global::System.IO.File.Exists(((string) (path) )) )) {
				return isdir;
			}
			
			throw global::haxe.lang.HaxeException.wrap(global::haxe.lang.Runtime.concat(global::haxe.lang.Runtime.concat("Path \'", path), "\' doesn\'t exist"));
		}
		
		
		public static global::Array<object> readDirectory(string path) {
			unchecked {
				string[] ret = global::System.IO.Directory.GetFileSystemEntries(((string) (path) ));
				if (( ( ret as global::System.Array ).Length > 0 )) {
					string fst = ret[0];
					string sep = "/";
					if (( global::haxe.lang.StringExt.lastIndexOf(fst, sep, default(global::haxe.lang.Null<int>)) < global::haxe.lang.StringExt.lastIndexOf(fst, "\\", default(global::haxe.lang.Null<int>)) )) {
						sep = "\\";
					}
					
					{
						int _g1 = 0;
						int _g = ( ret as global::System.Array ).Length;
						while (( _g1 < _g )) {
							int i = _g1++;
							string path1 = ret[i];
							ret[i] = global::haxe.lang.StringExt.substr(path1, ( global::haxe.lang.StringExt.lastIndexOf(path1, sep, default(global::haxe.lang.Null<int>)) + 1 ), default(global::haxe.lang.Null<int>));
						}
						
					}
					
				}
				
				return new global::Array<object>(((object[]) (ret) ));
			}
		}
		
		
		public static new object __hx_createEmpty() {
			return new global::sys.FileSystem(global::haxe.lang.EmptyObject.EMPTY);
		}
		
		
		public static new object __hx_create(global::Array arr) {
			return new global::sys.FileSystem();
		}
		
		
	}
}


