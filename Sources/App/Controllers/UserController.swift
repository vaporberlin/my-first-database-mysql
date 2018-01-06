final class UserController {
  let drop: Droplet
  
  init(drop: Droplet) {
    self.drop = drop
  }
  
  func list(_ req: Request) throws -> ResponseRepresentable {
    let list = try User.all()
    return try drop.view.make("userview", ["userlist": list.makeNode(in: nil)])
  }
  
  func create(_ req: Request) throws -> ResponseRepresentable {
    guard let username = req.data["username"]?.string else {
      return Response(status: .badRequest)
    }
    
    let user = User(username: username)
    try user.save()
    return Response(redirect: "/user")
  }
}
