//
//  LostPostViewControllerViewController.swift
//  HFUTXhining
//
//  Created by   chironyf on 2017/8/23.
//  Copyright © 2017年 chironyf. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ObjectiveC
import ZLPhotoBrowser

class LostAndFoundPostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    @IBOutlet weak var postNavigationView: UIView!
    
    @IBOutlet weak var cancelView: UIImageView!
    
    @IBOutlet weak var postView: UIImageView!
    
    @IBOutlet weak var userHeadView: UIImageView!
    
    @IBOutlet weak var positionTxt: UITextField!

    @IBOutlet weak var timeTxt: UITextField!
    
    @IBOutlet weak var resTxt: UITextField!
    //选择图片的区域
    @IBOutlet weak var resImages: UIView!
    
    @IBOutlet weak var anonymousLabel: UILabel!
    
    @IBOutlet weak var anonymousSwitch: UISwitch!
    
    @IBOutlet weak var keyboardTopBar: UIView!
    
    @IBOutlet weak var addPhoto: UIImageView!
    
    @IBOutlet weak var addEmoji: UIImageView!
    
    //当前是失物还是寻物
    @IBOutlet weak var lostOrFound: UILabel!
    
    //对外接口, 默认为寻物启事(lost)
    var isFound: Bool = false
    
    var contentPosted: Bool = false
    
    var currentImgsSelected: Int = 0
    
    //保存在相册中选择的图片数组
    var _imageArray: Array<UIImage> = []
    
    //module and title, 默认为寻物启事
    var currentModule: Int = UserPostModule.lostPostAndFoundPost.rawValue
    
    var currentTitle: Int = UserPostTitle.lost.rawValue

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        positionTxt.layer.borderWidth = 1
        positionTxt.layer.borderColor = RED_COLOR.cgColor
        positionTxt.textColor = RED_COLOR
        
        timeTxt.layer.borderWidth = 1
        timeTxt.layer.borderColor = RED_COLOR.cgColor
        timeTxt.textColor = RED_COLOR
        
        resTxt.layer.borderWidth = 1
        resTxt.layer.borderColor = RED_COLOR.cgColor
        resTxt.textColor = RED_COLOR
        
        resImages.layer.borderWidth = 1
        resImages.layer.borderColor = RED_COLOR.cgColor
        
        let cancelTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.cancelTap(_:)))
        cancelView?.isUserInteractionEnabled = true
        cancelView?.addGestureRecognizer(cancelTapGesture)
        
        let postTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.postTap(_:)))
        postView?.isUserInteractionEnabled = true
        postView?.addGestureRecognizer(postTapGesture)
        // Do any additional setup after loading the view.
        
        if isFound == true {
            self.lostOrFound.text = "#失物招领"
            self.currentTitle = UserPostTitle.found.rawValue
        } else {
            self.lostOrFound.text = "#寻物启事"
            self.currentTitle = UserPostTitle.lost.rawValue
        }
        
        createSubViews()
        
    }
    
    //发帖按钮 + 发送图片
    func postTap(_ sender: UITapGestureRecognizer) {
        
        let contentDictionary: [String: String] = [
            "lostTime": "\(timeTxt.text!)",
            "lostIn": "\(positionTxt.text!)",
            "lostThing": "\(resTxt.text!)"
        ]
        
        var parameters: Parameters = [
            "id": id,
            "student_id": student_id,
            "token": _token,
            "niming": anonymousSwitch.isOn,
            "module": self.currentModule,
            "title": self.currentTitle,
        ]
        if let theJSONData = try? JSONSerialization.data(
            withJSONObject: contentDictionary,
            options: []) {
            let theJSONText = String(data: theJSONData,
                                     encoding: .ascii)
            parameters["content"] = theJSONText
            print("JSON string = \(theJSONText!)")
        }
        
        print("当前令牌\(_token)")
        
        Alamofire.request(POST_URL, method: .post, parameters: parameters).responseJSON {
            response in
            guard let dataStream = response.data else {
                print("nil")
                return
            }
            print(JSON(data: dataStream))
            let tempJson = JSON(data: dataStream)
            
            let aid = tempJson["value"][0][0]["article_id"].stringValue
            print("文章编号是: \(aid)")
            
            // 上传文本结束
            
            let params: Parameters = [
                "id": id,
                "student_id": student_id,
                "token": _token,
                "niming": "\(self.anonymousSwitch.isOn)",
                "article_id": aid
            ]
            
            //            print("==========开始上传图片, 当前上传的图片集是\(self._imageArray)")
            
            Alamofire.upload(multipartFormData:{ (multipartFormData) in
                var imgName = 1
                for img in self._imageArray {
                    multipartFormData.append(UIImageJPEGRepresentation(img, 0.1)!, withName: "\(imgName)", fileName: "file\(imgName).jpeg", mimeType: "image/jpeg")
                    imgName += 1
                }
                for (key, value) in params {
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
            }, to:POST_IMAGE_URL, headers:nil) { (result) in
                switch result {
                case .success(let upload, _, _):
                    upload.uploadProgress(closure: { (progress) in
                        print(progress)
                    })
                    upload.responseJSON { response in
                        if response.result.value != nil {
                            print("success")
                            print("图片上传结果\(JSON(data: response.data!))")
                            //                            print("(((((当前上传成功图片==\(img)")
                        }
                    }
                case .failure(_):
                    break
                }
                //上传完毕, 关闭发帖框
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func createSubViews(){
        //
        for sview in self.resImages.subviews {
            sview.removeFromSuperview()
        }
        
        let spece = 10.0 as CGFloat
        let width = (self.resImages.bounds.size.width - CGFloat(spece) * CGFloat(4)) / 3
        
        //显示选择的图片
        currentImgsSelected = 0
        for img in _imageArray {
            let imageV = UIImageView.init(frame: CGRect.init(x: spece + CGFloat(currentImgsSelected % 3) * (width + spece), y: spece + CGFloat(currentImgsSelected / 3) * (width + spece), width: width, height: width))
            imageV.image = img
            imageV.layer.cornerRadius = 4
            imageV.layer.masksToBounds = true
            imageV.contentMode = .scaleAspectFill
            imageV.isUserInteractionEnabled = true
            //            print("iiiiiiiiiiimmmmmmmmmmmmm本次加载的图片是\(img)")
            self.resImages.addSubview(imageV)
            
            //给每一张图片右上角添加删除按钮, 并添加tag值用于删除图片
            let btn = UIButton.init(type: UIButtonType.system)
            btn.frame = CGRect.init(x: imageV.bounds.size.width - 20, y: 0, width: 20, height: 20)
            imageV.addSubview(btn)
            
            btn.tag = 100 + currentImgsSelected
            btn.addTarget(self, action: #selector(deleBtnAction), for: UIControlEvents.touchUpInside)
            btn.setBackgroundImage(UIImage.init(named: "button_icon_close"), for: UIControlState.normal)
            currentImgsSelected += 1
        }
        print("选择图片加载成功")
        //移动加号按钮
        if _imageArray.count < IMG_MAX_MAOUNT {
            let btn = UIButton.init(type: UIButtonType.system)
            btn.frame = CGRect.init(x: spece + CGFloat(currentImgsSelected % 3) * (width + spece), y: spece + CGFloat(currentImgsSelected / 3) * (width + spece), width: width, height: width)
            self.resImages.addSubview(btn)
            
            btn.addTarget(self, action: #selector(self.test(_:)), for: UIControlEvents.touchUpInside)
            btn.setBackgroundImage(UIImage.init(named: "btn_add_photo_s"), for: UIControlState.normal)
        }
    }
    
    func deleBtnAction(btn: UIButton) {
        _imageArray.remove(at: btn.tag - 100);
        createSubViews();
    }
    
    func test(_ sender: UITapGestureRecognizer) {
        let ac = ZLPhotoActionSheet()
        ac.maxPreviewCount = 20
        ac.maxSelectCount = 9
        ac.sender = self
        ac.selectImageBlock = {(_ images: [UIImage], assets: [PHAsset], isOriginal: Bool) -> Void in
            self._imageArray += images
            self.createSubViews()
        }
        ac.showPreview(animated: true, sender: self)
    }
    
    //左上角取消按钮
    func cancelTap(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //键盘回收= 其他地方
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if timeTxt.resignFirstResponder() == true {
//            print(userTextView.text)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
