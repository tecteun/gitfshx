typedef FileTree = {
    file:String,
    mime:String, //detected mime type
    last_commit:Dynamic
}

class GitHelper{
    
    public static function parseTree(branch:Dynamic):Array<FileTree> {
        var retval = new Array<FileTree>();
        
        var parseLeaves:Dynamic->Void = function(tree:Dynamic){
            for(leaf in cs.Lib.array(tree.Leaves)){
                trace('Folder[${tree.Path}] ${leaf.Path}');
                trace(Util.getMimeType(leaf.Path));
                var last_commit = leaf.GetLastCommit(); //heavy function call; //https://github.com/henon/GitSharp/blob/master/GitSharp/AbstractTreeNode.cs
                trace(last_commit.CommitDate);
                retval.push({   
                                file:leaf.Path, 
                                mime:Util.getMimeType(leaf.Path),
                                last_commit: last_commit
                            });
            }
        }
        
        var subTree:Dynamic->Void = null;
        subTree = function(tree:Dynamic){
            parseLeaves(tree);
            for(tree in cs.Lib.array(tree.Trees)){
                parseLeaves(tree);
                if(tree.Trees.Length > 0){
                    subTree(tree);
                }
            }
        }
        
        //start parsing at lowest level tree
        subTree(branch.CurrentCommit.Tree);
        
        
        
        /*
        for(tree in cs.Lib.array(branch.CurrentCommit.Tree.Trees)){
		
			trace("path: " + tree.Path + " contains " + cs.Lib.array(tree.Leaves).length + " leaves");
			//var enumerable:cs.system.collections.IEnumerator = tree.GetHistory();
			//trace(enumerable);
			//trace(tree.GetHistory().ToArray());
			for(leaf in cs.Lib.array(tree.Leaves)){
				trace(leaf.Path);
				trace(Util.getMimeType(leaf.Path));
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
					
					//trace(leaf.GetLastCommit().Data);
					//trace(enumerable.Current);
					//trace(enumerable.Current.Data);
					//trace(enumerable.MoveNext());
					//trace("test " + enumerable.Current);
					
					
					//for(leaf in leaf.GetHistory()){
				    //trace(leaf.Data);
					//}
				}
				//trace(leaf.Data);
				
			}
		}*/
        return retval;
    }
}