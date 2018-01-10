//
//  LoginViewController.swift
//  map
//
//  Created by   chironyf on 2017/8/13.
//  Copyright © 2017年 chironyf. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var loginBtn: UIButton!
    var regisBtn: UIButton!
    
    //用户密码输入框
    var txtUser: UITextField!
    var txtPwd: UITextField!
    
    //左手离脑袋的距离
    var offsetLeftHand: CGFloat = 60
    
    //左手图片,右手图片(遮眼睛的)
    var imgLeftHand: UIImageView!
    var imgRightHand: UIImageView!
    
    //左手图片,右手图片(圆形的)
    var imgLeftHandGone: UIImageView!
    var imgRightHandGone: UIImageView!
    
    //获取屏幕尺寸
    let mainSize = UIScreen.main.bounds.size
    //登录框状态
    var showType: LoginShowType = LoginShowType.none

    override func viewDidLoad() {
        super.viewDidLoad()
            
        //猫头鹰头部
        let imgLogin =  UIImageView(frame:CGRect(x: mainSize.width/2-211/2, y: 100, width: 211, height: 109))
        imgLogin.image = UIImage(named:"owl-login")
        imgLogin.layer.masksToBounds = true
        self.view.addSubview(imgLogin)
        
        //猫头鹰左手(遮眼睛的)
        let rectLeftHand = CGRect(x: 61 - offsetLeftHand, y: 90, width: 40, height: 65)
        imgLeftHand = UIImageView(frame:rectLeftHand)
        imgLeftHand.image = UIImage(named:"owl-login-arm-left")
        imgLogin.addSubview(imgLeftHand)
        
        //猫头鹰右手(遮眼睛的)
        let rectRightHand = CGRect(x: imgLogin.frame.size.width / 2 + 60, y: 90, width: 40, height: 65)
        imgRightHand = UIImageView(frame:rectRightHand)
        imgRightHand.image = UIImage(named:"owl-login-arm-right")
        imgLogin.addSubview(imgRightHand)
        
        //登录框背景
        let vLogin =  UIView(frame:CGRect(x: 15, y: 200, width: mainSize.width - 30, height: 160))
        vLogin.layer.borderWidth = 0.5
        vLogin.layer.borderColor = UIColor.lightGray.cgColor
        vLogin.backgroundColor = UIColor.white
        self.view.addSubview(vLogin)
        
        //猫头鹰左手(圆形的)
        let rectLeftHandGone = CGRect(x: mainSize.width / 2 - 100,
                                      y: vLogin.frame.origin.y - 22, width: 40, height: 40)
        imgLeftHandGone = UIImageView(frame:rectLeftHandGone)
        imgLeftHandGone.image = UIImage(named:"icon_hand")
        self.view.addSubview(imgLeftHandGone)
        
        //猫头鹰右手(圆形的)
        let rectRightHandGone = CGRect(x: mainSize.width / 2 + 62,
                                       y: vLogin.frame.origin.y - 22, width: 40, height: 40)
        imgRightHandGone = UIImageView(frame:rectRightHandGone)
        imgRightHandGone.image = UIImage(named:"icon_hand")
        self.view.addSubview(imgRightHandGone)
        
        //用户名输入框
        txtUser = UITextField(frame:CGRect(x: 30, y: 30, width: vLogin.frame.size.width - 60, height: 44))
        txtUser.delegate = self
        txtUser.layer.cornerRadius = 5
        txtUser.layer.borderColor = UIColor.lightGray.cgColor
        txtUser.layer.borderWidth = 0.5
        txtUser.leftView = UIView(frame:CGRect(x: 0, y: 0, width: 44, height: 44))
        txtUser.leftViewMode = UITextFieldViewMode.always
        
        //用户名输入框左侧图标
        let imgUser =  UIImageView(frame:CGRect(x: 11, y: 11, width: 22, height: 22))
        imgUser.image = UIImage(named:"iconfont-user")
        txtUser.leftView!.addSubview(imgUser)
        vLogin.addSubview(txtUser)
        
        //密码输入框
        txtPwd = UITextField(frame:CGRect(x: 30, y: 90, width: vLogin.frame.size.width - 60, height: 44))
        txtPwd.delegate = self
        txtPwd.layer.cornerRadius = 5
        txtPwd.layer.borderColor = UIColor.lightGray.cgColor
        txtPwd.layer.borderWidth = 0.5
        txtPwd.isSecureTextEntry = true
        txtPwd.leftView = UIView(frame:CGRect(x: 0, y: 0, width: 44, height: 44))
        txtPwd.leftViewMode = UITextFieldViewMode.always
        
        //密码输入框左侧图标
        let imgPwd =  UIImageView(frame:CGRect(x: 11, y: 11, width: 22, height: 22))
        imgPwd.image = UIImage(named:"iconfont-password")
        txtPwd.leftView!.addSubview(imgPwd)
        vLogin.addSubview(txtPwd)
        
        loginBtn = UIButton(frame: CGRect(x: 50, y: 400, width: mainSize.width - 100, height: 44))
        loginBtn.backgroundColor = UIColor.brown
        loginBtn.setTitle("登录", for: .normal)
        loginBtn.setTitleColor(UIColor.darkGray, for: .highlighted)
        loginBtn.addTarget(self, action: #selector(LoginViewController.loginTouched), for: .touchUpInside)
        self.view.addSubview(loginBtn)
        
        regisBtn = UIButton(frame: CGRect(x: 50, y: 460, width: mainSize.width - 100, height: 44))
        regisBtn.backgroundColor = UIColor.brown
        regisBtn.setTitle("注册", for: .normal)
        regisBtn.setTitleColor(UIColor.darkGray, for: .highlighted)
        self.view.addSubview(regisBtn)
        
        txtUser.text = student_id
        txtPwd.text = psw
        
    }

    //输入框获取焦点开始编辑
    func textFieldDidBeginEditing(_ textField:UITextField)
    {
        //如果当前是用户名输入
        if textField.isEqual(txtUser){
            if (showType != LoginShowType.pass)
            {
                showType = LoginShowType.user
                return
            }
            showType = LoginShowType.user
            
            //播放不遮眼动画
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                self.imgLeftHand.frame = CGRect(
                    x: self.imgLeftHand.frame.origin.x - self.offsetLeftHand,
                    y: self.imgLeftHand.frame.origin.y + 30,
                    width: self.imgLeftHand.frame.size.width, height: self.imgLeftHand.frame.size.height)
                self.imgRightHand.frame = CGRect(
                    x: self.imgRightHand.frame.origin.x + 48,
                    y: self.imgRightHand.frame.origin.y + 30,
                    width: self.imgRightHand.frame.size.width, height: self.imgRightHand.frame.size.height)
                self.imgLeftHandGone.frame = CGRect(
                    x: self.imgLeftHandGone.frame.origin.x - 70,
                    y: self.imgLeftHandGone.frame.origin.y, width: 40, height: 40)
                self.imgRightHandGone.frame = CGRect(
                    x: self.imgRightHandGone.frame.origin.x + 30,
                    y: self.imgRightHandGone.frame.origin.y, width: 40, height: 40)
            })
        }
            //如果当前是密码名输入
        else if textField.isEqual(txtPwd){
            if (showType == LoginShowType.pass)
            {
                showType = LoginShowType.pass
                return
            }
            showType = LoginShowType.pass
            
            //播放遮眼动画
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                self.imgLeftHand.frame = CGRect(
                    x: self.imgLeftHand.frame.origin.x + self.offsetLeftHand,
                    y: self.imgLeftHand.frame.origin.y - 30,
                    width: self.imgLeftHand.frame.size.width, height: self.imgLeftHand.frame.size.height)
                self.imgRightHand.frame = CGRect(
                    x: self.imgRightHand.frame.origin.x - 48,
                    y: self.imgRightHand.frame.origin.y - 30,
                    width: self.imgRightHand.frame.size.width, height: self.imgRightHand.frame.size.height)
                self.imgLeftHandGone.frame = CGRect(
                    x: self.imgLeftHandGone.frame.origin.x + 70,
                    y: self.imgLeftHandGone.frame.origin.y, width: 0, height: 0)
                self.imgRightHandGone.frame = CGRect(
                    x: self.imgRightHandGone.frame.origin.x - 30,
                    y: self.imgRightHandGone.frame.origin.y, width: 0, height: 0)
            })
        }
    }
    
    //进入主界面
    func loginTouched() {
        
        guard let userID = txtUser.text, let password = txtPwd.text else {
            print("none")
            return
        }
        
        student_id = userID
        psw = password
        
        let parameters: Parameters = [
            "student_id": student_id,
            "password": psw
        ]
        
        //提交教务信息进行验证
        Alamofire.request(LOGIN_URL, method: .post, parameters: parameters).responseJSON {
            response in
            guard let dataStream = response.data else {
                print("nil")
                return
            }
            print(dataStream)
            var json = JSON(data: dataStream)
            if json["des"] == "教务密码错误" {
                print("输入错误")
            } else {
                print(json)
                
//                let name = vc.view.viewWithTag(112) as? UILabel
//                print("根据tag值获取的name = \(name)")
////                let tempName = json["value"]["jiaowu"]["0"]["2"].stringValue
////                let start = tempName.index(tempName.start, offsetBy: 3)
//                name!.text = json["value"]["jiaowu"]["0"]["2"].stringValue.substring(from: json["value"]["jiaowu"]["0"]["2"].stringValue.index(json["value"]["jiaowu"]["0"]["2"].stringValue.startIndex, offsetBy: 3))
//                print("name = \(name!.text)")
                _token = json["value"]["server"][0][0]["token"].stringValue
                id = json["value"]["server"][0][0]["id"].stringValue
         
                
            }
        }
        
        let sb = UIStoryboard(name: "Main", bundle:nil)
        let vc = sb.instantiateViewController(withIdentifier: STBVCIdentifier.mainTabBarID)
        self.present(vc, animated: true, completion: nil)
        
    }
    
    //键盘回收= return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print(textField.text!)
        return true
    }
    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        txtUser.resignFirstResponder()
//        txtPwd.resignFirstResponder()
//        print(txtUser.text!)
//        print(txtPwd.text!)
//
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}



//登录框状态枚举
enum LoginShowType {
    case none
    case user
    case pass
}
