import {Request, response, Response} from 'express';
import {Repository} from "./repository";

export class Handlers {
    private repository = new Repository();

    constructor() {

        let user = {
            username: "test",
            name: "Test User",
            email: "user@example.com",
            password: "lol",
            imagePath: "http://web.ist.utl.pt/ist189407/assets/images/profile_fan.png",
            type: "FAN",
            concerts: [0]
        };

        this.repository.createUser(user);

        this.repository.createUser({
            username: "testartist",
            name: "Test User 2",
            email: "user2@example.com",
            password: "lol",
            imagePath: "http://web.ist.utl.pt/ist189407/assets/images/profile_artist.png",
            type: "ARTIST",
            description: "This is a description ok."
        });

        this.repository.createUser({
            username: "testartist2",
            name: "Iron Maiden",
            email: "user3@example.com",
            password: "lol",
            imagePath: "http://web.ist.utl.pt/ist189407/assets/images/mini_concert2.png",
            type: "ARTIST",
            description: "This is a description ok."
        });
    

        console.log("Created default users ...");
    }

    createUser(req: Request, res: Response) {
        let user = req.body;

        if (this.repository.getUser(user.username) === undefined) {
            this.repository.createUser(req.body);
            return res.sendStatus(200);
        }

        return res.status(500).send("User already exists.");
    }

    loginUser(req: Request, res: Response) {
        let loginDetails = req.body;
        let user = this.repository.getUser(loginDetails.username);

        if (user === undefined)
            return res.status(500).send("Username does not exist.");
        else if (loginDetails.password === user.password) {
            let userToSend = {
                username: user.username,
                name: user.name,
                email: user.email,
                imagePath: user.imagePath,
                description: user.description,
                type: user.type,
                concerts: user.concerts,
                favorites: user.favorites
            }
            res.status(200).json(userToSend) 
        }
        else
            res.sendStatus(403);
    }

    createConcert(req: Request, res: Response) {
        this.repository.createConcert(req.params.username, req.body);
        res.sendStatus(200);
    }
  
}