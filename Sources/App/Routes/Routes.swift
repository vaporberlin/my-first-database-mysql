import Vapor

extension Droplet {
  func setupRoutes() throws {
    
    let userController = UserController(drop: self)
    get("user", handler: userController.list)
    post("user", handler: userController.create)
  }
}
