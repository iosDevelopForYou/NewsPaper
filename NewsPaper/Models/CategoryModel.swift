struct CategoryModel {
    var emoji: String
    var name: String
    var isSelected: Bool
    
    var title: String {
        return emoji + "  " + name.capitalized
    }
}
