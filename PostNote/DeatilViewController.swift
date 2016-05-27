

import UIKit

class DeatilViewController: UIViewController {
    
    var m_imgView:UIImageView?
    var m_textView:UITextView?
    var m_parentObj:ListViewController?
    
//MARK: - Normal Function
//-----------------------
    func resreashWithFrame(frame:CGRect,navHeight:CGFloat) {
        
        self.view.frame = frame
        self.view.backgroundColor = UIColor.brownColor()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Action , target: self, action: #selector(DeatilViewController.shareItem(_:)))
    
        let backgroundImgViewW:CGFloat = frame.size.width * 0.95
        let imgViewW:CGFloat = backgroundImgViewW * 0.8
        let space = imgViewW/12
        let theScale:CGFloat =  550/350
        
        //=====================  backgroundImgView  ======================
        let backgroundImgView = UIImageView(frame: CGRect(x: frame.size.width/2 - backgroundImgViewW/2, y: navHeight + space, width: backgroundImgViewW, height: backgroundImgViewW * theScale))
        backgroundImgView.image = UIImage(named: "postit_11.png")
        backgroundImgView.layer.shadowColor = UIColor.blackColor().CGColor
        backgroundImgView.layer.shadowOffset = CGSizeMake(3.0, 10.0)
        backgroundImgView.layer.shadowOpacity = 0.88
        self.view.addSubview(backgroundImgView)
        
        //=====================  m_imgView  ==============================
        m_imgView = UIImageView(frame: CGRect(x: frame.size.width/2 - imgViewW/2, y: CGRectGetMinY(backgroundImgView.frame) + 3*space, width: imgViewW, height: imgViewW))
        m_imgView?.contentMode = .ScaleAspectFit
        m_imgView?.clipsToBounds = true
        self.view.addSubview(m_imgView!)
        
        //=====================  m_textView  ==============================
        m_textView = UITextView(frame: CGRect(x: frame.size.width/2 - imgViewW/2, y: CGRectGetMaxY(m_imgView!.frame) + 10, width: imgViewW, height: (CGRectGetHeight(backgroundImgView.frame) - CGRectGetHeight(m_imgView!.frame)) * 0.65 ))
        m_textView?.backgroundColor = UIColor.clearColor()
        m_textView?.textColor = UIColor.blueColor()
        m_textView?.editable = false
        m_textView?.font = UIFont.italicSystemFontOfSize(m_textView!.frame.size.height/8)
        m_textView?.clipsToBounds = true
        m_textView?.showsVerticalScrollIndicator = true
        m_textView?.showsHorizontalScrollIndicator = false
        m_textView?.textAlignment = .Center
        self.view.addSubview(m_textView!)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//MARK: - shareItem
//-----------------
    func shareItem(sender:UIBarButtonItem) {
        
        
        if m_parentObj != nil {
            
            m_parentObj?.shareMyNote(m_textView!.text, img: m_imgView!.image)
        }
        
    }
    
    

}
