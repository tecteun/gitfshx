

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
    private static var taskFactory:cs.system.threading.tasks.TaskFactory = null;
    static function main() 
	{
        init();
        //bootstrap owin standalone webapp.
        microsoft.owin.hosting.WebApp.Start("http://localhost:4242", Configuration);
        cs.system.Console.ReadLine();

    }
    
    private static function init(){
        taskFactory = new cs.system.threading.tasks.TaskFactory();
    }
    
    private static function log(s:String){
        fp.writeString(s + "\n\r");
        fp.flush();
    }
    
    @:final
    public static function Configuration(appBuilder:owin.IAppBuilder):Void {
        init();
        fp = sys.io.File.append(cs.system.AppDomain.CurrentDomain.SetupInformation.ApplicationBase + "/log.txt", false);
        log('Configuration-> start ${cs.system.AppDomain.CurrentDomain.SetupInformation.ApplicationName}');
        
        //bootstrap owin
        var func:cs.system.Func_2<AppFunc, AppFunc> = BasicMiddleware;
        appBuilder.Use(func, new cs.NativeArray(0)); 
        microsoft.owin.extensions.IntegratedPipelineExtensions.UseStageMarker(appBuilder, owin.PipelineStage.MapHandler);
    }
    
    private static function BasicMiddleware(next:AppFunc):AppFunc
    {
        return function(context:cs.system.collections.generic.IDictionary_2<String, Dynamic>):cs.system.threading.tasks.Task{ 
            var date = Date.now().getTime();
            var stream:cs.system.io.Stream = context.get_Item("owin.ResponseBody");
            var headers:cs.system.collections.generic.IDictionary_2<String, cs.NativeArray<String>> = context.get_Item("owin.ResponseHeaders");
            //headers.set_Item("Content-Length", cs.NativeArray.make(Std.string(0)));

            var buffer:cs.NativeArray<cs.StdTypes.UInt8> = cs.system.text.Encoding.UTF8.GetBytes("Hello world! " + context.get_Item("owin.RequestPath") + " " + date);
            context.set_Item("owin.ResponseStatusCode", 200);
            headers.set_Item("Content-Length", cs.NativeArray.make(Std.string(buffer.Length)));
            headers.set_Item("Content-Type", cs.NativeArray.make("text/plain"));
            
            var func = function(){ 
                //do som async
                cs.system.threading.Thread.Sleep(1000);
                stream.Write(buffer, 0, buffer.Length);
                stream.Flush();
                stream.Close();
                next.Invoke(context);
            };
            
            //var task:cs.system.threading.tasks.Task = untyped __cs__("tf.FromAsync(stream.BeginWrite, stream.EndWrite, buffer, 0, buffer.Length, null, System.Threading.Tasks.TaskCreationOptions.AttachedToParent);");
            return taskFactory.StartNew(new cs.system.Action(func));
       };
    }
    
}
