

import UIKit

class MyTableViewCell: UITableViewCell {
    
    var m_imgView:UIImageView?
    var m_contextLabel:UILabel?
    
    func refreashWithFrame(cellframe:CGRect) {
        
        self.frame = cellframe
        self.backgroundColor = UIColor.clearColor()
        
        //=====================  m_imgView  =========================
        let imgViewH:CGFloat = cellframe.size.height/3*2
        m_imgView = UIImageView(frame: CGRect(x: cellframe.size.width/2 - imgViewH/2, y: 5, width: imgViewH, height: imgViewH))
        m_imgView?.layer.cornerRadius = m_imgView!.frame.size.width/2
        m_imgView?.contentMode = UIViewContentMode.ScaleAspectFill
        m_imgView?.clipsToBounds = true
        self.addSubview(m_imgView!)
        
        //=====================  m_contextLabel  =========================
        m_contextLabel = UILabel(frame: CGRect(x: 0, y: CGRectGetMaxY(m_imgView!.frame), width: cellframe.size.width, height: cellframe.size.height/3))
        //m_contextLabel?.backgroundColor = UIColor(red: 0.0, green: 0.65, blue: 0.65, alpha: 1.0)
        m_contextLabel?.textColor = UIColor.whiteColor()
        m_contextLabel?.textAlignment = .Center
        self.addSubview(m_contextLabel!)
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
