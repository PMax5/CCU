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

    startVoiceCall(req: Request, res: Response) {
        let result = this.repository.startVoiceCall(req.params.username, Number(req.params.id));

        result ? res.sendStatus(200) : res.sendStatus(500);
    }

    purchaseTicket(req: Request, res: Response) {

    }

}