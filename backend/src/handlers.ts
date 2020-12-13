import {Request, response, Response} from 'express';
import {Repository} from "./repository";

export class Handlers {
    private repository = new Repository();

    constructor() {

        let user = {
            username: "test",
            name: "Mary",
            email: "user@example.com",
            password: "lol",
            imagePath: "http://web.ist.utl.pt/ist189407/assets/images/profile_fan.png",
            type: "FAN",
        };

        this.repository.createUser(user);

        let user2 = {
            username: "test2",
            name: "John",
            email: "user@example.com",
            password: "lol",
            imagePath: "http://web.ist.utl.pt/ist189407/assets/images/John.png",
            type: "FAN",
        };

        this.repository.createUser(user2);

        let user3 = {
            username: "test3",
            name: "Isabella",
            email: "user@example.com",
            password: "lol",
            imagePath: "http://web.ist.utl.pt/ist189407/assets/images/Isabella.jpg",
            type: "FAN",
        };

        this.repository.createUser(user3);


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

        this.repository.createConcert( "testartist", {
            name: "James Smith's Concert",
            description: "The long wait is over: Portugal is scheduled to meet with James Smith at Altice Arena, in Lisbon. "
                + "This unique date is part of the European tour scheduled for autumn, which will feature \"I love you\", \ "
                + "the first James Smith’s original album in six years.",
            image: "https://rentalandstaging.net/wp-content/uploads/2015/11/rsn-stage-lights.jpg",
            date:  "December 18, 2020 12:00:00 AM"
        });

        this.repository.purchaseTicket("test",0);
        this.repository.purchaseTicket("test2",0);
        this.repository.purchaseTicket("test3",0);
        this.repository.addNotification("test",{notification:"New concert from James Smith"});
        this.repository.addNotification("test",{notification:"New concert from Guilherme Nunes"});
        this.repository.addNotification("test",{notification:"New concert from Ines Alves"});


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

    addNotification(req: Request, res: Response) {
        let result = this.repository.addNotification(req.params.username, req.body);
        return  result !== undefined ? res.status(200).json(result) :  res.sendStatus(500);

    }

    deleteNotification(req: Request, res: Response) {
        let result = this.repository.deleteNotification(req.params.username, req.body);
        return  result !== undefined ? res.status(200).json(result) :  res.sendStatus(500);

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
                favorites: user.favorites,
                notifications: user.notifications
            }
            res.status(200).json(userToSend); 
        }
        else
            res.sendStatus(403);
    }


    updateUser(req: Request, res: Response) {
        let result = this.repository.updateUser(req.params.username, req.body);

        result !== undefined ? res.status(200).json(result) : res.sendStatus(500);
    }

    startCall(req: Request, res: Response) {
        let result = this.repository.startCall(Number(req.params.id));

        result ? res.sendStatus(200) : res.sendStatus(500);
    }

    endCall(req: Request, res: Response) {
        let result = this.repository.endCall(Number(req.params.id));

        result ? res.sendStatus(200) : res.sendStatus(500);
    }

    follow (req: Request, res: Response) {
        let result = this.repository.followArtist(req.params.username,  req.params.artistUsername);

        result !== undefined ? res.status(200).json(result) : res.sendStatus(500);
    }

    purchaseTicket(req: Request, res: Response) {
        let result = this.repository.purchaseTicket(req.params.username, Number(req.params.id));

        result !== undefined ? res.status(200).json(result) : res.sendStatus(500);
    }

    returnTicket(req: Request, res: Response) {
        let result = this.repository.returnTicket(req.params.username, Number(req.params.id));

        result !== undefined ? res.status(200).json(result) : res.sendStatus(500);
    }


    unfollow (req: Request, res: Response) {
        let result = this.repository.unfollowArtist(req.params.username, req.params.artistUsername);

        result !== undefined ? res.status(200).json(result) : res.sendStatus(500);
    }

    createConcert(req: Request, res: Response) {
        let result = this.repository.createConcert(req.params.username, req.body);
        result ? res.sendStatus(200) : res.sendStatus(500);
    }

    updateConcert(req: Request, res: Response) {
        let result = this.repository.updateConcert(Number(req.params.id), req.body);
        result ? res.sendStatus(200) : res.sendStatus(500);
    }

    startConcert(req: Request, res: Response) {
        let result = this.repository.startConcert(req.params.username, Number(req.params.id));

        result ? res.sendStatus(200) : res.sendStatus(500);
    }

    cancelConcert(req: Request, res: Response) {
        let result = this.repository.cancelConcert(req.params.username, Number(req.params.id));
        result ? res.sendStatus(200) : res.sendStatus(500);
    }

    endConcert(req: Request, res: Response) {
        let result = this.repository.endConcert(req.params.username, Number(req.params.id));
        result ? res.sendStatus(200) : res.sendStatus(500);
    }
    
    getUser(req: Request, res: Response) {
        let result = this.repository.getUser(req.params.username);

        result !== undefined ? res.status(200).json(result) : res.sendStatus(500);
    }

    getUsers(req: Request, res: Response) {
        let result = this.repository.getUsers(req.params.username, Number(req.params.id));

        result !== undefined ? res.status(200).json(result) : res.sendStatus(500);
    }

    getTextChannels(req: Request, res: Response) {
        let channels = this.repository.getTextChannels(req.params.username);
        if (channels !== undefined)
            return res.json(channels);
        else
            return res.json({});
    }

    getVoiceChannels(req: Request, res: Response) {
        let voiceChannels = this.repository.getVoiceChannels(req.params.username);
        if (voiceChannels !== undefined)
            return res.json(voiceChannels);
        else
            return res.json({});
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
  
}