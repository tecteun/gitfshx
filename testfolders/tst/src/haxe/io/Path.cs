
#pragma warning disable 109, 114, 219, 429, 168, 162
namespace haxe.io {
	public class Path : global::haxe.lang.HxObject {
		
		public Path(global::haxe.lang.EmptyObject empty) {
		}
		
		
		public Path() {
			global::haxe.io.Path.__hx_ctor_haxe_io_Path(this);
		}
		
		
		public static void __hx_ctor_haxe_io_Path(global::haxe.io.Path __temp_me26) {
		}
		
		
		public static string addTrailingSlash(string path) {
			unchecked {
				if (( path.Length == 0 )) {
					return "/";
				}
				
				int c1 = global::haxe.lang.StringExt.lastIndexOf(path, "/", default(global::haxe.lang.Null<int>));
				int c2 = global::haxe.lang.StringExt.lastIndexOf(path, "\\", default(global::haxe.lang.Null<int>));
				if (( c1 < c2 )) {
					if (( c2 != ( path.Length - 1 ) )) {
						return global::haxe.lang.Runtime.concat(path, "\\");
					}
					else {
						return path;
					}
					
				}
				else if (( c1 != ( path.Length - 1 ) )) {
					return global::haxe.lang.Runtime.concat(path, "/");
				}
				else {
					return path;
				}
				
			}
		}
		
		
		public static new object __hx_createEmpty() {
			return new global::haxe.io.Path(global::haxe.lang.EmptyObject.EMPTY);
		}
		
		
		public static new object __hx_create(global::Array arr) {
			return new global::haxe.io.Path();
		}
		
		
	}
}


