typedef AppFunc = cs.system.Func_2<cs.system.collections.generic.IDictionary_2<String, Dynamic>, cs.system.threading.tasks.Task>;

/*
    https://coding.abel.nu/2014/05/whats-this-owin-stuff-about/
    https://github.com/AndersAbel/OwinSelfHostTest/blob/master/OwinSelfHostExpanded/Handler.cs
 */
@:classCode("[assembly: OwinStartup(typeof(Startup))]\n")
class Gixen {
    
    static function main() 
	{
        
        //owin.IAppBuilder
        microsoft.owin.hosting.WebApp.Start("http://localhost:4242", Startup);
        cs.system.Console.ReadLine();
        
    }
    
    private static function Startup(appBuilder:owin.IAppBuilder):Void {
        var func:cs.system.Func_2<AppFunc, AppFunc> = BasicAuthenticationMiddleware;
        appBuilder.Use(func, new cs.NativeArray(0)); 
    }
    
    private static function BasicAuthenticationMiddleware(next:AppFunc):AppFunc
    {
       return function(context:cs.system.collections.generic.IDictionary_2<String, Dynamic>){ 
           trace(context.get_Item("owin.RequestPath"));
           var writer = new cs.system.io.StreamWriter(cast(context.get_Item("owin.ResponseBody"), cs.system.io.Stream));
           writer.Write("aap");
           writer.Close();
           cs.system.threading.Thread.Sleep(100);
           return new cs.system.threading.tasks.Task(cast next.Invoke(context));
       };
    }
    
}
