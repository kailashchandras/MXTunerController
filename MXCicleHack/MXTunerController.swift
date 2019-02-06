//
//  ViewController.swift
//  MXCicleHack
//
//  Created by Kailashchandra on 05/02/19.
//  Copyright © 2019 Kailashchandra. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class MXTunerController: UICollectionViewController {
    
    var avPlayer: AVPlayer!
    var socialView: UIView!
    let images = Bundle.main.paths(forResourcesOfType: "jpg", inDirectory: nil)
    var overlayView: MXOverlayMoodView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Register cell classes
        
        collectionView!.register(UINib(nibName: "Cellitem", bundle: nil), forCellWithReuseIdentifier: "cell")
        let imageView = UIImageView(image: UIImage(named: "bg-dark.jpg"))
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        collectionView!.backgroundView = imageView
        
        let pieChartView = MXOverlayMoodView()
        pieChartView.frame = CGRect(x: -150, y: self.view.frame.height/2 - 150, width: 300, height: 300)
        
        pieChartView.backgroundColor = .clear
        pieChartView.segments.append(Segment(color: .gray, value: 10, img:UIImage.init(named: "icon-1.png")!))
        pieChartView.segments.append(Segment(color: .gray, value: 10, img:UIImage.init(named: "icon-2.png")!))
        pieChartView.segments.append(Segment(color: .gray, value: 10, img:UIImage.init(named: "icon-3.png")!))
        pieChartView.segments.append(Segment(color: .gray, value: 10, img:UIImage.init(named: "icon-4.png")!))
        pieChartView.segments.append(Segment(color: .gray, value: 10, img:UIImage.init(named: "icon-5.png")!))
        pieChartView.segments.append(Segment(color: .gray, value: 10, img:UIImage.init(named: "icon-6.png")!))
        pieChartView.segments.append(Segment(color: .gray, value: 10, img:UIImage.init(named: "icon-1.png")!))
        pieChartView.segments.append(Segment(color: .gray, value: 10, img:UIImage.init(named: "icon-2.png")!))
        pieChartView.segments.append(Segment(color: .gray, value: 10, img:UIImage.init(named: "icon-3.png")!))
        pieChartView.segments.append(Segment(color: .gray, value: 10, img:UIImage.init(named: "icon-4.png")!))
        pieChartView.segments.append(Segment(color: .gray, value: 10, img:UIImage.init(named: "icon-5.png")!))
        pieChartView.segments.append(Segment(color: .gray, value: 10, img:UIImage.init(named: "icon-6.png")!))
        pieChartView.segments.append(Segment(color: .gray, value: 10, img:UIImage.init(named: "icon-1.png")!))
        pieChartView.segments.append(Segment(color: .gray, value: 10, img:UIImage.init(named: "icon-2.png")!))
        pieChartView.segments.append(Segment(color: .gray, value: 10, img:UIImage.init(named: "icon-3.png")!))
        pieChartView.segments.append(Segment(color: .gray, value: 10, img:UIImage.init(named: "icon-4.png")!))
        
        let mxplayer = UIImageView(image: UIImage.init(named:"mxplayer.png")!)
        mxplayer.frame = CGRect(x: 115, y: 115, width: 70, height: 70);
        pieChartView.addSubview(mxplayer)
        pieChartView.bringSubview(toFront: mxplayer);

        self.view.addSubview(pieChartView)

        avPlayer = AVPlayer(url: URL(string:"https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")!)
        

        
        let avPlayerController = AVPlayerViewController()
        
        avPlayerController.player = avPlayer;
        avPlayerController.view.frame = CGRect(x: 350, y: 57, width: 350, height: 200);
        
        self.addChildViewController(avPlayerController)
        self.view.addSubview(avPlayerController.view);
        

        avPlayerController.player?.play()
        self.view.addSubview(avPlayerController.view)
        
        socialView = UIView()
        socialView.frame = CGRect(x: 310, y: 80, width: 50, height: 180);
        self.view.addSubview(socialView)
        
        let twitter = UIImageView(image: UIImage.init(named:"icons8-twitter-48.png")!)
        twitter.frame  = CGRect(x: 0, y: 0, width: 20, height: 20);
        let fb = UIImageView(image: UIImage.init(named:"icons8-facebook-48.png")!)
        fb.frame = CGRect(x: 0, y: 50, width: 20, height: 20);
        let insta = UIImageView(image: UIImage.init(named:"icons8-instagram-48.png")!)
        insta.frame = CGRect(x: 0, y: 100, width: 20, height: 20);
        let yt = UIImageView(image: UIImage.init(named:"icons8-youtube-48.png")!)
        yt.frame = CGRect(x: 0, y: 150, width: 20, height: 20);
        
        socialView.addSubview(twitter)
        socialView.addSubview(fb)
        socialView.addSubview(insta)
        socialView.addSubview(yt)
        
        let sumeryView = UIImageView(image: UIImage.init(named:"temp.png")!)
        sumeryView.frame = CGRect(x: 330, y: 300, width: 350, height: 100);
        self.view.addSubview(sumeryView)
    }
    
}

extension MXTunerController {
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! CellItem
        cell.imageName = images[indexPath.row]
        return cell as UICollectionViewCell
    }
    
}

