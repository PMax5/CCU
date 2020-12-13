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

        this.app.get("/user/:username", (req, res) => {
            this.handlers.getUser(req, res);
        })

        this.app.put("/user/:username/update", (req, res) => {
           this.handlers.updateUser(req, res);
        });

        this.app.post("/user/:username/concerts/:id/purchaseTicket", (req, res) => {
           this.handlers.purchaseTicket(req, res);
        });

        this.app.post("/user/:username/concerts/:id/returnTicket", (req, res) => {
           this.handlers.returnTicket(req, res);
        });

        this.app.post("/user/:username/follow/:artistUsername", (req, res) => {
           this.handlers.follow(req, res);
        });


        this.app.post("/user/:username/unfollow/:artistUsername", (req, res) => {
           this.handlers.unfollow(req, res);
        });

        this.app.post("/artist/:username/concerts/new", (req, res) => {
           this.handlers.createConcert(req, res);
        });

        this.app.put("/concerts/:id/update", (req, res) => {
            this.handlers.updateConcert(req, res);
         });

        this.app.put("/concerts/:id/startCall", (req, res) => {  
            this.handlers.startCall(req, res);
         });
        this.app.put("/concerts/:id/endCall", (req, res) => {  
            this.handlers.endCall(req, res);
     });


        this.app.post("/artist/:username/concerts/:id/start", (req, res) => {
            this.handlers.startConcert(req, res);
        });

        this.app.post("/artist/:username/concerts/:id/end", (req, res) => {
            this.handlers.endConcert(req, res);
        });

        this.app.post("/artist/:username/concerts/:id/cancel", (req, res) => {
            this.handlers.cancelConcert(req, res);
        });

        this.app.get("/user/:username/channels", (req, res) => {
            this.handlers.getTextChannels(req, res);
        });

        this.app.get("/user/:username/voiceChannels", (req, res) => {
            this.handlers.getVoiceChannels(req, res);
        });
        
        this.app.get("/user/:username/voicecall/:id", (req, res) => {
            this.handlers.getUsers(req, res);
        });
      

        this.app.get("/artist/:username/concerts", (req, res) => {
            this.handlers.getArtistsConcerts(req, res);
        });

        this.app.get("/concerts", (req, res) => {
            this.handlers.getAllConcerts(req, res);
        });



    }



}