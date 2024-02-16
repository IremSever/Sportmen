//
//  VideosViewController.swift
//  Sportmen
//
//  Created by IREM SEVER on 15.02.2024.
//

import Foundation
import UIKit
class VideosViewController : UIViewController {
    
    @IBOutlet weak var videosTableView: UITableView!
    let videoViewModel = VideosViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.videoViewModel.dataSource = self
        self.videoViewModel.delegate = self
        loadVideoData()
    }
    private func loadVideoData() {
        videoViewModel.fetchVideosData { [weak self] in
            DispatchQueue.main.async {
                self?.videoViewModel.reloadData()
            }
        }
    }
}

extension VideosViewController: UITableViewDataSource, UITableViewDelegate {
    
    /*func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }*/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoViewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let videos = videoViewModel.cellForRowAt(indexPath: indexPath)
        
            let cell = videosTableView.dequeueReusableCell(withIdentifier: "videosCell", for: indexPath) as! VideosTableViewCell
            cell.setCellWithValuesOf(videos)
            print("videosCell")
            return cell
    }
}
