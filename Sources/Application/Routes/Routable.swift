import Kitura

protocol Routable {
    func register(in router: Router)
}
