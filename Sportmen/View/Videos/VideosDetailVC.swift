//
//  VideosDetailVC.swift
//  Sportmen
//
//  Created by İrem Sever on 19.02.2024.
//
import WebKit
import UIKit

class VideosDetailVC: UIViewController {
    
    @IBOutlet weak var videosWKWebView: WKWebView!
    @IBOutlet weak var videosDetailTitle: UILabel!
    @IBOutlet weak var videosDetailPublishedDate: UILabel!
    @IBOutlet weak var videosDetailSpot: UILabel!
    @IBOutlet weak var videosDetailSource: UILabel!
    @IBOutlet weak var videosDetailSourceImg: UIImageView!
    @IBOutlet weak var videosSubscribeButton: UIButton!
    
    var selectedVideos: VideoResponse?
    var videoURLString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let videos = selectedVideos {
            setVideosDetailWithValuesOf(videos)
        }
    }
    
    func setVideosDetailWithValuesOf(_ videos: VideoResponse) {
        self.videosDetailTitle.text = videos.title
        self.videosDetailSource.text = videos.channelTitle?.rawValue
        self.videosDetailSpot.text = videos.description
        self.videosDetailPublishedDate.text = videos.publishDate
        // Set video URL
        self.videoURLString = videos.url
        
        // Load video into WKWebView
        if let videoURLString = videoURLString,
           let videoURL = URL(string: videoURLString) {
            let request = URLRequest(url: videoURL)
            videosWKWebView.load(request)
        } else {
            print("No video URL provided")
        }
        
        // Load channel images
        if let channelImages = videos.channelImages {
            if let imageURL = URL(string: channelImages.medium) {
                getImageDataFrom(url: imageURL)
            }
        } else {
            self.videosDetailSourceImg.image = UIImage(named: "noImageAvailable")
        }
    }
    private func getImageDataFrom(url: URL) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No image data")
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self.videosDetailSourceImg.image = image
                }
            }
        }.resume()
    }
}
