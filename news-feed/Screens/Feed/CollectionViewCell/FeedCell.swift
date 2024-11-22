import UIKit
import SDWebImage

class FeedCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var feedImage: UIImageView!

    // Hücre verisini ayarlamak için merkezi bir fonksiyon
    func configureCell(with model: SingleModel) {
        titleLabel.text = model.title ?? "N/A"
        descriptionLabel.text = model.description ?? "N/A"

        if let imageUrl = model.image, let url = URL(string: imageUrl) {
            feedImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
        } else {
            feedImage.image = UIImage(named: "placeholder")
        }
    }
}
