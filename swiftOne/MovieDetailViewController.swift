//
//  MovieDetailViewController.swift
//  swiftOne
//
//  Created by peter on 14-7-30.
//  Copyright (c) 2014 org.peter. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet var _movieImage: UIImageView
    @IBOutlet var avatarsTableView: UITableView
    var movieTitle:String = ""
    var movieAveragePoint:Double = 0
    var movieImage:String = ""
    var movie:NSDictionary = NSDictionary()
    var casts: NSDictionary[] = []
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
        
        
    }
    
    init(coder aDecoder: NSCoder!)  {
        super.init(coder: aDecoder)
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        

        var data:NSDictionary = movie["subject"] as NSDictionary
        self.title = data["title"] as? String
        self.casts = data["casts"] as NSDictionary[]
        
       
        
        let imgURL:NSURL=NSURL(string:movieImage)
        let request:NSURLRequest=NSURLRequest(URL: imgURL)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response:NSURLResponse!,data:NSData!,error:NSError!)->Void in
            var img=UIImage(data:data)
            self._movieImage.image = img
//            cell.image=img
//            self.imageCache[url]=img
            })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!{
        
        
        var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("castscell") as UITableViewCell
        
        if cell == nil {
            cell = UITableViewCell(style:.Subtitle,reuseIdentifier:"castscell")
        }
        
        if casts.count > 0 {
            var cast : NSDictionary = self.casts[indexPath.row] as NSDictionary
            var name : String? = cast["name"] as? String
            cell.detailTextLabel.text = name
            cell.textLabel.text = ""
            cell.image = UIImage(named:"Default.png")
            var avatars:NSDictionary = cast["avatars"] as NSDictionary
            var smallavatar: String = avatars["small"] as String
            
            let imgURL:NSURL=NSURL(string:smallavatar)
            let request:NSURLRequest=NSURLRequest(URL: imgURL)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response:NSURLResponse!,data:NSData!,error:NSError!)->Void in
                var img=UIImage(data:data)
                cell.image = img
                })
            
        }
        
        
        return cell
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        
        return self.casts.count
    }

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
