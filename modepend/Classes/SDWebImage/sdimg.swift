
import SDWebImage
import Foundation


class sdimg:IMGSDK{
    
    override func calculateCacheSize(finish: @escaping (UInt) -> Void) {
        SDImageCache.shared.calculateSize { fileCount, size in
            finish(size)
        }
    }
    
    override func clearDiscCache(finish:@escaping()->Void) {
        SDImageCache.shared.clearDisk {
            finish()
        }
    }
    
    override func clearMemoryCache(finish: @escaping () -> Void) {
        
        SDImageCache.shared.clearMemory()
        finish()
    }
    
    override func cache(for url: String, finish: @escaping (UIImage?) -> Void) {
        SDImageCache.shared.queryCacheOperation(forKey: url) { img, data, cacheType in
            finish(img)
        }
    }
    
    
    override func setImage(imageView: UIImageView, with url: String, placeholder: UIImage?, finish:@escaping (UIImage?) -> Void) {
        let handler = imageView.finishDidLoadImage

        imageView.sd_setImage(with: URL(string: url), placeholderImage:placeholder) { img, error, cacheType, url in
            
            handler?(img)
            finish(img)
        }
    }
    
    override func download(for url: String, progress: @escaping (CGFloat) -> Void, finish: @escaping (UIImage?, String?) -> Void) -> Any? {
        let task = SDWebImageDownloader.shared.downloadImage(with: URL(string: url), options: SDWebImageDownloaderOptions.highPriority, context: nil, progress: nil) { (image, data, err, b) in
            
            if let img = image{
                finish(img,nil)
            }else{
                if let err_ = err{
                    finish(nil,"\(err_)")
                }
                else{
                    finish(nil,"未知错误")
                }
            }
         }
        return task
    }
    
    override func cancel(task: Any) {
        if let task_ = task as? SDWebImageDownloadToken{
            task_.cancel()
        }
    }
}
