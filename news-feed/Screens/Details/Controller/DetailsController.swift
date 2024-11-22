import UIKit
import SDWebImage

class DetailsController: UIViewController {

    var singleModel: SingleModel? 

    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailDescription: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {

        guard let model = singleModel else { return }

        detailTitle.text = model.title
        detailDescription.text = model.details

        if let imageUrl = model.image, let url = URL(string: imageUrl) {
            detailImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
        } else {
            detailImage.image = UIImage(named: "placeholder")
        }
    }
}
