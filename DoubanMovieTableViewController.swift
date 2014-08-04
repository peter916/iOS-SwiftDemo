//
//  DoubanMovieTableViewController.swift
//  swiftOne
//
//  Created by peter on 14-7-28.
//  Copyright (c) 2014 org.peter. All rights reserved.
//

import UIKit

class DoubanMovieTableViewController: UITableViewController{
    
    @IBOutlet var loading: UIActivityIndicatorView
   //var tableView:UITableViewtitle
    var data = ["China","China","China"]
    
    var movieData:NSDictionary[] = []
    var movieImages:UIImage[] = []

//    init(style: UITableViewStyle) {
//        super.init(style: style)
//        // Custom initialization
//    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let manager = AFHTTPRequestOperationManager()
        let url = "https://api.douban.com/v2/movie/us_box"
        
        self.title = "loading..."
        self.loading.startAnimating()
        
        manager.GET(url, parameters: nil,
            success:{(operation:AFHTTPRequestOperation!,responseObject:AnyObject!) in
                
                let dictionary = responseObject as NSDictionary!
                self.movieData = dictionary["subjects"] as NSDictionary[]
                var movie:NSDictionary = self.movieData[0]["subject"] as NSDictionary
//                self.loadMovieImages()
                
                self.tableView.reloadData()
                var time = dictionary["date"] as String
                self.loading.stopAnimating()
                self.loading.hidden = true
                self.title = "北美票房榜\(time)"
            },
            failure: {(operation:AFHTTPRequestOperation!, error:NSError!) in
                println("error:"+error.description!)
            })
        
      // self.tableView.registerClass(MovieTableViewCell.self, forCellReuseIdentifier: "movieCell")
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // #pragma mark - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.movieData.count
    }

    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        
        var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("movieCell") as UITableViewCell
        
        if cell == nil {
            cell = UITableViewCell(style:.Subtitle,reuseIdentifier:"movieCell")
        }
        
        
        if movieData.count > 0 {
            var movie:NSDictionary = self.movieData[indexPath.row]["subject"] as NSDictionary
            var movieTitle: String? = movie["title"] as? String
            var rating = movie["rating"] as NSDictionary
            var average = rating["average"] as Double
            cell.textLabel.text = movieTitle
            
            cell.detailTextLabel.text = "平均分\(average)"

            var images: NSDictionary = movie["images"] as NSDictionary
            var imageUrl: String! = images["small"] as? String
            cell.image = UIImage(named:"Default.png")
            
            if imageUrl {
                let imgURL:NSURL=NSURL(string:imageUrl)
                let request:NSURLRequest=NSURLRequest(URL: imgURL)
                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response:NSURLResponse!,data:NSData!,error:NSError!)->Void in
                    var img=UIImage(data:data)
                    cell.image = img
                    
                    })
            }
            
            
        }

        return cell
    }
    
    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        
        
        var nextView = self.storyboard.instantiateViewControllerWithIdentifier("MovieDetailView") as MovieDetailViewController!
        //#########################################
        var index = indexPath.row
        var movie = movieData[index]["subject"] as NSDictionary
        var title = movie["title"] as String
        var rating = movie["rating"] as NSDictionary
        var images = movie["images"] as NSDictionary
        
        var data : NSDictionary = movieData[index] as NSDictionary
        nextView.movieTitle = title
        nextView.movieImage = images["large"] as String
        nextView.movie = data
        
        if let averageResult = rating["average"] as? Double {
            nextView.movieAveragePoint = rating["average"] as Double
        }
        
        //        nextView.movieAverage = rating["average"] as String!
        self.navigationController.pushViewController(nextView, animated: true)
        
    }
 
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView?, canEditRowAtIndexPath indexPath: NSIndexPath?) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView?, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath?) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView?, moveRowAtIndexPath fromIndexPath: NSIndexPath?, toIndexPath: NSIndexPath?) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView?, canMoveRowAtIndexPath indexPath: NSIndexPath?) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
