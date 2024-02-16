//
//  VideosViewModel.swift
//  Sportmen
//
//  Created by IREM SEVER on 15.02.2024.
//

import Foundation

class VideosViewModel {
    private var videosWebService = VideosWebservice()
    private var videos = [VideoResponse]()
    
    func fetchVideosData(completion: @escaping() -> ()) {
        videosWebService.getVideosData { [weak self] result in
            switch result {
            case .success(let videosData):
                self?.videos = videosData.data?.list.response ?? []
                completion()
            case .failure(let error):
                print("Error processing json data: \(error)")
            }
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return videos.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> VideoResponse {
        return videos[indexPath.row]
    }
}
