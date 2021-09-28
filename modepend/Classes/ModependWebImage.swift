import UIKit
import Foundation

class IMGSDK:NSObject{
    required override init() {
        super.init()
    }
 
    
    
    open func clearDiscCache(finish:@escaping()->Void) {

    }
    
    open func clearMemoryCache(finish:@escaping()->Void) {

    }
    
    
    open func calculateCacheSize(finish:@escaping(UInt)->Void) {

    }
    
   
    
    open func cache(for url: String, finish:@escaping(UIImage?) -> Void) {
        
    }
    
    open func download(for url: String,progress:@escaping(CGFloat)->Void, finish:@escaping(UIImage?,String?) -> Void)->Any? {
        
        return nil
    }
    
    open func cancel(task:Any){
        
    }
    
    open func setImage(imageView:UIImageView, with url: String, placeholder: UIImage?, finish: @escaping(UIImage?) -> Void) {

    }
}

@objc public class ModependWebImage:NSObject{
    
    static var share_:ModependWebImage? = nil
    @objc public static var share:ModependWebImage{
        get{
            guard let share_obj = share_ else {
                let obj = ModependWebImage()
                share_ = obj
                return obj
            }
            return share_obj
        }
    }
    
    
    
    @objc var SDK:IMGSDK? = nil

    open func clearDiscCache(finish:@escaping()->Void) {
        SDK?.clearDiscCache(finish: finish)
    }
    
    open func clearMemoryCache(finish:@escaping()->Void) {
        SDK?.clearMemoryCache(finish: finish)
    }
    
    open func calculateCacheSize(finish:@escaping(UInt)->Void) {
        SDK?.calculateCacheSize(finish: finish)
    }
    
    open func cancel(task:Any){
        SDK?.cancel(task: task)
    }
    open func download(for url: String,progress:@escaping(CGFloat)->Void, finish:@escaping(UIImage?,String?) -> Void)->Any? {
        
        return SDK?.download(for:url, progress:progress, finish:finish)
    }
    open func cache(for url: String, finish:@escaping(UIImage?) -> Void) {
        SDK?.cache(for: url, finish: { img in
            finish(img)
        })
    }
    
    open func setImage(imageView:UIImageView, with url: String, placeholder: UIImage?, finish: (UIImage?) -> Void) {
        SDK?.setImage(imageView: imageView, with: url, placeholder: placeholder, finish: { img in
            
        })
    }

    
    
    
    public override init(){
        super.init()
        let sdks = [
            "sdimg",
            "kfimg",
        ]
        
        for k in sdks {
            if let a =  NSClassFromString("modepend.\(k)") as? IMGSDK.Type{
                let c = a.init()
                SDK = c
            }
        }
    }

}


public typealias FinishDidLoadImage = (UIImage?)->Void

extension UIImageView
{
    private struct __kfextention_keys {
        static var base = "__kfextention_keys_base"
    }
    public var finishDidLoadImage:FinishDidLoadImage?{
        get{
            
                
            guard let obj = objc_getAssociatedObject(self, &__kfextention_keys.base) as? FinishDidLoadImage else
            {
                return nil
            }
            return obj
            
        }
        set{
            objc_setAssociatedObject(self, &__kfextention_keys.base, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)

        }
    }
}
