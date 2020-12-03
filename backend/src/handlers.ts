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
        else {

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
            
            loginDetails.password === user.password ? res.status(200).json(userToSend) : res.sendStatus(403);
        }
    }

    updateUser(req: Request, res: Response) {
        let result = this.repository.updateUser(req.params.username, req.body);

        result ? res.sendStatus(200) : res.sendStatus(500);
    }

    createConcert(req: Request, res: Response) {
        this.repository.createConcert(req.params.username, req.body);
        res.sendStatus(200);
    }

    updateConcert(req: Request, res: Response) {
        let result = this.repository.updateConcert(req.params.username, Number(req.params.id), req.body);

        result ? res.sendStatus(200) : res.sendStatus(500);
    }

    startConcert(req: Request, res: Response) {
        let result = this.repository.startConcert(req.params.username, Number(req.params.id));

        result ? res.sendStatus(200) : res.sendStatus(500);
    }

    endConcert(req: Request, res: Response) {
        this.repository.endConcert(req.params.username, Number(req.params.id));
        res.sendStatus(200);
    }

    getArtistsConcerts(req: Request, res: Response) {
        let concerts = this.repository.getArtistConcerts(req.params.username);
        if (concerts !== undefined)
            return res.json(concerts);
        else
            return res.json({});
    }

    getAllConcerts(req: Request, res: Response) {
        let concerts = this.repository.getAllConcerts();

        if (concerts !== undefined)
            return res.json(concerts);
        else
            return res.json({});
    }

    startVoiceCall(req: Request, res: Response) {
        let channel = this.repository.startVoiceCall(req.params.username, Number(req.params.id));

        if (channel !== null) {
            res.json(channel);
        } else {
            res.sendStatus(404);
        }
    }

    sendConcertMessage(req: Request, res: Response) {
        let messages = this.repository.sendConcertMessage(Number(req.params.id), req.body);

        res.json(messages);
    }

    loadConcertMessages(req: Request, res: Response) {
        let messages = this.repository.getConcertMessages(Number(req.params.id));

        res.json(messages);
    }

    endVoiceCall(req: Request, res: Response) {
        let result = this.repository.endVoiceCall(req.params.username, Number(req.params.id));

        result ? res.sendStatus(200) : res.sendStatus(500);
    }

    purchaseTicket(req: Request, res: Response) {
        let result = this.repository.purchaseTicket(req.params.username, Number(req.params.id));

        result ? res.sendStatus(200) : res.sendStatus(500);
    }

}