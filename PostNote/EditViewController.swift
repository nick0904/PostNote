


import UIKit
import CoreData

class EditViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var m_textView:UITextView?
    var m_imgView:UIImageView?
    var imgViewBt:UIButton!
    var m_parentObj:HomePageViewController?
    var m_listVC:ListViewController?
    
//MARK: - Normal Function
//-----------------------
    func refreshWithFrame(frame:CGRect, navHeight:CGFloat) {
        
        self.view.frame = frame
        //self.view.backgroundColor = UIColor.darkGrayColor()
        self.gradient(self.view)
        self.title = "新增便利貼"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "回首頁", style: .Plain, target: self, action: #selector(EditViewController.onBarBtAction(_:)))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "重新編輯", style: .Plain, target: self, action: #selector(EditViewController.onBarBtAction(_:)))
        
        //=====================  m_textView  ==========================
        let textViewH:CGFloat = frame.size.width * 0.8
        m_textView = UITextView(frame: CGRect(x: frame.size.width/2 - textViewH/2, y: navHeight + textViewH/5, width: textViewH, height: frame.size.height/4.5))
        m_textView?.backgroundColor = self.view.backgroundColor
        m_textView?.layer.borderColor = UIColor.redColor().CGColor
        m_textView?.layer.borderWidth = 5
        m_textView?.layer.cornerRadius = 10
        m_textView?.clipsToBounds = true
        m_textView?.font = UIFont.italicSystemFontOfSize(m_textView!.frame.size.width/10)
        m_textView?.textColor = UIColor.cyanColor()
        m_textView?.textAlignment = .Center
        self.view.addSubview(m_textView!)
        
        //幫鍵盤加上 "確定"
        let keyToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: navHeight*0.68))
        let doneBt = UIBarButtonItem(title: "確定", style: .Plain, target: self, action: #selector(EditViewController.hieddenKeyBoard))
        let toolBarSpace = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        keyToolBar.setItems([toolBarSpace,doneBt], animated: false)
        m_textView?.inputAccessoryView = keyToolBar
        
        
        //=====================  textViewLogo  ==========================
        let textViewLogoW:CGFloat = m_textView!.frame.size.width/5
        let textViewLogo = UIImageView(frame: CGRect(x: frame.size.width/2 - textViewLogoW/2, y: CGRectGetMinY(m_textView!.frame) - textViewLogoW/2, width: textViewLogoW, height: textViewLogoW))
        textViewLogo.image = UIImage(named: "postit_4.png")
        textViewLogo.layer.shadowColor = UIColor.blackColor().CGColor
        textViewLogo.layer.shadowOffset = CGSize(width: 0.5, height: 3.0)
        textViewLogo.layer.shadowOpacity = 0.8
        self.view.addSubview(textViewLogo)
        
        //=====================  imgViewBoard  =======================
        let imgViewBorderW:CGFloat = textViewH
        let imgViewBorderH:CGFloat = imgViewBorderW * 0.8
        let imgViewBtW:CGFloat = frame.size.width/6
        let imgViewBoard = UIView(frame: CGRect(x: CGRectGetMinX(m_textView!.frame), y: CGRectGetMaxY(m_textView!.frame) + imgViewBtW, width: imgViewBorderW, height: imgViewBorderH))
        imgViewBoard.layer.borderWidth = m_textView!.layer.borderWidth
        imgViewBoard.layer.cornerRadius = m_textView!.layer.cornerRadius
        imgViewBoard.layer.borderColor = UIColor.blueColor().CGColor
        self.view.addSubview(imgViewBoard)
        
        //=====================  m_imgView  ==========================
        let imgViewW:CGFloat = imgViewBorderW * 0.75
        let imgViewH:CGFloat = imgViewBorderH * 0.75
        m_imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: imgViewW, height: imgViewH))
        m_imgView?.center = CGPointMake(CGRectGetMidX(imgViewBoard.frame), CGRectGetMidY(imgViewBoard.frame))
        m_imgView?.image = UIImage(named:"noImg.png")
        m_imgView?.contentMode = .ScaleAspectFit
        m_imgView?.clipsToBounds = true
        self.view.addSubview(m_imgView!)
        
        //=====================  imgViewBt  ==========================
        imgViewBt = UIButton(frame: CGRect(x: frame.size.width/2 - imgViewBtW/2, y:  CGRectGetMinY(imgViewBoard.frame) - imgViewBtW/2, width: imgViewBtW, height: imgViewBtW))
        imgViewBt.setImage(UIImage(named:"postit_10.png" ), forState: .Normal)
        imgViewBt.addTarget(self, action: #selector(EditViewController.onImgViewBtAction(_:)), forControlEvents: .TouchUpInside)
        imgViewBt.showsTouchWhenHighlighted = true
        imgViewBt.layer.shadowColor = UIColor.blackColor().CGColor
        imgViewBt.layer.shadowOffset = CGSize(width: 0.5, height: 3.0)
        imgViewBt.layer.shadowOpacity = 0.8
        self.view.addSubview(imgViewBt)


        //=====================  postBt  ==============================
        let postBtH:CGFloat = frame.size.width/5
        let postBt = UIButton(frame: CGRect(x: 0, y: 0, width: postBtH, height: postBtH))
        postBt.center = CGPoint(x: frame.size.width/2, y: frame.size.height - postBtH/2)
        postBt.setBackgroundImage(UIImage(named: "postit_3.png"), forState: .Normal)
        postBt.addTarget(self, action: #selector(EditViewController.onPostBtAction(_:)), forControlEvents: .TouchUpInside)
        postBt.layer.shadowColor = UIColor.blackColor().CGColor
        postBt.layer.shadowOffset = CGSize(width: 0.5, height: 3.0)
        postBt.layer.shadowOpacity = 0.8
        self.view.addSubview(postBt)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func onBarBtAction(sender:UIBarButtonItem) {
        
        if sender.title == "回首頁" {
            
            if m_parentObj != nil {
                
                self.m_textView?.resignFirstResponder()
                self.m_textView?.text = ""
                self.m_imgView?.image = UIImage(named: "noImg.png")
                m_parentObj?.navigationController?.popViewControllerAnimated(true)
                
            }
        }
        else if sender.title == "重新編輯" {
        
            self.m_textView?.text = ""
            self.m_textView?.resignFirstResponder()
            self.m_imgView?.image = UIImage(named: "noImg.png")
    
        }
    }
    
//MARK: - onImgViewBtAction
//-------------------------
    func onImgViewBtAction(sender:UIButton) {
        
        let pickerImg = UIImagePickerController()
        
        let alert = UIAlertController(title: "選擇圖片", message: "", preferredStyle: .ActionSheet)
        alert.addAction(UIAlertAction(title: "相機", style: .Default, handler: { (camara) -> Void in
            
            if UIImagePickerController.isSourceTypeAvailable(.Camera) {
                
                pickerImg.sourceType = .Camera
                pickerImg.delegate = self
                pickerImg.allowsEditing = true
                self.presentViewController(pickerImg, animated: true, completion: nil)
            
            }
            else {
                
                self.alertShow("您的裝置無相機功能")
            }
            
        }))
        
        alert.addAction(UIAlertAction(title: "相簿", style: .Default, handler: { (library) -> Void in
            
            if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
                
                pickerImg.sourceType = .PhotoLibrary
                pickerImg.delegate = self
                pickerImg.allowsEditing = true
                self.presentViewController(pickerImg, animated: true, completion: nil)

            }
            else {
                
                self.alertShow("您的裝置無相簿")
            }
            
        }))
        
        alert.addAction(UIAlertAction(title: "取消", style: .Destructive, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
//MARK: - UIImagePickerController Delegate
//----------------------------------------
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        let img = info[UIImagePickerControllerEditedImage] as? UIImage
        let theSize:CGSize = CGSizeMake(self.view.frame.size.width,self.view.frame.size.width)
        UIGraphicsBeginImageContextWithOptions(theSize, true, 2)
        let rect:CGRect = CGRect(x: 0, y: 0, width: theSize.width, height: theSize.height)
        img?.drawInRect(rect)
        m_imgView?.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndPDFContext()

        
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
//MARK: - onPostBtAction
//----------------------
    
    var m_note:Note!
    
    func onPostBtAction(sender:UIButton) {
        
        let alert = UIAlertController(title: "儲存便利貼 ?", message:"", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "取消", style: .Default, handler: nil))
        
        alert.addAction(UIAlertAction(title: "儲存", style: .Destructive, handler: { (action) -> Void in
            
            if self.m_textView!.text == "" {
                
                self.alertShow("請先輸入文字  再儲存")
                return
            }
            
            if let manageObjectContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext {
                
                self.m_note = NSEntityDescription.insertNewObjectForEntityForName("Note", inManagedObjectContext: manageObjectContext) as! Note
                
                self.m_note.noteContext = self.m_textView!.text
                
                if let _pic = self.m_imgView!.image {
                    
                    //轉行成 NSData 儲存
                    self.m_note.noteImage = UIImagePNGRepresentation(_pic)!
                }
                
                do {
                    
                    try manageObjectContext.save()
                    
                    let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0.25 * Double(NSEC_PER_SEC)))
                    dispatch_after(delayTime, dispatch_get_main_queue(), { 
                        
                        self.saveFinish()
                    })
                    
                }catch{
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        
                        self.showSaveMessage("儲存失敗")
                    })

                    
                }

            }

            
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        m_textView?.resignFirstResponder()
    }
    
//MARK: - svaeFinish
//------------------
    func saveFinish() {
        
        self.m_imgView?.image = UIImage(named: "noImg.png")
        self.m_textView?.text = ""
        
        if m_listVC == nil {
            
            m_listVC = ListViewController()
            m_listVC?.refreashWithFrame(self.view.frame)
        }
        
        self.navigationController?.pushViewController(m_listVC!, animated: true)
        
    }
 
    
//MARK: - showSaveMessage
//-----------------------
    var _view:UIView!
    var _label:UILabel!
    
    func  showSaveMessage(message:String) {
        
        if _view == nil {
            
            _view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width/3, height: self.view.frame.size.width/3))
            _view.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/3)
            _view.backgroundColor = UIColor.orangeColor()
            _view.alpha = 0.98
            _view.layer.cornerRadius = _view.frame.size.width/15
            _view.clipsToBounds = true
            self.view.addSubview(_view)
        }

        if _label == nil {
            
            _label = UILabel(frame: _view.frame)
            _label.center = _view.center
            _label.text = message
            _label.textColor = UIColor.whiteColor()
            _label.textAlignment = .Center
            _label.font = UIFont.boldSystemFontOfSize(_label.frame.size.height/5)
            _label.adjustsFontSizeToFitWidth = true
            _label.layer.cornerRadius = _view.frame.size.width/15
            _label.clipsToBounds = true
            self.view.addSubview(_label)
        }
        
        UIView.animateWithDuration(0.05, delay: 0.0, options: .CurveLinear, animations: {
            
            self._view.alpha = 0.58
            self._label.alpha = 1.0
            self.performSelector(#selector(EditViewController.dismissSaveMessage), withObject: nil, afterDelay: 0.68)
            
            }, completion: nil)
        
    }
    
//MARK: - dismissSaveMessage
//--------------------------
    func dismissSaveMessage() {
        
        UIView.animateWithDuration(0.58, delay: 0.0, options: .CurveLinear, animations: {
            
            self._view.alpha = 0.0
            self._label.alpha = 0.0
            //self.performSelector(#selector(EditViewController.saveFinish), withObject: nil, afterDelay: 0.6)
            
        }, completion: nil)
        
    }
    
//MARK: - alertShow
//-----------------
    func alertShow(message:String) {
        
        let alert = UIAlertController(title: message, message: "", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "確定", style: .Destructive, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
//MARK: - hieddenKeyBoard
//--------------------
    func hieddenKeyBoard() {
        
        self.m_textView?.resignFirstResponder()
    }
    
    
//MARK: - gradient 漸層顏色 (圓形)
//------------------------------
    func gradient(view:UIView){
        
        let color1 = UIColor(red: 1.0, green: 1.0, blue: 0.5, alpha: 1.0)
        let color2 = UIColor.darkGrayColor()
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        gradient.colors = [color2.CGColor,color1.CGColor]
        view.layer.insertSublayer(gradient, atIndex: 0)
    }
    
}//end class


