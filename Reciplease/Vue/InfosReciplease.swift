// MARK: - InfosReciplease
import Foundation

struct InfosReciplease: Codable {
    let from, to, count: Int?
    let links: InfosRecipleaseLinks?
    let hits: [Hit]?

    enum CodingKeys: String, CodingKey {
        case from, to, count
        case links = "_links"
        case hits
    }
}
// MARK: - Hit
struct Hit: Codable {
    let recipe: Recipe?
    let links: HitLinks?

    enum CodingKeys: String, CodingKey {
        case recipe
        case links = "_links"
    }
}

// MARK: - HitLinks
struct HitLinks: Codable {
    let linksSelf: Next?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
    }
}

// MARK: - Next
struct Next: Codable {
    let href: String?
    let title: String?
}

// MARK: - Recipe
struct Recipe: Codable {
    let uri: String?
    let label: String?
    let image: String?
    let images: Images?
    let source: String?
    let url: String?
    let shareAs: String?
    let yield: Int?
    let dietLabels, healthLabels, cautions, ingredientLines: [String]?
    let ingredients: [Ingredient]?
    let calories, totalWeight: Double?
    let totalTime: Int?
    let cuisineType, mealType, dishType: [String]?
    let totalNutrients: TotalNutrients?
    let totalDaily: TotalDaily?
    let digest: [Digest]?
}

// MARK: - Digest
struct Digest: Codable {
    let label, tag: String?
    let schemaOrgTag: String?
    let total: Double?
    let hasRdi: Bool?
    let daily: Double?
    let unit: String?
    let sub: [Sub]?

    enum CodingKeys: String, CodingKey {
        case label, tag, schemaOrgTag, total
        case hasRdi = "hasRDI"
        case daily, unit, sub
    }
}

// MARK: - Sub
struct Sub: Codable {
    let label, tag: String?
    let schemaOrgTag: String?
    let total: Double?
    let hasRdi: Bool?
    let daily: Double?
    let unit: String?

    enum CodingKeys: String, CodingKey {
        case label, tag, schemaOrgTag, total
        case hasRdi = "hasRDI"
        case daily, unit
    }
}

// MARK: - Images
struct Images: Codable {
    let thumbnail, small, regular: Regular?
    let large: Large?

    enum CodingKeys: String, CodingKey {
        case thumbnail = "THUMBNAIL"
        case small = "SMALL"
        case regular = "REGULAR"
        case large = "LARGE"
    }
}

// MARK: - Large
struct Large: Codable {
    let url: String?
    let width, height: Int?
}

// MARK: - Regular
struct Regular: Codable {
    let url: String?
    let width, height: Int?
}

// MARK: - Ingredient
struct Ingredient: Codable {
    let text: String?
    let quantity: Double?
    let measure: String?
    let food: String?
    let weight: Double?
    let foodCategory, foodId: String?
    let image: String?
}

// MARK: - TotalDaily
struct TotalDaily: Codable {
    let enercKcal, fat, fasat, chocdf: CA?
    let fibtg, procnt, chole, na: CA?
    let ca, mg, k, fe: CA?
    let zn, p, vitaRae, vitc: CA?
    let thia, ribf, nia, vitb6A: CA?
    let foldfe, vitb12, vitd, tocpha: CA?
    let vitk1: CA?

    enum CodingKeys: String, CodingKey {
        case enercKcal = "ENERC_KCAL"
        case fat = "FAT"
        case fasat = "FASAT"
        case chocdf = "CHOCDF"
        case fibtg = "FIBTG"
        case procnt = "PROCNT"
        case chole = "CHOLE"
        case na = "NA"
        case ca = "CA"
        case mg = "MG"
        case k = "K"
        case fe = "FE"
        case zn = "ZN"
        case p = "P"
        case vitaRae = "VITA_RAE"
        case vitc = "VITC"
        case thia = "THIA"
        case ribf = "RIBF"
        case nia = "NIA"
        case vitb6A = "VITB6A"
        case foldfe = "FOLDFE"
        case vitb12 = "VITB12"
        case vitd = "VITD"
        case tocpha = "TOCPHA"
        case vitk1 = "VITK1"
    }
}

// MARK: - CA
struct CA: Codable {
    let label: String?
    let quantity: Double?
    let unit: String?
}

// MARK: - TotalNutrients
struct TotalNutrients: Codable {
    let enercKcal, fat, fasat, fatrn: CA?
    let fams, fapu, chocdf: CA?
    let chocdfNet: ChocdfNet?
    let fibtg, sugar, sugarAdded, procnt: CA?
    let chole, na, ca, mg: CA?
    let k, fe, zn, p: CA?
    let vitaRae, vitc, thia, ribf: CA?
    let nia, vitb6A, foldfe, folfd: CA?
    let folac, vitb12, vitd, tocpha: CA?
    let vitk1: CA?
    let sugarAlcohol: ChocdfNet?
    let water: CA?

    enum CodingKeys: String, CodingKey {
        case enercKcal = "ENERC_KCAL"
        case fat = "FAT"
        case fasat = "FASAT"
        case fatrn = "FATRN"
        case fams = "FAMS"
        case fapu = "FAPU"
        case chocdf = "CHOCDF"
        case chocdfNet = "CHOCDF.net"
        case fibtg = "FIBTG"
        case sugar = "SUGAR"
        case sugarAdded = "SUGAR.added"
        case procnt = "PROCNT"
        case chole = "CHOLE"
        case na = "NA"
        case ca = "CA"
        case mg = "MG"
        case k = "K"
        case fe = "FE"
        case zn = "ZN"
        case p = "P"
        case vitaRae = "VITA_RAE"
        case vitc = "VITC"
        case thia = "THIA"
        case ribf = "RIBF"
        case nia = "NIA"
        case vitb6A = "VITB6A"
        case foldfe = "FOLDFE"
        case folfd = "FOLFD"
        case folac = "FOLAC"
        case vitb12 = "VITB12"
        case vitd = "VITD"
        case tocpha = "TOCPHA"
        case vitk1 = "VITK1"
        case sugarAlcohol = "Sugar.alcohol"
        case water = "WATER"
    }
}

// MARK: - ChocdfNet
struct ChocdfNet: Codable {
    let label: String?
    let quantity: Int?
    let unit: String?
}

// MARK: - InfosRecipleaseLinks
struct InfosRecipleaseLinks: Codable {
    let next: Next?
}
