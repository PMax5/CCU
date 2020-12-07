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
            imagePath: "https://s3.amazonaws.com/arc-authors/washpost/e8d90017-3451-40a4-a668-901221acbb76.png",
            type: "FAN",
            concerts: [0]
        };

        this.repository.createUser(user);

        this.repository.createUser({
            username: "testartist",
            name: "Test User 2",
            email: "user2@example.com",
            password: "lol",
            imagePath: "assets/images/mini_james.png",
            type: "ARTIST",
            description: "This is a description ok."
        });

        this.repository.createUser({
            username: "testartist2",
            name: "Iron Maiden",
            email: "user3@example.com",
            password: "lol",
            imagePath: "assets/images/mini_concert2.png",
            type: "ARTIST",
            description: "This is a description ok."
        });

        this.repository.createConcert( "testartist", {
            name: "James Smith's Concert",
            description: "The long wait is over: Portugal is scheduled to meet with James Smith at Altice Arena, in Lisbon. "
                + "This unique date is part of the European tour scheduled for autumn, which will feature \"I love you\", \ "
                + "the first James Smith’s original album in six years.",
            link: "https://www.google.com",
            image: "assets/images/james.png",
            artistName: "Test User 2",
            artistImage: "assets/images/mini_james.png",
            participants: [
                "test"
            ]
        });

        this.repository.createConcert( "testartist2", {
            name: "Iron Maiden's Concert",
            description: "The concert of your life",
            link: "https://www.google.com",
            image: "assets/images/concert2.png",
            artistName: "Iron Maiden",
            artistImage: "assets/images/mini_concert2.png"
        });

        this.repository.createConcert( "testartist", {
            name: "Twenty One Pilots' Concert",
            description: "A Concert",
            link: "https://www.google.com",
            image: "assets/images/concert3.png",
            artistName: "Test User 2",
            artistImage: "assets/images/mini_james.png"
        });

        this.repository.createConcert( "testartist", {
            name: "K.Flay's Concert",
            description: "A Concert",
            link: "https://www.google.com",
            image: "assets/images/concert4.png",
            artistName: "Test User 2",
            artistImage: "assets/images/mini_james.png"
        });

        this.repository.createConcert( "testartist", {
            name: "Lemaitre's Concert",
            description: "A Concert",
            link: "https://www.google.com",
            image: "assets/images/concert5.png",
            artistName: "Test User 2",
            artistImage: "assets/images/mini_james.png"
        });

        this.repository.createConcert( "testartist", {
            name: "y.azz's Concert",
            description: "A Concert",
            link: "https://www.google.com",
            image: "assets/images/concert6.png",
            artistName: "Test User 2",
            artistImage: "assets/images/mini_james.png"
        });

        this.repository.sendConcertMessage(0, {
            message: "Hello there, how is it going!!!",
            author: user
        });

        this.repository.startVoiceCall("testartist", 0);

        this.repository.purchaseTicket( "test", 1 );
    

        console.log("Created default users and concert...");
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

        if (concerts !== undefined){
            return res.json(Array.from(concerts.values()));
        }
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

        console.log(messages);
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

    getConcertChannels(req: Request, res: Response) {
        let channels = this.repository.getConcertChannels(req.params.username);

        if (channels !== undefined)
            return res.status(200).json(channels);

        return res.sendStatus(500);

    }

}