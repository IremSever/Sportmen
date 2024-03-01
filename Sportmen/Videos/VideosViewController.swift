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
        self.videosTableView.dataSource = self
        self.videosTableView.delegate = self
        loadVideoData()
        
        navigationBarDesign()
    }
    private func loadVideoData() {
        videoViewModel.fetchVideosData { [weak self] result in
            DispatchQueue.main.async {
                self?.videosTableView.reloadData()
            }
        }
    }
    
    func showVideosDetail(_ videos: VideoResponse) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let videosDetailVC = storyboard.instantiateViewController(withIdentifier: "VideosDetailVC") as? VideosDetailVC {
            videosDetailVC.selectedVideos = videos
            navigationController?.pushViewController(videosDetailVC, animated: true)
        }
    }
    
    func navigationBarDesign() {
        let imgAppIcon = UIImageView(image: UIImage(named: "icon_mainmenu"))
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: imgAppIcon)
        
        let lblTitleCategory = "Videos"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: lblTitleCategory)
        
        videosTableView.reloadData()
    }
}

extension VideosViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedVideos = videoViewModel.cellForRowAt(indexPath: indexPath)
        showVideosDetail(selectedVideos)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 355
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoViewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let videos = videoViewModel.cellForRowAt(indexPath: indexPath)
        
        let cell = videosTableView.dequeueReusableCell(withIdentifier: "videosCell", for: indexPath) as! VideosTableViewCell
        cell.setCellWithValuesOf(videos)
        return cell
    }
}
