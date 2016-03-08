typedef AppFunc = cs.system.Func_2<cs.system.collections.generic.IDictionary_2<String, Dynamic>, cs.system.threading.tasks.Task>;

/*
    https://github.com/james-world/owinmultihosting
    https://github.com/HaxeFoundation/HaxeManual/wiki/Haxe-C%23
    https://coding.abel.nu/2014/05/whats-this-owin-stuff-about/
    https://github.com/AndersAbel/OwinSelfHostTest/blob/master/OwinSelfHostExpanded/Handler.cs
 */
@:classCode("[assembly: OwinStartup(typeof(Gixen))]\n") //does not work, needs to be *Above* class
class Gixen { //optionally use class: Startup, to use owin default Startup.Configuration bootstrap
    
    static function main() 
	{
        microsoft.owin.hosting.WebApp.Start("http://localhost:4242", Configuration);
        cs.system.Console.ReadLine();
    }
    
    @:final
    public static function Configuration(appBuilder:owin.IAppBuilder):Void {
        
        var func:cs.system.Func_2<AppFunc, AppFunc> = BasicAuthenticationMiddleware;
        appBuilder.Use(func, new cs.NativeArray(0)); 
        
        microsoft.owin.extensions.IntegratedPipelineExtensions.UseStageMarker(appBuilder, owin.PipelineStage.MapHandler);
    }
    
    private static function BasicAuthenticationMiddleware(next:AppFunc):AppFunc
    {
        
       return function(context:cs.system.collections.generic.IDictionary_2<String, Dynamic>){ 
           trace(context.get_Item("owin.RequestPath"));
           var writer = new cs.system.io.StreamWriter(cast(context.get_Item("owin.ResponseBody"), cs.system.io.Stream));
           writer.Write("aap");
           writer.Close();
           cs.system.threading.Thread.Sleep(1000);
           return null;//new cs.system.threading.tasks.Task(cast next.Invoke(context));
       };
    }
    
}
