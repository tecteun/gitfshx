using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using LibGit2Sharp;
namespace Gitver.Controllers
{
    public class GitController : ApiController
    {

        public IHttpActionResult GetRequest(string id)
        {
            System.Diagnostics.Debug.WriteLine("aap");
            Repository r;
           
                r = new Repository("C:\\Users\\tecteun\\Documents\\Visual Studio 2015\\git");
                //Get the root tree of the most recent commit


                foreach (Branch entry in r.Branches)
                {
                    r.Checkout(entry);
                    foreach (Commit c in entry.Commits)
                    {
                        System.Diagnostics.Debug.WriteLine(c.Id);
                        foreach (Note n in c.Notes)
                        {
                            //   System.Diagnostics.Debug.WriteLine(entry.Name +" "+ n.Message.Trim());
                        }

                        foreach (TreeEntry t in c.Tree)
                        {
                            if(t.TargetType == TreeEntryTargetType.Tree)
                            {
                                System.Diagnostics.Debug.WriteLine("subtree");
                                foreach (TreeEntry tt in (Tree)t.Target)
                                {
                                    System.Diagnostics.Debug.WriteLine(" aa file " + tt.Path + " " + tt.TargetType);
                                    if(tt.TargetType == TreeEntryTargetType.Blob)
                                    {
                                         System.Diagnostics.Debug.WriteLine(tt.Path + " content : " + ((Blob)tt.Target).GetContentText());
                                    }
                                }
                            }else
                            {
                                System.Diagnostics.Debug.WriteLine(" aa file " + t.Path + " " + t.TargetType);
                            }

                            

                        }
                    }
                    /*
                    foreach (KeyValuePair<string, Tag> entry in r.Tags)
                    {
                        System.Diagnostics.Debug.WriteLine(entry.Key);
                    }
                    System.Diagnostics.Debug.WriteLine(entry.Key);
                    
                    string string_data = new Blob(r, entry.Value.CurrentCommit.Hash).Data;
                    var branch = r.Get<Tree>(entry.Value.CurrentCommit.Hash);
                    //System.Diagnostics.Debug.WriteLine(branch.);

                    System.Diagnostics.Debug.WriteLine(string_data);
                    */
                }
                /*
                //Now you can browse throught that tree by iterating over its child trees
                foreach (Tree subtree in tree.Trees)
                {
                    System.Diagnostics.Debug.WriteLine(subtree.Path);
                    //Or printing the names of the files it contains
                    foreach (Leaf leaf in subtree.Leaves)
                        System.Diagnostics.Debug.WriteLine(leaf.Path);
                }

                */
           
  
            return Ok(id);
        }
        

    }
}
