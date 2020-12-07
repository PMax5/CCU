import Express from 'express';
import bodyParser from "body-parser";
import {Handlers} from "./handlers";

export class Server {
    private app = Express();
    private handlers = new Handlers();

    constructor(port: number) {
        this.app.listen(port);
        this.app.use(bodyParser.json());
        console.log("Listening http server on port", port);
    }

    async start() {
        this.app.post("/user/signup", (req, res) => {
            this.handlers.createUser(req, res);
        });

        this.app.post("/user/login", (req, res) => {
            this.handlers.loginUser(req, res);
        });

        this.app.put("/user/:username/update", (req, res) => {
           this.handlers.updateUser(req, res);
        });

        this.app.post("/artist/:username/concerts/new", (req, res) => {
           this.handlers.createConcert(req, res);
        });

        this.app.put("/artist/:username/concerts/:id/update", (req, res) => {
            this.handlers.updateConcert(req, res);
        });

        this.app.get("/artist/:username/concerts", (req, res) => {
            this.handlers.getArtistsConcerts(req, res);
        });

        this.app.get("/concerts", (req, res) => {
            this.handlers.getAllConcerts(req, res);
        });

        this.app.post("/artist/:username/concerts/:id/start", (req, res) => {
            this.handlers.startConcert(req, res);
        });

        this.app.post("/artist/:username/concerts/:id/end", (req, res) => {
            this.handlers.endConcert(req, res);
        });

        this.app.post("/artist/:username/concerts/:id/startVoiceCall", (req, res) => {
           this.handlers.startVoiceCall(req, res);
        });

        this.app.post("/artist/:username/concerts/:id/endVoiceCall", (req, res) => {
           this.handlers.endVoiceCall(req, res);
        });

        this.app.post("/user/:username/concerts/:id/purchaseTicket", (req, res) => {
           this.handlers.purchaseTicket(req, res);
        });

        this.app.post("/concerts/:id/sendMessage", (req, res) => {
           this.handlers.sendConcertMessage(req, res);
        });

        this.app.get("/concerts/:id/messages", (req, res) => {
           this.handlers.loadConcertMessages(req, res);
        });

        this.app.get("/channels/:username/", (req, res) => {
            this.handlers.getConcertChannels(req, res);
        })
        
    }



}