import Fluent
import Vapor

func routes(_ app: Application) throws {
    //MARK: Groups
    let issues = app.grouped("issues")
    let issue = app.grouped("issue")
    
    //MARK: Issues
    issues.get(":appId") { req async throws in
        let appId = req.parameters.get("appId")
        let issuesQuery = try req.query.decode(IssuesQuery.self)
        
        var forAppId = ""
        
        if let appId = appId {
            forAppId = " for \(appId)"
        }
        
        if let sortOrder = issuesQuery.sortOrder {
            switch sortOrder {

            case .mostRecent:
                return [
                    Issue(title: "The most recent\(forAppId)"),
                    Issue(title: "The second most recent\(forAppId)"),
                ]
            case .mostPopular:
                return [
                    Issue(title: "The most popular\(forAppId)"),
                    Issue(title: "The second most popular\(forAppId)"),
                ]
            }
        }
        
        return [
            Issue(title: "The first created issue\(forAppId)"),
            Issue(title: "The second created issue\(forAppId)"),
        ]
    }
    
    //MARK: Issue    
    issue.post("issue") { req async throws in
        let issue = try req.content.decode(Issue.self)
        return issue
    }

    try app.register(collection: TodoController())
}
