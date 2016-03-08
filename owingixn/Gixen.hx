

typedef AppFunc = cs.system.Func_2<cs.system.collections.generic.IDictionary_2<String, Dynamic>, cs.system.threading.tasks.Task>;

/*
    https://github.com/james-world/owinmultihosting
    https://github.com/HaxeFoundation/HaxeManual/wiki/Haxe-C%23
    https://coding.abel.nu/2014/05/whats-this-owin-stuff-about/
    https://github.com/AndersAbel/OwinSelfHostTest/blob/master/OwinSelfHostExpanded/Handler.cs
 */
@:classCode("[assembly: OwinStartup(typeof(Gixen))]\n") //does not work, needs to be *Above* class
class Gixen { //optionally use class: Startup, to use owin default Startup.Configuration bootstrap
    static var fp:sys.io.FileOutput;
    static function main() 
	{
        microsoft.owin.hosting.WebApp.Start("http://localhost:4242", Configuration);
        cs.system.Console.ReadLine();

    }
    
    private static function log(s:String){
        fp.writeString(s);
        fp.flush();
    }
    
    @:final
    public static function Configuration(appBuilder:owin.IAppBuilder):Void {
        
        var func:cs.system.Func_2<AppFunc, AppFunc> = BasicMiddleware;
        appBuilder.Use(func, new cs.NativeArray(0)); 
        
        fp = sys.io.File.append(cs.system.AppDomain.CurrentDomain.SetupInformation.ApplicationBase + "/log.txt", false);
        
         log("start");
        microsoft.owin.extensions.IntegratedPipelineExtensions.UseStageMarker(appBuilder, owin.PipelineStage.MapHandler);
    }
    
    private static function BasicMiddleware(next:AppFunc):AppFunc
    {
            cs.system.threading.Thread.Sleep(1000);
        return function(context:cs.system.collections.generic.IDictionary_2<String, Dynamic>):cs.system.threading.tasks.Task{ 
            log(context.get_Item("owin.RequestPath"));
            var stream = cast(context.get_Item("owin.ResponseBody"), cs.system.io.Stream);
            var headers:cs.system.collections.generic.IDictionary_2<String, cs.NativeArray<String>> = cast context.get_Item("owin.ResponseHeaders");
            headers.set_Item("Content-Length", cs.NativeArray.make(Std.string(0)));

            var buffer:cs.NativeArray<cs.StdTypes.UInt8> = cs.system.text.Encoding.UTF8.GetBytes("Hello world!");
            context.set_Item("owin.ResponseStatusCode", 200);
            headers.set_Item("Content-Length", cs.NativeArray.make(Std.string(buffer.Length)));
            headers.set_Item("Content-Type", cs.NativeArray.make("text/plain"));
    
        
            
            var tf = new cs.system.threading.tasks.TaskFactory();
            
            //using native haxe this gives: ambigous overload, possibly due to types of stream.BeginWrite
            return untyped __cs__("tf.FromAsync(stream.BeginWrite, stream.EndWrite, buffer, 0, buffer.Length, null, System.Threading.Tasks.TaskCreationOptions.AttachedToParent);");
            // var task:cs.system.threading.tasks.Task_1<Void> = t.StartNew(cast(function(){next.Invoke(context); }, cs.system.Func_1<Dynamic>));
            //no need to pass it down the chain here, there is no chain (yet)
            //return next.Invoke(context);
            //return task; 
       };
    }
    
}
