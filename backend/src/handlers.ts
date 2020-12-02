import {Request, response, Response} from 'express';
import {Repository} from "./repository";

export class Handlers {
    private repository = new Repository();

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
        else
            loginDetails.password === user.password ? res.sendStatus(200) : res.sendStatus(403);
    }
}