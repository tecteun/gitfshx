
#pragma warning disable 109, 114, 219, 429, 168, 162
public class Index : global::haxe.lang.HxObject {
	
	public static void Main(){
		global::cs.Boot.init();
		main();
	}
	public Index(global::haxe.lang.EmptyObject empty) {
	}
	
	
	public Index() {
		global::Index.__hx_ctor__Index(this);
	}
	
	
	public static void __hx_ctor__Index(global::Index __temp_me7) {
	}
	
	
	public static void main() {
		unchecked {
			global::haxe.lang.Function[] parseFolder = new global::haxe.lang.Function[]{null};
			parseFolder[0] = new global::Index_main_14__Fun(parseFolder);
			string s = GitSharp.Repository.FindRepository("/Users/tecteun/work/svn-checkouts/rtl_dash");
			global::haxe.Log.trace.__hx_invoke2_o(default(double), GitSharp.Repository.IsValid(s), default(double), new global::haxe.lang.DynamicObject(new int[]{302979532, 1547539107, 1648581351}, new object[]{"main", "Index", "Index.hx"}, new int[]{1981972957}, new double[]{((double) (27) )}));
			object repo = new GitSharp.Repository(s);
			global::haxe.Log.trace.__hx_invoke2_o(default(double), new GitSharp.Repository(s).Get<GitSharp.Branch>("master"), default(double), new global::haxe.lang.DynamicObject(new int[]{302979532, 1547539107, 1648581351}, new object[]{"main", "Index", "Index.hx"}, new int[]{1981972957}, new double[]{((double) (29) )}));
			object branch = new GitSharp.Repository(s).Get<GitSharp.Branch>("master");
			global::Array leaves = ((global::Array) (global::haxe.lang.Runtime.getField(global::haxe.lang.Runtime.getField(global::haxe.lang.Runtime.getField(branch, "CurrentCommit", 1920680176, true), "Tree", 937215358, true), "Leaves", 1259313084, true)) );
			{
				int _g2 = 0;
				while (( global::haxe.lang.Runtime.compare(_g2, ((int) (global::haxe.lang.Runtime.getField_f(leaves, "length", 520590566, true)) )) < 0 )) {
					object l = leaves[_g2];
					 ++ _g2;
					global::haxe.Log.trace.__hx_invoke2_o(default(double), l, default(double), new global::haxe.lang.DynamicObject(new int[]{302979532, 1547539107, 1648581351}, new object[]{"main", "Index", "Index.hx"}, new int[]{1981972957}, new double[]{((double) (33) )}));
				}
				
			}
			
		}
	}
	
	
	public static new object __hx_createEmpty() {
		return new global::Index(global::haxe.lang.EmptyObject.EMPTY);
	}
	
	
	public static new object __hx_create(global::Array arr) {
		return new global::Index();
	}
	
	
}



#pragma warning disable 109, 114, 219, 429, 168, 162
public class Index_main_14__Fun : global::haxe.lang.Function {
	
	public Index_main_14__Fun(global::haxe.lang.Function[] parseFolder) : base(1, 0) {
		this.parseFolder = parseFolder;
	}
	
	
	public override object __hx_invoke1_o(double __fn_float1, object __fn_dyn1) {
		string folder = ( (( __fn_dyn1 == global::haxe.lang.Runtime.undefined )) ? (global::haxe.lang.Runtime.toString(__fn_float1)) : (global::haxe.lang.Runtime.toString(__fn_dyn1)) );
		folder = global::haxe.io.Path.addTrailingSlash(folder);
		object retval = new global::haxe.lang.DynamicObject(new int[]{}, new object[]{}, new int[]{}, new double[]{});
		bool fsubfolder = false;
		string path = null;
		{
			int _g = 0;
			global::Array<object> _g1 = global::sys.FileSystem.readDirectory(folder);
			while (( _g < _g1.length )) {
				string rawpath = global::haxe.lang.Runtime.toString(_g1[_g]);
				 ++ _g;
				path = global::haxe.lang.Runtime.concat(folder, rawpath);
				if (global::sys.FileSystem.isDirectory(path)) {
					fsubfolder = true;
					global::Reflect.setField(retval, rawpath, ((object) (this.parseFolder[0].__hx_invoke1_o(default(double), path)) ));
				}
				
			}
			
		}
		
		if (( fsubfolder == false )) {
			return global::sys.FileSystem.readDirectory(folder);
		}
		else {
			return retval;
		}
		
	}
	
	
	public global::haxe.lang.Function[] parseFolder;
	
}


