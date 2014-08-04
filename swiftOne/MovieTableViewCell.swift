//
//  MovieTableViewCell.swift
//  swiftOne
//
//  Created by peter on 14-7-29.
//  Copyright (c) 2014 org.peter. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {


 
    @IBOutlet var movieImageView: UIImageView
    @IBOutlet var movieTitleLabel: UILabel
    var movieImage:String? = ""
    var movieTitle:String? = ""
    
    
    
    init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style:style, reuseIdentifier: reuseIdentifier)
        
    }
    
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
    }
    
    
    func loadCell(){
        
        println(movieTitle)
        println(movieImage)
        if movieTitle {
            self.movieTitleLabel.text = movieTitle!
        }
        if movieImage {
            let imgURL:NSURL=NSURL(string:movieImage)
            let request:NSURLRequest=NSURLRequest(URL: imgURL)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response:NSURLResponse!,data:NSData!,error:NSError!)->Void in
                var img=UIImage(data:data)
                self.movieImageView.image = img
                })
        }
       
        
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
