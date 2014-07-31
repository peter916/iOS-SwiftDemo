//
//  MovieDetailViewController.swift
//  swiftOne
//
//  Created by peter on 14-7-30.
//  Copyright (c) 2014 org.peter. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet var averageLabel: UILabel
    @IBOutlet var _movieImage: UIImageView
    var movieTitle:String = ""
    var movieAveragePoint:Double = 0
    var movieImage:String = ""
    
    
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
        //self.title = self.movie["title"] as String!
       // self.navigationController.navigationItem.leftBarButtonItem.title = "返回"
        self.title = movieTitle
        self.averageLabel.text = "\(movieAveragePoint)"
        println(movieImage)
        
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
    

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
