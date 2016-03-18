//
//  ViewController.swift
//  FileCenterTests
//
//  Created by default on 3/16/16.
//  Copyright © 2016 Rebel Creators. All rights reserved.
//

import UIKit
import FileCenter


class ViewController: UITableViewController {
    
    var images : [Image] = []
    
    class Image {
        var image : UIImage?
        var url : NSURL?
        var saveFileName : String = "file.png"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let folder = FileCenter.documents().folder("cars").folder("fast").folder("pics2")
        loadAllImagesInFolder(folder)
        // downloadAndSave()
    }
    
    func loadAllImagesInFolder(folder : Folder) {
        self.images = []
        for name in folder.list() {
            if let data = folder.file(name).fetch() {
                if let img = UIImage(data: data) {
                    let image = Image()
                    image.image = img
                    self.images.append(image)
                }
            }
        }
        
        self.tableView.reloadData()
    }
    
    func downloadAndSave() {
        images =  generate()
        
        for image in images {
            let file =  FileCenter.documents().folder("cars").folder("fast").folder("pics3").file(image.saveFileName)
            
            guard !file.exists() else {
                if let data = file.fetch() {
                    if let img = UIImage(data: data) {
                        image.image = img
                        self.tableView.reloadData()
                    }
                }
                continue
            }
            
            file.downloadable(image.url!)
                .success({ data in
                    if let img = UIImage(data: data) {
                        image.image = img
                        self.tableView.reloadData()
                    }
                }).failure({ error in
                    print(error.localizedDescription)
                }).save()
        }
    }
    
    func generate() -> [Image] {
        let paths = ["http://zombdrive.com/images/lamborghini-11.jpg","http://media.caranddriver.com/images/media/51/25-cars-worth-waiting-for-lp-ford-gt-photo-658253-s-original.jpg","http://www.consumerreports.org/content/dam/cro/news_articles/cars/2014-Porsche-911-GTS-driving-12-2015-Cars-II.png","http://static3.businessinsider.com/image/54d0e4c06bb3f707508f6847/the-30-hottest-exotic-cars-from-the-2015-geneva-motor-show.jpg","http://www.dodge.com/assets/images/vehicles/2016/viper/vlp/gallery/thumb/viper-gallery-05-thumb.jpg","http://cnet2.cbsistatic.com/hub/i/r/2015/01/12/95f60c3b-6041-4d15-92f1-9ad4073b8907/thumbnail/770x433/2f9cd5831572e23e223168e291448988/ford-gt-4778.jpg","http://cdn.slashgear.com/wp-content/uploads/2015/03/P2150984-alfa-romeo-4C-820x420.jpg","http://www.lotustalk.com/forums/attachments/f170/513465d1424361261-2016-lotus-evora-400-official-specifications-colour-choices-options-evora400-metallic-white-web.jpg"]
        var images : [Image] = []
        for string in paths {
            let image = Image()
            image.url = NSURL(string : string)
            image.saveFileName = "file-\(images.count).png"
            images.append(image)
        }
        
        return images
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 270.0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! ImageTableViewCell
        cell.cellImageView?.image = self.images[indexPath.row].image
        
        return cell
    }
    
}

