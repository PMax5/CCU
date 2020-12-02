import Express from 'express';
import {Repository} from "./repository";
import bodyParser from "body-parser";
import {Handlers} from "./handlers";

export class Server {
    private app = Express();
    private repository = new Repository();
    private handlers = new Handlers();

    constructor(port: number) {
        this.app.listen(port);
        this.app.use(bodyParser.json());
        console.log("Listening http server on port", port);
    }

    async start() {
        this.app.post("/signup", (req, res) => {
            this.handlers.createUser(req, res);
        });

        this.app.post("/login", (req, res) => {
            this.handlers.loginUser(req, res);
        })
    }



}