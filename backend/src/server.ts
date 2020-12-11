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


        this.app.post("/user/:username/follow/:artistUsername", (req, res) => {
           this.handlers.follow(req, res);
        });


        this.app.post("/user/:username/unfollow/:artistUsername", (req, res) => {
           this.handlers.unfollow(req, res);
        });

        this.app.post("/artist/:username/concerts/new", (req, res) => {
           this.handlers.createConcert(req, res);
        });

        this.app.get("/artist/:username/concerts", (req, res) => {
            this.handlers.getArtistsConcerts(req, res);
        });

        this.app.get("/concerts", (req, res) => {
            this.handlers.getAllConcerts(req, res);
        });

    }



}