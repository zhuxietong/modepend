import Kingfisher
import UIKit


class kfimg:IMGSDK{
    
    override func cache(for url: String, finish:@escaping(UIImage?) -> Void) {
        let img = ImageCache.default.retrieveImageInMemoryCache(forKey: url)
        if img == nil{
       
            ImageCache.default.retrieveImageInDiskCache(forKey: url) { (result) in
                switch result {
                case .success(let value):
                
                    if let img = value?.images?.first{
                        finish(img)
                    }else{
                        finish(nil)
                    }
                    
                    
                    case .failure(let error):
                        finish(nil)
                }
                
            }
        }else{
            finish(img)
        }

        
    }
    
    
    override func clearDiscCache(finish: @escaping () -> Void) {
        KingfisherManager.shared.cache.clearDiskCache {
            finish()
        }
    }
    
    override func clearMemoryCache(finish: @escaping () -> Void) {
    
        KingfisherManager.shared.cache.clearMemoryCache()
        finish()
    }
    
    override func calculateCacheSize(finish: @escaping (UInt) -> Void) {
        KingfisherManager.shared.cache.calculateDiskStorageSize { result in
            
            switch result {
            case .failure:
                finish(0)
            case .success(let size):
                finish(size)
            }
        }
    }
    override func setImage(imageView:UIImageView, with url: String, placeholder: UIImage?, finish:@escaping (UIImage?) -> Void) {
        
        guard let url_ = URL(string: url) else{return}

        
        let handler = imageView.finishDidLoadImage
        
        
        imageView.kf.setImage(with: url_, placeholder: placeholder, options: [.transition(ImageTransition.fade(0.5))], progressBlock: nil) { result in
        
            switch (result){
            case .success(let r):
                handler?(r.image)
                finish(r.image)
            case .failure:
                handler?(nil)
                finish(nil)
            }
        
        }

        
    }
    
    override func download(for url: String, progress:@escaping(CGFloat) -> Void, finish: @escaping (UIImage?, String?) -> Void)->Any? {
        

        guard let url_ = URL(string: url) else{return nil}
        let task = KingfisherManager.shared.retrieveImage(with: url_, options: nil, progressBlock: { (received, expected) in
            let progress_ = expected == 0 ? 0 : received / expected
            progress(CGFloat(progress_))
        }, downloadTaskUpdated: nil) { (result) in
                
            switch result{
            case .success(let res):
                finish(res.image,nil)
                break
            case .failure(let error):
                finish(nil,"\(error)")
                break
            }
        }
        return task
    }
    
    override func cancel(task: Any) {
        if let task = task as? DownloadTask
        {
            task.cancel()
        }
    }
    
}
