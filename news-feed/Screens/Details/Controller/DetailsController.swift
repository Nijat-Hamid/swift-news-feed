import UIKit
import SDWebImage

class DetailsController: UIViewController {

    var singleModel: DetailsUIModel?

    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailDescription: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        guard let model = singleModel else {return}
        
        detailTitle.text = model.title
        detailDescription.text = model.details
        detailImage.sd_setImage(with: model.imageUrl, placeholderImage: UIImage(named: "placeholder"))
    }
}
